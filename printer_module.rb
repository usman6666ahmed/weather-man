# frozen_string_literal: true

require 'colorize'

module PrinterModule
  class Printer
    def generate_plusses(string, color)
      s = '+' * string
      s.colorize(color)
    end

    def two_bars(data)
      puts data[0]
      data.each_with_index do |item, index|
        message = ''
        message += "#{index + 1} "
        message += "#{generate_plusses(item['min_temp'], :blue)} #{item['min_temp']}C \n"
        puts message

        message = ''
        message += "#{index + 1} "
        message += "#{generate_plusses(item['max_temp'], :red)} #{item['max_temp']}C\n"
        puts message

        puts
      end
    end

    def one_bar(data)
      puts data[0]
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
  end
end
