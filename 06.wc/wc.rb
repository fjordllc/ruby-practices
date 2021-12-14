#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'
require 'prettyprint'

def main
  wc = Wc.new(ARGV)
  printer = Printer.new
  wc.results.each { |result| printer.format(result) }
  printer.format(wc.total, is_total: true) if wc.results.length > 1
  printer.output
end

class Wc
  attr_reader :results, :total

  def initialize(argv)
    @results = []
    @l_option, args = parse_options(argv)
    @results = args.map { |arg| count_line_num_bytes_words(arg) }
    @results.push count_line_num_bytes_words if @results.empty?
    @total = @results.inject(
      line_num: 0,
      words: 0,
      bytes: 0
    ) do |sum, result|
      {
        line_num: sum[:line_num] + result[:line_num],
        words: sum[:words] + result[:words],
        bytes: sum[:bytes] + result[:bytes]
      }
    end
  end

  private

  def parse_options(argv)
    opts = OptionParser.new
    l_option = false

    opts.on('-l', 'The number of lines in each input file is written to the standard output.') { l_option = true }

    begin
      args = opts.parse(argv)
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

class Printer
  def initialize
    @p2 = PrettyPrint.new
  end

  def format(result, is_total: false)
    @p2.group do
      p2_text result[:line_num]
      unless @l_option
        p2_text result[:words]
        p2_text result[:bytes]
      end
      if is_total
        p2_last_text 'total'
      elsif !result[:name].empty?
        p2_last_text result[:name]
      end
      @p2.breakable
    end
  end

  def output
    @p2.flush
    puts @p2.output
  end

  private

  def p2_text(text)
    @p2.text text.to_s.rjust(8)
  end

  def p2_last_text(text)
    @p2.text text.to_s.ljust(50).dup.prepend(' ')
  end
end

main
