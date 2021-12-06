#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'

def main
  wc = Wc.new
  wc.show
end

class Wc
  def initialize
    @results = []
    l_option, args = parse_options
    @l_option = l_option
    args.each do |arg|
      @results.push(count_line_num_bytes_words(arg))
    end
    return unless @results.empty?.zero?

    @results.push stdin_count_line_num_bytes_words
  end

  def parse_options
    opts = OptionParser.new
    l_option = false

    opts.on('-l', 'The number of lines in each input file is written to the standard output.') { l_option = true }

    begin
      args = opts.parse(ARGV)
    rescue OptionParser::InvalidOption => e
      puts opts.to_s
      puts "error: #{e.message}"
      exit 1
    end

    [l_option, args]
  end

  def count_line_num_bytes_words(path)
    line_num = 0
    bytes = 0
    words = 0
    IO.readlines(path).map do |line|
      line_num += 1
      bytes += line.bytesize
      words += line.split.count
    end

    {
      line_num: line_num,
      bytes: bytes,
      words: words,
      name: path
    }
  end

  def stdin_count_line_num_bytes_words
    line_num = 0
    bytes = 0
    words = 0
    $stdin.readlines.map do |line|
      line_num += 1
      bytes += line.bytesize
      words += line.split.count
    end

    {
      line_num: line_num,
      bytes: bytes,
      words: words
    }
  end

  def show
    display = ''
    @results.map do |result|
      if result.key? :name
        display = "#{result[:line_num]} #{result[:name]}" if @l_option
        display = "#{result[:line_num]} #{result[:words]} #{result[:bytes]} #{result[:name]}" unless @l_option
      else
        display = result[:line_num].to_s if @l_option
        display = "#{result[:line_num]} #{result[:words]} #{result[:bytes]}" unless @l_option
      end
    end
    puts display
  end
end

main
