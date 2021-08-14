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

  files.each do |file|
    wc = Wc.new
    lines, words, bytes = wc.read_file(file)
    wc.print_result(lines, words, bytes, file)
  end
  Wc.print_total
end

class Wc
  @total_lines = 0
  @total_words = 0

  def initialize
    @lines = 0
    @words = 0
    @bytes = 0
  end

  def read_file(file)
    File.open(file).each_line do |line|
      @lines += 1 if line.include? "\n"
      @words += line.split.size
      @bytes += line.bytesize
    end
    @total_lines += @lines
    @total_words += @words
    [@lines, @words, @bytes]
  end

  def print_result(lines, words, bytes, file)
    puts "#{lines.to_s.rjust(8, ' ')}#{words.to_s.rjust(8, ' ')}#{bytes.to_s.rjust(8, ' ')} #{file}"
  end

  def self.print_total
    puts @total_lines, @total_words
  end

end

# start
main
