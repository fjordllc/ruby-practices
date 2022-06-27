# frozen_string_literal: true

require 'optparse'

class LSCommand
  def initialize
    opt = OptionParser.new
    params = {}
    opt.on('-a') { |v| params[:a] = v }
    opt.on('-r') { |v| params[:r] = v }
    opt.on('-l') { |v| params[:l] = v }
    opt.parse!(ARGV)

    @path = Dir.pwd if ARGV #== []
    @path = ARGV if ARGV[1]
    @path = ARGV[0] if ARGV[0] && ARGV[1].nil?
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
      Dir.glob('*').each do |n|
        filename = n.gsub(%r{.+/([^/]+$)}) { '\1' }
        @max_name_size = filename.size if @max_name_size < filename.size
        @file_date[:"#{filename}"] = File.stat(filename)
      end
    end
  end

  def output_without_options
    case @max_name_size
    when (35..)
      row = 1
    when (24..34)
      row = 2
      width = 36
    else
      row = 3
      width = 23
    end

    line = @file_date.size / row
    line += 1 if (@file_date.size % row).positive?
    line.times do |time|
      @file_date.select.with_index { |(_k, _v), i| i % line == time }.each_key { |k| print format("%-#{width}s", k) }
      print "\n"
      time += 1
    end
    print "\n"
  end
end

ls = LSCommand.new
ls.output
