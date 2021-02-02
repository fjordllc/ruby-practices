#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

class Param
  attr_reader :name, :lines, :words, :bytes, :opt

  def initialize(name, opt)
    @name = name
    str = File.open(name).read
    @lines = str.count("\n")
    @words = str.split(/\s+/).size unless opt.has?
    @bytes = str.bytesize unless opt.has?
  end
end

class Stdin
  attr_reader :lines, :words, :bytes, :opt

  def initialize(stdin, opt)
    @lines = stdin.count("\n")
    @words = stdin.split(/\s+/).size unless opt.has?
    @bytes = stdin.bytesize unless opt.has?
  end
end

class Option
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

def exec(ary)
  lines_sum = words_sum = bytes_sum = 0
  ary.each do |a|
    lines_sum += a.lines
    words_sum += a.words if a.words
    bytes_sum += a.bytes if a.bytes
    print a.lines.to_s.rjust(8)
    print a.words.to_s.rjust(8) + a.bytes.to_s.rjust(8) if a.words
    print " #{a.name}" if a.respond_to?(:name)
    puts "\n"
  end
  return unless ary.size > 1

  print lines_sum.to_s.rjust(8)
  print words_sum.to_s.rjust(8) + bytes_sum.to_s.rjust(8) if words_sum > 1
  puts ' total'
end

opt = Option.new
if ARGV[0]
  params = ARGV.map { |a| Param.new(a, opt) }
else
  stdin_str = $stdin.gets("/\s+/")
  params = []
  params << Stdin.new(stdin_str, opt)
end

exec(params)
