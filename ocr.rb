require_relative 'lib/policy_ocr'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby main.rb path/to/textfile.txt [--output path/to/output.txt]"

  opts.on("--output FILE", "Optional output file to write account numbers") do |file|
    options[:output] = file
  end
end.parse!

if ARGV.empty?
  puts "Usage: ruby main.rb path/to/textfile.txt [--output path/to/output.txt]"
  exit
end

input_path = ARGV[0]
output_path = options[:output]

begin
  content = File.read(input_path)
  parsed_entries = PolicyOcr.parse(content)

  if output_path
    File.open(output_path, "w") do |file|
      parsed_entries.each do |account_number|
        line = account_number.to_s
        if !account_number.legible?
          line += " ILL"
        elsif !account_number.valid_checksum?
          line += " ERR"
        end
        file.puts line
      end
    end
    puts "Account numbers written to #{output_path}"
  else
    parsed_entries.each_with_index do |account_number, index|
      puts "Account Number #{index + 1}:"
      puts account_number.raw
      puts " "
      puts account_number
      puts " "
      puts account_number.valid_checksum? ? "Valid Checksum" : "Invalid Checksum"
      puts "-" * 20
    end
    puts
  end
rescue Errno::ENOENT
  puts "File not found: #{input_path}"
rescue => e
  puts "An error occurred: #{e.message}"
end