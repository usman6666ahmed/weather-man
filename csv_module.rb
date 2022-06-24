# frozen_string_literal: true

require 'csv'
DATE_INDEX = 0
MAX_TEMP_INDEX = 1
MIN_TEMP_INDEX = 3
MAX_HUM_INDEX = 7
MIN_HUM_INDEX = 9

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

    def initialize(date, min_temp, max_temp, min_humid, max_humid)
      @date = Date.parse date

      @min_temp = min_temp || 0
      @max_temp = max_temp || 0
      @min_humid = min_humid || 0
      @max_humid = max_humid || 0
    end

    def to_object
      {
        'date' => @date,
        'min_temp' => @min_temp,
        'max_temp' => @max_temp,

        'min_humid' => @min_humid,
        'max_humid' => @max_humid
      }
    end
  end

  # Parse and analyze CSVs
  class CSVProcessor
    @columns = []
    @rows = []

    def max_temp
      max_temp = @rows[0]
      @rows.each do |item|
        max_temp = item if max_temp.to_object['max_temp'] > item.to_object['max_temp']
      end

      max_temp.to_object
    end

    def min_temp
      min_temp = @rows[0]
      @rows.each do |item|
        min_temp = item if min_temp.to_object['min_temp'] < item.to_object['min_temp']
      end

      min_temp.to_object
    end

    def parse_file(file_path)
      data = CSV.read(file_path)

      data = data.reject { |row| row.length.zero? }

      columns = data[0].map(&:strip)

      data = data[1, data.length - 1]

      rows = []
      data.each do |item|
        next unless item[MAX_HUM_INDEX] ||
                    item[MIN_TEMP_INDEX] ||
                    item[MAX_HUM_INDEX] ||
                    item[MIN_HUM_INDEX]

        new_item = DataRow.new(item[DATE_INDEX], item[MAX_TEMP_INDEX],
                               item[MIN_TEMP_INDEX],
                               item[MAX_HUM_INDEX],
                               item[MIN_HUM_INDEX])
        rows.push(new_item)
      end

      [columns, rows]
    end

    def initialize(path, is_folder)
      if is_folder == true
        csv_files = Dir[FOLDER].select { |name| name.include? '.txt' }

        for file in csv_files

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
