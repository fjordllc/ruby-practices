#!/usr/bin/env ruby

require 'optparse'
require 'date'

opt = OptionParser.new

params = {}

opt.on('-y YEAR') {|v| params[:year] = v }
opt.on('-m MONTH') {|v| params[:month] = v }

opt.parse!(ARGV)

today = Date.today

year = params[:year] ? params[:year].to_i : today.year
month = params[:month] ? params[:month].to_i : today.month
first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)

def inverse_color(str)
  "\e[30m\e[47m#{str}\e[0m"
end

puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"

if first_date.cwday < 7
  print "   " * first_date.cwday
end

(first_date..last_date).each do |date|
  mday = date.mday.to_s.rjust(2)
  mday = inverse_color(mday) if date == today

  formatted_mday = if (date.saturday? || last_date.mday == date.mday)
    mday << "\n"
  else
    mday << " "
  end

  print formatted_mday
end
