require_relative 'lib/policy_ocr'

if ARGV.empty?
  puts "Usage: ruby main.rb path/to/textfile.txt"
  exit
end

file_path = ARGV[0]

begin
  content = File.read(file_path)

  parsed_entries = PolicyOcr.parse(content)

  parsed_entries.each_with_index do |entry, index|
    puts "Entry #{index + 1}:"
    # entry.each_with_index do |line, line_index|
      # puts "  Line #{line_index + 1}: #{line}"
    # end
    puts entry
    puts "-" * 20
  end
rescue Errno::ENOENT
  puts "File not found: #{file_path}"
rescue => e
  puts "An error occurred: #{e.message}"
end
