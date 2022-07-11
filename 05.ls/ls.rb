# frozen_string_literal: true

require 'optparse'
ROW = 3
SPACE = 3

class LSCommand
  def initialize
    opt = OptionParser.new
    params = {}
    opt.on('-a') { |v| params[:a] = v }
    opt.on('-r') { |v| params[:r] = v }
    opt.on('-l') { |v| params[:l] = v }
    opt.parse!(ARGV)

    @path = ARGV if ARGV[1]
    @path = ARGV[0] if ARGV[0] && ARGV[1].nil?
    @path ||= Dir.pwd
    @params = params
  end

  def output
    case @path
    when String
      get_file_information(@path)
      display
    when Array
      @path.each do |path|
        puts "#{path}:"
        get_file_information(path)
        display
      end
    end
  end

  def get_file_information(path)
    @file_name = {}
    @max_name_size = 0
    Dir.chdir(path) do
      file = Dir.glob('*', File::FNM_DOTMATCH) if @params[:a]
      file ||= Dir.glob('*')
      file.each do |filename|
        @max_name_size = filename.size if @max_name_size < filename.size
        @file_name[:"#{filename}"] = nil
      end
    end
  end

  def display
    width = @max_name_size + SPACE
    line = @file_name.size / ROW
    line += 1 if (@file_name.size % ROW).positive?
    line.times do |time|
      @file_name.select.with_index { |_date, i| i % line == time }.each_key { |k| print format("%-#{width}s", k) }
      print "\n"
    end
    print "\n"
  end
end

ls = LSCommand.new
ls.output
