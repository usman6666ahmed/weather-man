# frozen_string_literal: true

require 'csv'

module CSVModule
  # This represents a singular row
  # of the dataset
  # Helpfull for comparing dates
  # and other values instead of
  # using a plain 2-D array
  class DataRow
    @min_temp = 0
    @max_temp = 0

    @min_humid = 0
    @max_humid = 0

    @date = ''

    def initialize(date, min_temp, _max_temp, _min_humid, _max_humid)
      @date = date

      @min_temp = min_temp || 0
      @min_temp = min_temp || 0
      @min_temp = min_temp || 0
      @min_temp = min_temp || 0
    end
  end

  # Parse and analyze CSVs
  class CSVProcessor
    @columns = []
    @data = []
    @index = {
      'Max Temprature' => 1,
      'Min Temprature' => 3,
      'Min Humidity' => 7,
      'Max Humidity' => 9

    }

    def parse_file(file_path)
      data = CSV.read(file_path)
      columns = data[0].map(&:strip)
      data = data[1, data.length - 1]

      data.each do |item|
        next unless item[@index['Max Temprature']] ||
                    item[@index['Min Temprature']] ||
                    item[@index['Max Humidity']] ||
                    item[@index['Min Humidity']]

        new_item = DataRow.new(item[0], item[@index['Max Temprature']],
                               item[@index['Min Temprature']],
                               item[@index['Max Humidity']],
                               item[@index['Min Humidity']])
        @data.push(new_item)
      end

      [columns, rows]
    end

    def initialize(path, is_folder)
      if is_folder == true
        puts 'Hi'
      else
        @columns, @data = parse_file(path)
      end

      puts @data
    end
  end
end
