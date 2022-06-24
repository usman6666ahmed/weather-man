# frozen_string_literal: true

require './csv_module'

help_message = 'usage ./weather-man -e 2002/12 /path/to/file'

if ARGV.length < 3
  puts help_message
  exit(1)
end

flag_valid = ARGV[0] =~ /-[aec]/ ? true : false
unless flag_valid
  puts "Unknown identifier #{ARGV[0]}"
  exit(1)
end

date_pattern = ARGV[0] == '-a' || ARGV[0] == '-c' ? %r{^[0-9]{4}/[0-9]{2}$} : /^[0-9]{4}$/
date_valid = ARGV[1] =~ date_pattern ? true : false
puts date_valid ? 'Works' : help_message

FOLDER = './datasets/lahore_weather/*'

csv_files = Dir[FOLDER].select { |name| name.include? '.txt' }

# c = CSVModule::CSVProcessor.new(csv_files[ARGV[2].to_i], false)
c = CSVModule::CSVProcessor.new(FOLDER, true)

print "Lowest temprate was #{c.max_temp['max_temp']}C at #{c.max_temp['date']}"
puts c.min_temp['max_temp']
