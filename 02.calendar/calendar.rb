#!/usr/bin/env ruby

require 'date'
require 'optparse'

def print_year_and_month(year:, month:)
  print "      #{month}月 #{year}\n"
end

def print_day
  print "日 月 火 水 木 金 土\n"
end

def create_first_date(year:, month:)
  Date.new(year, month, 1)
end

def insert_space(first_date)
  first_date.wday.times { print '   ' }
end

def output_calendar(first_date, year:, month:)
  (first_date..Date.new(year, month, -1)).each do |date|
    print date.day.to_s.rjust(2)
    print ' '
    print "\n" if date.saturday?
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
first_date = create_first_date(year:, month:)
insert_space(first_date)
output_calendar(first_date, year:, month:)
