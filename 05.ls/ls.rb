# frozen_string_literal: true

require 'optparse'
ROW = 3
SPACE = 3

class LSCommand
  def initialize
    opt = OptionParser.new
    @options = {}
    opt.on('-a') { |v| @options[:a] = v }
    opt.on('-r') { |v| @options[:r] = v }
    opt.on('-l') { |v| @options[:l] = v }
    opt.parse!(ARGV)

    @path = ARGV if ARGV[1]
    @path = ARGV[0] if ARGV[0] && ARGV[1].nil?
    @path ||= Dir.pwd
  end

  def output
    case @path
    when String
      display(file_information(@path))
    when Array
      @path.each do |path|
        puts "#{path}:"
        display(file_information(path))
      end
    end
  end

  def file_information(path)
    file_names = []
    Dir.chdir(path) do
      file = @options[:a] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
      file.each do |filename|
        file_names << filename
      end
    end
  end

  def display(file_names)
    width = file_names.max_by(&:size).size + SPACE
    line = file_names.size / ROW
    line += 1 if (file_names.size % ROW).positive?
    line.times do |time|
      file_names.select.with_index { |_name, i| i % line == time }.each { |name| print format("%-#{width}s", name) }
      print "\n"
    end
    print "\n"
  end
end

ls = LSCommand.new
ls.output
