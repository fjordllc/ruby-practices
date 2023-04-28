#!/usr/bin/env ruby

require 'date'
require 'optparse'

def print_year_and_month(year:, month:)
  print "      #{month}月 #{year}\n"
end

def print_day
  print "日 月 火 水 木 金 土\n"
end

def create_first_day(year:, month:)
  Date.new(year, month).wday
end

def insert_space(first_day)
  first_day.times { print '   ' }
end

def output_calendar(year:, month:)
  (Date.new(year, month, 1)..Date.new(year, month, -1)).each do |date|
    print date.day.to_s.rjust(2)
    print ' '
    print "\n" if ((date.wday + date.day) % 7).zero?
  end
end

value = {}
opt = OptionParser.new

opt.on('-m val') { |val| val }
opt.on('-y val') { |val| val }
opt.parse!(ARGV, into: value)

year = value[:y] ? value[:y].to_i : Date.today.year
month = value[:m] ? value[:m].to_i : Date.today.month

print_year_and_month(year:, month:)
print_day
first_day = create_first_day(year:, month:)
insert_space(first_day)
output_calendar(year:, month:)
