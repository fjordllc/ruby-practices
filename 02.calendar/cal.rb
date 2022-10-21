#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'optparse'

@params = ARGV.getopts('m:y:')

# 1行目に月を表示させるメソッド
def show_month
  @params['m']&.to_i || Date.today.month
end

# 1行目に年を表示させるメソッド
def show_year
  @params['y']&.to_i || Date.today.year
end

# 2行目に曜日を表示させるメソッド
def show_wday
  [' 日', '月', '火', '水', '木', '金', '土'].join(' ')
end

# 3行目以降に日付を表示させるメソッド
def show_days
  firstday = Date.new(show_year, show_month, 1).day
  lastday = Date.new(show_year, show_month, -1).day

  (firstday..lastday).each do |day|
    wday = Date.new(show_year, show_month, day).wday
    if day == 1
      print '   ' * wday + "  #{day}"
    elsif day < 10 && day != 1
      print "  #{day}"
    else
      print " #{day}"
    end
    puts "\n" if wday == 6
  end
end

puts "#{show_month}月 #{show_year}".center(22)
puts show_wday
show_days
