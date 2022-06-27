# frozen_string_literal: true

require './csv_module'
require './args_module'
require './date_module'
require './printer_module'
require 'json'

args_obj = ARGSModule::ArgsParser.new ARGV

args = args_obj.to_object

csv_data = CSVModule::CSVProcessor.new(args['path'], args['is_folder'], args['date'])

printer = PrinterModule::Printer.new

case args['flag']
when '-e'
  data = csv_data.report
  printer.report_with_dates(data)
when '-a'
  data = csv_data.report
  printer.report(data)
when '-c'
  data = csv_data.month_data
  printer.two_bars data
  printer.one_bar data
else
  puts 'Invalid flag'
  exit(1)
end

