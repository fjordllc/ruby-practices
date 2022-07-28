# frozen_string_literal: true

require 'io/console'
require_relative 'ls/parser'
require_relative 'ls/stat'

module Ls
  def self.run
    path, options = Parser.parse(ARGV)
    ls = Ls.new(path, options)
    ls.run
  end

  class Ls
    def initialize(path, options, width = IO.console.winsize[1])
      @path = path
      @options = options
      @file_paths = get_file_paths(path, options[:dot_match], options[:reverse])
      @width = width
    end

    def run
      @options[:long_format] ? long : short
    end

    def long
      stats = @file_paths.map { Stat.new(_1) }
      total_block = stats.map(&:blocks).sum
      total = "total #{total_block}\n"
      max_lengths = %i[nlink user group size].map do |key|
        stats.map { _1.body[key].size }.max
      end
      body = stats.map { _1.render(max_lengths) }
      [total, body].join.chomp
    end

    def short
      max_length = @file_paths.map { File.basename(_1).size }.max
      col_num = @width / (max_length + 2)
      row_num = (@file_paths.size.to_f / col_num).ceil
      sliced = @file_paths.each_slice(row_num).to_a
      transposed = sliced[0].zip(*sliced[1..])
      output = ''
      transposed.map do |row_paths|
        output += row_paths.map do |path|
          File.basename(path).ljust(max_length) unless path.nil?
        end.join('  ').rstrip
        output += "\n"
      end
      output.chomp
    end

    private

    def get_file_paths(pathname, dot_match, reverse)
      pattern = pathname.join('*')
      file_paths = dot_match ? Dir.glob(pattern, File::FNM_DOTMATCH) : Dir.glob(pattern)
      reverse ? file_paths.reverse : file_paths
    end
  end
end
