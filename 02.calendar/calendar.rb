#!/usr/bin/env ruby

=begin
作成者:h-osawa(ha-osawa)
作成日:2023/4/24
=end
require "date"
require "optparse"

def print_year_and_month(year: Date.today.year, month: Date.today.month)
  print "      #{month}月 #{year}\n"
end

def print_day()
  print "日 月 火 水 木 金 土\n"
end

def create_first_day(year: Date.today.year, month: Date.today.month)
  Date.new(year,month).wday
end

def insert_space(first_day)
  first_day.times {print "   "}
end

def create_last_date(year: Date.today.year, month: Date.today.month)
  Date.new(year,month,-1).day
end

def output_calendar(first_day,last_date)
  (1..last_date).each do |date|
    if date < 10
      print " #{date}"
    else
      print "#{date}"
    end
    print " "
    print "\n" if (first_day + date) % 7 == 0
  end
end

is_specified = {}
value = {}
opt = OptionParser.new

opt.on('-m val') do |val|
  is_specified[:m] = true
  value[:m] = val
end
opt.on('-y val') do |val|
  is_specified[:y] = true
  value[:y] = val
end

opt.parse!(ARGV)

year = value[:y].to_i
month = value[:m].to_i

if is_specified[:y] && is_specified[:m]
  print_year_and_month(year: year, month: month)
  print_day()
  first_day = create_first_day(year: year, month: month)
  insert_space(first_day)
  last_date = create_last_date(year: year, month: month)
  output_calendar(first_day, last_date)
elsif is_specified[:y]
  print_year_and_month(year: year)
  print_day()
  first_day = create_first_day(year: year)
  insert_space(first_day)
  last_date = create_last_date(year: year)
  output_calendar(first_day,last_date)
elsif is_specified[:m]
  print_year_and_month(month: month)
  print_day()
  first_day = create_first_day(month: month)
  insert_space(first_day)
  last_date = create_last_date(month: month)
  output_calendar(first_day,last_date)
else
  print_year_and_month()
  print_day()
  first_day = create_first_day()
  insert_space(first_day)
  last_date = create_last_date()
  output_calendar(first_day,last_date)
end
