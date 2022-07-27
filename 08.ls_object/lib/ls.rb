# frozen_string_literal: true

require 'io/console'
require_relative 'ls/parser'
require_relative 'ls/stat'

module Ls
  def self.run
    path, options = Ls::Parser.parse(ARGV)
    file_paths = get_file_paths(path, options[:dot_match], options[:reverse])
    width = IO.console.winsize[1]
    options[:long_format] ? ls_long(file_paths) : ls_short(file_paths, width)
  end

  def self.get_file_paths(pathname, dot_match, reverse)
    pattern = pathname.join('*')
    file_paths = dot_match ? Dir.glob(pattern, File::FNM_DOTMATCH) : Dir.glob(pattern)
    reverse ? file_paths.reverse : file_paths
  end

  def self.ls_long(paths)
    stats = paths.map { Stat.new(_1) }
    total_block = stats.map(&:blocks).sum
    total = "total #{total_block}\n"
    body = stats.map(&:body)
    [total, body].join
  end

  def self.ls_short(paths, width)
    max_length = paths.map { File.basename(_1).size }.max
    col_num = width / (max_length + 2)
    row_num = (paths.size.to_f / col_num).ceil
    sliced = paths.each_slice(row_num).to_a
    transposed = sliced[0].zip(*sliced[1..])
    output = ''
    transposed.map do |row_paths|
      output += row_paths.map do |path|
        path&.ljust(max_length + 2)
      end.join
      output += "\n"
    end
    output
  end
end
