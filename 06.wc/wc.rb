#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

class Params
  attr_accessor :name, :lines, :words, :bytes

  def initialize(name)
    @name = name
  end

  def self.exec(ary)
    lines_sum = words_sum = bytes_sum = 0
    ary.each do |a|
      lines_sum += a.lines
      words_sum += a.words if a.words
      bytes_sum += a.bytes if a.bytes
      print a.lines.to_s.rjust(8)
      print a.words.to_s.rjust(8) + a.bytes.to_s.rjust(8) if a.words
      puts " #{a.name}"
    end
    return unless ary.size > 1

    print lines_sum.to_s.rjust(8)
    print words_sum.to_s.rjust(8) + bytes_sum.to_s.rjust(8) if words_sum > 1
    puts ' total'
  end
end

class Stdin < Params
  def initialize(stdin)
    @lines = stdin.count("\n")
    @words = stdin.split(/\s+/).size
    @bytes = stdin.bytesize
  end
end

class Option
  require 'optparse'

  def initialize
    @options = nil
    OptionParser.new do |o|
      o.on('-l', 'display lines only') { |v| @options = v }
      o.parse!(ARGV)
    end
  end

  def has?
    @options
  end
end

opt = Option.new
if ARGV[0]
  params =
    ARGV.map { |a| Params.new(a) }
  params.each do |f|
    str = File.open(f.name).read
    f.lines = str.count("\n")
    f.words = str.split(/\s+/).size unless opt.has?
    f.bytes = str.bytesize unless opt.has?
  end
else
  stdin_str = $stdin.gets("/\s+/")
  params = []
  params << Stdin.new(stdin_str)
  params[0].words = nil if opt.has?
end

Params.exec(params)
