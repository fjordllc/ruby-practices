#!/usr/bin/env ruby
# frozen_string_literal:true

require 'optparse'

def main
  files = []
  options = { lines: false, pipe: false }

  opt = OptionParser.new
  opt.on('-l') { |v| options[:lines] = v }
  opt.parse! { ARGV }
  ARGV.each { |arg| files << arg if File.file? arg }

  options[:pipe] = File.pipe? $stdin

  wc = Wc.new
  wc.start_process(files, options)
end

class Wc
  @total_lines = 0
  @total_words = 0
  @total_bytes = 0

  def start_process(files, options)
    if options[:pipe] && files.empty?
      lines, words, bytes = counts_from_stdout
      options[:lines] ? print_lines_count(lines) : print_counts(lines, words, bytes)
    end

    files.each do |file|
      lines, words, bytes = counts_from_file(file)
      options[:lines] ? print_lines_count(lines, file) : print_counts(lines, words, bytes, file)
    end

    return if files.size <= 1

    options[:lines] ? Wc.print_lines_total : Wc.print_total
  end

  def self.total(lines, words, bytes)
    @total_lines += lines
    @total_words += words
    @total_bytes += bytes
  end

  def self.print_total
    puts "#{@total_lines.to_s.rjust(8, ' ')}#{@total_words.to_s.rjust(8, ' ')}#{@total_bytes.to_s.rjust(8, ' ')} total"
  end

  def self.print_lines_total
    puts "#{@total_lines.to_s.rjust(8, ' ')} total"
  end

  private

  def counts_from_stdout
    stdout = $stdin.readlines.join
    @lines = stdout.scan("\n").size
    @words = stdout.split.size
    @bytes = stdout.bytesize
    [@lines, @words, @bytes]
  end

  def counts_from_file(file)
    @lines = 0
    @words = 0
    @bytes = 0

    File.open(file).each_line do |line|
      @lines += line.scan("\n").size
      @words += line.split.size
      @bytes += line.bytesize
    end
    Wc.total(@lines, @words, @bytes)
    [@lines, @words, @bytes]
  end

  def print_counts(lines, words, bytes, file = '')
    puts "#{lines.to_s.rjust(8, ' ')}#{words.to_s.rjust(8, ' ')}#{bytes.to_s.rjust(8, ' ')} #{file}"
  end

  def print_lines_count(lines, file = '')
    puts "#{lines.to_s.rjust(8, ' ')} #{file}"
  end
end

# start
main
