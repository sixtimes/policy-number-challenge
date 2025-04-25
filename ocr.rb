require_relative 'lib/policy_ocr'

if ARGV.empty?
  puts "Usage: ruby main.rb path/to/textfile.txt"
  exit
end

file_path = ARGV[0]

begin
  content = File.read(file_path)

  parsed_entries = PolicyOcr.parse(content)

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
rescue Errno::ENOENT
  puts "File not found: #{file_path}"
rescue => e
  puts "An error occurred: #{e.message}"
end
