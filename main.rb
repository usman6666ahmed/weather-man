# frozen_string_literal: true

require './csv_module'

if ARGV.length < 3
  puts 'usage ./weather-man -e 2002/12 /path/to/file'
  exit(1)
end

option_valid = (ARGV[0] =~ /-[aec]/) ? true:false
if !option_valid
  puts 'Invalid identifier ' + ARGV[0]
  exit(1)
end

date_pattern = ARGV[0] == '-a' || ARGV[0] == '-c' ? /^[0-9]{4}\/[0-9]{2}$/ : /^[0-9]{4}$/
date_valid = (ARGV[1] =~ date_pattern) ? true:false
puts date_valid


# FOLDER = './datasets/lahore_weather/*'

# csv_files = Dir[FOLDER].select { |name| name.include? '.csv' }

# _c = CSVModule::CSVProcessor.new(csv_files[0], false)
# c = CSVModule::CSVProcessor.new('./datasets/data.csv', false)

# puts c.get_max_temp['max_temp']
# puts c.get_min_temp['max_temp']
