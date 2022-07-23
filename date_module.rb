# frozen_string_literal: true

module DateModule
  # This class parses dates in objects
  # that can be compared
  # Also these object can be converted into
  # a specific date format that can be used
  # for searching in the datasets directory
  class DateParser
    @year = 0
    @month = ''

    @calender = %w[
      Jan Feb Mar Apr
      May Jun Jul Aug
      Sep Oct Nov Dec
    ]

    def initialize(raw_date)
      @calender = %w[
        Jan Feb Mar Apr
        May Jun Jul Aug
        Sep Oct Nov Dec
      ]

      @year = raw_date.split '/'
      @year = @year[0].to_i

      @month = raw_date.split('/')
      @month = @month[1].to_i - 1
      @month = @calender[@month]
    end

    def to_object
      {
        'year' => @year,
        'month' => @month
      }
    end

    def to_string
      "#{@year}_#{@month}"
    end
  end
end
