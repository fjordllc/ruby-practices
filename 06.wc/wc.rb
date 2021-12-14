#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'
require 'prettyprint'

def main
  wc = Wc.new
  wc.show
end

class Wc
  def initialize
    @results = []
    @p2 = PrettyPrint.new
    @l_option, args = parse_options
    @results = args.map { |arg| count_line_num_bytes_words(arg) }

    return unless @results.empty?

    @results.push count_line_num_bytes_words
  end

  def show
    total = @results.inject(
      line_num: 0,
      words: 0,
      bytes: 0
    ) do |sum, result|
      format(result)
      {
        line_num: sum[:line_num] + result[:line_num],
        words: sum[:words] + result[:words],
        bytes: sum[:bytes] + result[:bytes]
      }
    end
    format(total, is_total: true) if @results.length > 1
    @p2.flush
    puts @p2.output
  end

  private

  def format(result, is_total: false)
    @p2.group do
      @p2.text(result[:line_num].to_s.rjust(8))
      unless @l_option
        @p2.text(result[:words].to_s.rjust(8))
        @p2.text(result[:bytes].to_s.rjust(8))
      end
      if is_total
        @p2.text('total'.ljust(20).dup.prepend(' '))
      elsif !result[:name].empty?
        @p2.text(result[:name].to_s.ljust(60).dup.prepend(' '))
      end
      @p2.breakable
    end
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
