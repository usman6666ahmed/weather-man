# frozen_string_literal: true

require 'colorize'
require 'csv'

INDEXES = {
  'Max Temprature' => 1,
  'Min Temprature' => 3,
  'Min Humidity' => 7,
  'Max Humidity' => 9
}.freeze

data = CSV.read('./data.csv')

# Removing un-needed whitespaces from column names
data[0] = data[0].map(&:strip)

# Finding average of Max Temprature

max_temp = -9999
min_temp = 9999

max_humidity = -9999
min_humidity = 9999

(data[1, data.length - 1]).each do |row|
  if !row[INDEXES['Max Temprature']] &&
     !row[INDEXES['Min Temprature']] &&
     !row[INDEXES['Max Humidity']] &&
     !row[INDEXES['Min Humidity']]

    next
  else

    current_max_temp = row[INDEXES['Max Temprature']].to_i
    current_min_temp = row[INDEXES['Min Temprature']].to_i

    current_max_humidity = row[INDEXES['Max Humidity']].to_i
    current_min_humidity = row[INDEXES['Min Humidity']].to_i

    if current_max_temp
      max_temp = current_max_temp > max_temp ? current_max_temp : max_temp
    end

    if current_min_humidity
      min_humidity = current_min_humidity < min_humidity ? current_min_humidity : min_humidity
    end

    if current_max_humidity
      max_humidity = current_max_humidity > max_humidity ? current_max_humidity : max_humidity
    end

    if current_min_temp
      min_temp = current_min_temp < min_temp ? current_min_temp : min_temp
    end

  end
end

# puts min_temp
# puts max_temp
# puts min_humidity
# puts max_humidity
