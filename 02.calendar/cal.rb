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
  def initialize(year:, month:)
    @year = year
    @month = month

    @all_month = (Date.new(year, month, 1) .. Date.new(year, month, -1))
  end

  def render
    render_header
    all_calendar_days = beginning_of_week(@all_month.first) .. end_of_week(@all_month.last)
    weeks = all_calendar_days.group_by {|date| date.strftime("%U").to_i}
    weeks.each do |weeknum, week|
      puts week.map {|date|
        if @all_month.cover?(date)
          "%2d" % date.day
        else
          "  "
        end
      }.join(" ")
    end
  end

  private

  def render_header
    puts @all_month.first.strftime("%-m月 %Y年")
    puts %w(日 月 火 水 木 金 土).join(" ")
  end

  def beginning_of_week(date)
    date.downto(date.prev_month) {|d|
      return d if d.wday == 0
    }
  end

  def end_of_week(date)
    date.upto(date.next_month) {|d|
      return d if d.wday == 6 
    }
  end
end

MonthTableRenderer.new(setup_option).render

