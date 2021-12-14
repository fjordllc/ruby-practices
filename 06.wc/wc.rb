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
    @results = args.map { |arg| count_line_num_bytes_words(arg) }

    return unless @results.empty?

    @results.push count_line_num_bytes_words
  end

  def show
    display = ''
    @results.each do |result|
      display = if result[:name].empty?
                  @l_option ? result[:line_num].to_s : "#{result[:line_num]} #{result[:words]} #{result[:bytes]}"
                else
                  @l_option ? "#{result[:line_num]} #{result[:name]}" : "#{result[:line_num]} #{result[:words]} #{result[:bytes]} #{result[:name]}"
                end
      puts display
    end
  end

  private

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

  def count_line_num_bytes_words(path = '')
    lines = if path.empty?
              $stdin.readlines
            else
              IO.readlines(path)
            end

    {
      line_num: lines.count,
      words: lines.sum { |line| line.split.count },
      bytes: lines.sum(&:bytesize),
      name: path
    }
  end
end

main
