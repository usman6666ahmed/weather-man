# frozen_string_literal: true

require 'colorize'

module PrinterModule
  class Printer
    def generate_plusses(string, color)
      s = '+' * string
      s.colorize(color)
    end

    def two_bars(data)
      data.each_with_index do |item, index|
        message = ''
        message += "#{index + 1} "
        message += "#{generate_plusses(item['min_temp'], :blue)} #{item['min_temp']}C \n"
        puts message

        message = ''
        message += "#{index + 1} "
        message += "#{generate_plusses(item['max_temp'], :red)} #{item['max_temp']}C\n"
        puts "#{message}\n\n"
      end
    end

    def one_bar(data)
      data.each_with_index do |item, index|
        message = ''
        message += "#{index + 1} "
        message += generate_plusses(item['min_temp'], :blue).to_s
        message += generate_plusses(item['max_temp'], :red).to_s

        message += " #{item['min_temp']}C - #{item['max_temp']}C \n"

        puts message

        puts
      end
    end

    def report(data)
      message = ''

      max = data['max']
      message += "Highest Average: #{max[:val]}C \n"

      min = data['min']
      message += "Lowest Average: #{min[:val]}C \n"

      humid = data['hum']
      message += "Average Humidity: #{humid[:val]}% \n"

      puts message
    end

    def report_with_dates(data)
      message = ''

      max = data['max']
      message += "Highest: #{max[:val]}C at #{max[:date]}\n"

      min = data['min']
      message += "Lowest: #{min[:val]}C  at #{min[:date]}\n"

      humid = data['hum']
      message += "Humid: #{humid[:val]}%  at #{humid[:date]}\n"

      puts message
    end
  end
end
