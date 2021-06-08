# frozen_string_literal: true

require 'optparse'
require 'date'

class Calender
  SUNDAY    = 0.freeze
  SATURDAY  = 6.freeze
  FIRST_DAY = 1.freeze

  attr_reader :year, :month, :last_day_of_month

  def initialize(year, month)
    @year = year
    @month = month
    @last_day_of_month = Date.new(year, month, -1).day
  end

  def generate
    # 年、月の行
    month_and_yaer_low = "      " + month.to_s + "月 " + year.to_s + "\n"
    # 曜日の行
    week_days_low = "日 " + "月 " + "火 " + "水 " + "木 " + "金 " + "土" + "\n"

    # 日付の行群
    day_lows = ""
    (1..last_day_of_month).each do |day_number|
      date = Date.new(year, month, day_number)
      day_lows += format_day_cel(date)
    end

    puts month_and_yaer_low + week_days_low + day_lows
  end


  # カレンダーの日付部分ひとつひとつをセルと見なして、半角スペースや改行コードを付与するメソッド
  def format_day_cel(date)
    day = date.day
    wday = date.wday

    # 日付を文字列化したものを返り値の基本系として控えておく
    result = day.to_s

    # 日付が1桁の場合は半角スペースひとつを先頭に付与
    if result.size == 1
      result.insert(0,"\s")
    end

    # 月の1日である場合は曜日に応じた半角スペースを先頭に付与
    if day == FIRST_DAY
      brank = ""
      wday.times do
        brank += "\s\s\s"
      end
      result.insert(0, brank)
    # 日曜日以外の場合は前の日付との間に半角スペースをひとつ付与
    elsif wday != SUNDAY
      result.insert(0,"\s")
    end

    # 土曜日の場合は改行コードを付与
    if wday == SATURDAY
      result += "\n"
    end
    result
  end
end

#コマンドライン引数
params = ARGV.getopts('y:', 'm:')
year = params['y'] ? params['y'].to_i : Date.today.year.to_i
month = params['m'] ? params['m'].to_i : Date.today.month.to_i

# コンソールに出力
Calender.new(year, month).generate
