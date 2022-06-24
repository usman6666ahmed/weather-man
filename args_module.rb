# frozen_string_literal: true

module ARGSModule

  # Parsing CLI arguments in a
  # better, more standard manner
  class ArgsParser
    @help_message = ''

    @flag = ''
    @date = ''
    @is_folder = false
    @path = ''

    def validate_flag(flag)
      flag =~ /-[aec]/ ? flag : nil
    end

    def validate_date(date)
      date_pattern = @flag == '-a' || @flag == '-c' ? %r{^[0-9]{4}/[0-9]{2}$} : /^[0-9]{4}$/
      date =~ date_pattern ? date : nil
    end

    def initialize(args_array)
      @help_message = "usage ./weather-man -a 2002/12 /path/to/file \nusage ./weather-man -c 2002/12 /path/to/file \nusage ./weather-man -e 2002 /path/to/file \n"

      if args_array.length != 3
        puts 'Missing parameters\n'
        puts @help_message
        exit(1)
      end

      flag_valid = validate_flag(args_array[0])
      if flag_valid.nil?
        puts "Invalid flag #{args_array[0]}"
        puts @help_message
        exit(1)
      end

      @flag = flag_valid

      date_valid = validate_date(args_array[1])
      if date_valid.nil?
        puts "Invalid date #{args_array[1]}"
        puts @help_message
        exit(1)
      end

      @date = date_valid

      @path = args_array[2]

      @is_folder = @flag == '-a' || @flag == '-c' ? false : true
    end

    def to_object
      {
        'flag' => @flag,
        'date' => @date,
        'is_folder' => @is_folder,
        'path' => @path
      }
    end
  end
end
