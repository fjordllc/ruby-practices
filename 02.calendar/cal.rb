#!/usr/bin/env ruby

require 'date'
require 'optparse'

#月と西暦を取得・表示するメソッド定義-始まり-
class MonthAndYear
  @params = ARGV.getopts("m:y:")

  def self.add_month
    if @params["m"] != nil
      @params["m"].to_i
    else
      Date.today.month
    end
  end

  def self.add_year
    if @params["y"] != nil
      @params["y"].to_i
    else
      Date.today.year
    end
  end

  def self.load_month
    @month = add_month
  end

  def self.load_year
    @year = add_year
  end

  def self.show_month_and_year
    load_month
    load_year
    puts "#{@month}月 #{@year}".center(27)
  end
end
#月と西暦を取得・表示するメソッド定義-終わり-

#日付を取得・表示するメソッド -始まり-
class DatesOfMonth
  def self.add_firstday
    @firstday = Date.new(MonthAndYear.load_year.to_i, MonthAndYear.load_month.to_i, 1).day
  end

  def self.add_lastday
    @lastday = Date.new(MonthAndYear.load_year.to_i, MonthAndYear.load_month.to_i, -1).day
  end

  def self.show_dates
    add_firstday
    add_lastday

    (@firstday..@lastday).each do |day|
      @wday = Date.new(MonthAndYear.load_year.to_i, MonthAndYear.load_month.to_i, day).wday

      if @wday == 6
        if day < 10 && day != 1
          print "  #{day}"
        elsif day == 1
          print "   " * @wday
          print "  #{day}"
        else
          print " #{day}"
        end
        print "\n"
      else
        if day <10 && day != 1
          print "  #{day}"
        elsif day == 1
          print "   " * @wday
          print "  #{day}"
        else
          print " #{day}"
        end
      end
    end
 end
end
#日付を取得・表示するメソッド -終わり-



#1行目に月と西暦を表示する
MonthAndYear.show_month_and_year
#2行目に曜日を表示する
puts ["日", "月", "火", "水", "木", "金", "土"].join(" ")
#3行目以降に日付を表示する
DatesOfMonth.show_dates
