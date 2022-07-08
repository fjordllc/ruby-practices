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
  end

  def output
    case @path
    when String
      file_date_in(@path)
      output_without_options
    when Array
      @path.each do |path|
        puts "#{path}:"
        file_date_in(path)
        output_without_options
      end
    end
  end

  def file_date_in(path)
    @file_date = {}
    @max_name_size = 0
    Dir.chdir(path) do
      Dir.glob('*').each do |filename|
        @max_name_size = filename.size if @max_name_size < filename.size
        @file_date[:"#{filename}"] = File.stat(filename)
      end
    end
  end

  def output_without_options
    width = @max_name_size + SPACE
    line = @file_date.size / ROW
    line += 1 if (@file_date.size % ROW).positive?
    line.times do |time|
      @file_date.select.with_index { |_date, i| i % line == time }.each_key { |k| print format("%-#{width}s", k) }
      print "\n"
    end
    print "\n"
  end
end

ls = LSCommand.new
ls.output
