#!/usr/bin/ruby

require 'optparse'
require 'date'

TODAY = Date.today

def setup_option(option: { month: TODAY.month, year: TODAY.year })
  OptionParser.new do |opt|
    opt.banner = 'Usage: ruby calendar'
    opt.on("-m VALUE", Integer) do |v|
      if (1 .. 12).cover?(v)
        option[:month] = v
      else
        raise "(1~12)"
      end
    end
    opt.on("-y VALUE", Integer) do |v|
      option[:year] = v
    end
    opt.parse!(ARGV)
  end
  option
end

class MonthTableRenderer
  # 表示幅
  # 7days * 半角2文字 + 間のスペースが6個
  CALENDER_DISPLAY_WIDTH = 20

  def initialize(year:, month:)
    @year = year
    @month = month

    @all_month = (Date.new(year, month, 1) .. Date.new(year, month, -1))
  end

  def render
    render_header
    weeks = @all_month.group_by {|date| date.strftime("%U").to_i}
    weeks.each do |weeknum, week|
      # 月初に関しては日曜日から始まらないのでカレンダーがズレるためスペース調整
      left_spaces = Array.new(week.first.wday).map{|n| "\s" * 3}.join("")
      line = week.map{ |date|
        "%2d" % date.day
      }.join(" ")
      puts "#{left_spaces}#{line}"
    end
  end

  private

  def render_header(display_width: CALENDER_DISPLAY_WIDTH)
    puts @all_month.first.strftime("%-m月 %Y").center(display_width)
    puts %w(日 月 火 水 木 金 土).join(" ")
  end
end

MonthTableRenderer.new(setup_option).render

