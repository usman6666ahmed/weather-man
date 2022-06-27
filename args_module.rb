# frozen_string_literal: true

require './date_module'
module ARGSModule
  # Parsing CLI arguments in a
  # better, more standard manner
  class ArgsParser
    @help_message = ''

    @flag = ''
    @date = ''
    @is_folder = false
    @path = ''

    private

    def validate_path(path)
      if @is_folder
        File.directory?(path) ? "#{path}/*" : nil
      else
        File.exist?(path) ? path : nil
      end
    end

    def validate_flag(flag)
      flag =~ /-[aec]/ ? flag : nil
    end

    def validate_date(date)
      date_pattern = @flag == '-a' || @flag == '-c' ? %r{^[0-9]{4}/[0-9]{2}$} : /^[0-9]{4}$/
      date =~ date_pattern ? date : nil
    end

    public

    def initialize(args_array)
      @help_message = "usage ./weather-man -a 2002/12 /path/to/file \n"
      @help_message += "usage ./weather-man -c 2002/12 /path/to/file \n"
      @help_message += "usage ./weather-man -e 2002 /path/to/file \n"

      if args_array.length != 3
        puts "Missing parameters\n"
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
      @date = DateModule::DateParser.new @date
      @date = @date.to_string

      @is_folder = @flag == '-a' || @flag == '-c' ? false : true

      path_valid = validate_path(args_array[2])
      if path_valid.nil?
        puts "Path does not exist: \" #{args_array[2]} \""
        puts @help_message
        exit(1)
      end
      @path = path_valid
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
