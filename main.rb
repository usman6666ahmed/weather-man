# frozen_string_literal: true

require './csv_module'
require './args_module'

args_obj = ARGSModule::ArgsParser.new ARGV
args = args_obj.to_object

p args

# FOLDER = './datasets/lahore_weather/*'

# csv_files = Dir[FOLDER].select { |name| name.include? '.txt' }

# c = CSVModule::CSVProcessor.new(FOLDER, true)

# max_temp c.max_temp
# min_temp = c.min_temp

# print "Lowest temprature was #{min_temp['min_temp']}C at #{min_temp['date']}\n"
# print "Highest temprature was #{max_temp['max_temp']}C at #{max_temp['date']}\n"
