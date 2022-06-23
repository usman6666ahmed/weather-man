# frozen_string_literal: true

require './csv_module'

FOLDER = './datasets/lahore_weather/*'

csv_files = Dir[FOLDER].select { |name| name.include? '.csv' }

_c = CSVModule::CSVProcessor.new(csv_files[0], false)
