# frozen_string_literal: true

require 'csv'
DATE_INDEX = 0

MAX_TEMP_INDEX = 1
MIN_TEMP_INDEX = 3

AVG_HUM_INDEX = 8

module CSVModule
  # This represents a singular row
  # of the dataset
  # Helpfull for comparing dates
  # and other values instead of
  # using a plain 2-D array
  class DataRow
    @min_temp = 0
    @max_temp = 0

    @avg_humid = 0

    @date = ''

    def initialize(date, min_temp, max_temp, avg_humid)
      @date = Date.parse date

      @min_temp = min_temp.to_i || 0
      @max_temp = max_temp.to_i || 0
      @avg_humid = avg_humid.to_i || 0
    end

    def to_object
      {
        'date' => @date,
        'min_temp' => @min_temp,
        'max_temp' => @max_temp,

        'avg_humid' => @avg_humid
      }
    end
  end

  # Parse and analyze CSVs
  class CSVProcessor
    @columns = []
    @rows = []

    def max_temp
      max = @rows[0]
      @rows.each do |item|
        max = item if max.to_object['max_temp'] < item.to_object['max_temp']
      end

      {
        date: max.to_object['date'],
        val: max.to_object['max_temp']
      }
    end

    def min_temp
      min = @rows[0]
      @rows.each do |item|
        min = item if min.to_object['min_temp'] > item.to_object['min_temp']
      end

      {
        date: min.to_object['date'],
        val: min.to_object['min_temp']
      }
    end

    def max_humidty
      hm = @rows[0]
      @rows.each do |item|
        hm = item if hm.to_object['avg_humid'] < item.to_object['avg_humid']
      end

      {
        date: hm.to_object['date'],
        val: hm.to_object['avg_humid']
      }
    end

    def month_data()
      @rows.map {|row| row.to_object}
    end

    def report
      min = min_temp
      max = max_temp
      hum = max_humidty

      {
        'min' => min,
        'max' => max,
        'hum' => hum
      }
    end

    def parse_file(file_path)
      data = CSV.read(file_path)

      data = data.reject { |row| row.length.zero? }

      columns = data[0].map(&:strip)

      data = data[1, data.length - 1]

      rows = []
      data.each do |item|
        next unless item[MAX_TEMP_INDEX] ||
                    item[MIN_TEMP_INDEX] ||
                    item[AVG_HUM_INDEX]

        new_item = DataRow.new(item[DATE_INDEX], item[MAX_TEMP_INDEX],
                               item[MIN_TEMP_INDEX],
                               item[AVG_HUM_INDEX])

        rows.push(new_item)
      end

      [columns, rows]
    end

    def initialize(path, is_folder, date)
      if is_folder == true
        csv_files = Dir[path].select { |name| name.include? date }

        csv_files.each do |file|
          _, items = parse_file(file)
          if !@rows
            @rows = items
          else
            @rows.concat(items)
          end
        end

      else
        @columns, @rows = parse_file(path)
      end
    end
  end
end
