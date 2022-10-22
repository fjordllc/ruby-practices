#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'optparse'

@params = ARGV.getopts('m:y:')

# 1行目に月を表示させるメソッド
def month
  @params['m']&.to_i || Date.today.month
end

# 1行目に年を表示させるメソッド
def year
  @params['y']&.to_i || Date.today.year
end

# 3行目以降に日付を表示させるメソッド
def days
  firstday = Date.new(year, month, 1).day
  lastday = Date.new(year, month, -1).day

  (firstday..lastday).each do |day|
    wday = Date.new(year, month, day).wday
    if day == 1
      if wday == 0
        print " #{day}"
      else
        print '   ' * wday + " #{day}"
      end
    else
      if wday == 0 && day < 10
        print " #{day}"
      elsif wday == 0 && day >= 10
        print "#{day}"
      elsif wday != 0 && day < 10
        print "  #{day}"
      elsif wday != 0 && day >= 10
        print " #{day}"
      end
    end
    puts "\n" if wday == 6
  end
end

puts "#{month}月 #{year}".center(20)
puts ['日', '月', '火', '水', '木', '金', '土'].join(' ')
days
