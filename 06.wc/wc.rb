#!/usr/bin/env ruby
# frozen_string_literal:true

require 'optparse'

def main
  options = { lines: false }
  opt = OptionParser.new
  opt.on('-l') { |v| options[:lines] = v }
  opt.parse! { ARGV }

  files = []
  ARGV.each { |arg| files << arg if File.file? arg }

  wc = Wc.new
  wc.start_process(files)
  # files.each do |file|
  #   wc = Wc.new
  #   lines, words, bytes = wc.read_file(file)
  #   wc.print_result(lines, words, bytes, file)
  # end

  # Wc.print_total_data if files.size > 1
end

class Wc
  @total_lines = 0
  @total_words = 0
  @total_bytes = 0

  def start_process(files)
    files.each do |file|
      lines, words, bytes = read_file(file)
      print_result(lines, words, bytes, file)
    end
    Wc.print_total_data if files.size > 1
  end

  private
  
  def read_file(file)
    @lines = 0
    @words = 0
    @bytes = 0

    File.open(file).each_line do |line|
      @lines += 1 if line.include? "\n"
      @words += line.split.size
      @bytes += line.bytesize
    end
    Wc.total_data(@lines, @words, @bytes)
    [@lines, @words, @bytes]
  end

  def self.total_data(lines, words, bytes)
    @total_lines += lines
    @total_words += words
    @total_bytes += bytes
  end

  def self.print_total_data
    puts "#{@total_lines.to_s.rjust(8, ' ')}#{@total_words.to_s.rjust(8, ' ')}#{@total_bytes.to_s.rjust(8, ' ')} total"
  end

  def print_result(lines, words, bytes, file)
    puts "#{lines.to_s.rjust(8, ' ')}#{words.to_s.rjust(8, ' ')}#{bytes.to_s.rjust(8, ' ')} #{file}"
  end
end

# start
main
