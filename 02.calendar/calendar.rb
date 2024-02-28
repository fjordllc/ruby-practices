#!/usr/bin/env ruby
require "date"
require "optparse"

class WorkClendar
    def initialize()
    opt = OptionParser.new

    opt.on('-y') {|v| v}
    opt.on('-m') {|v| v}

    @request = opt.parse!(ARGV)
    @request = ARGV
    end

    def calendar
        days = []
        num = 0

        #デフォルトの日にちを取得
        default = Date.today.to_s
        default = default.split("-")
        if @request == []
            default_year = default[0]
        else
            default_year = @request[0]
        end
        
        if @request == []
            default_month = default[1]
        else
            default_month = @request[1]
        end

        #日にちを取得
        designated_date = Date.new(default_year.to_i, default_month.to_i, 1)
        month_days = ((designated_date >> 1) - 1).day
        date = designated_date.wday
        
        #曜日ぶんから文字を挿入（初日のスタート位置（曜日）をとるため）
        date.times do
            days.push("  ")
        end
        #その月の日数分daysに日にちを追加
        month_days.times do
            num += 1
            if num < 10
                days.push(" #{num}")
            else
                days.push(num)
            end
        end

        #余白を含めた日にちを一週間ごとに分割
        new_days = days.each_slice(7).to_a
        
        #カレンダーの年、月を出力
        puts designated_date.strftime("%B %Y").center(20)

        #一週間ごとに分けた配列をそれぞれくっつけて曜日と一緒に出力。
        puts ("日 月 火 水 木 金 土")
        new_days = new_days.map{|item| puts item.join(" ")}

    end

end

result_calendar = WorkClendar.new
result_calendar.calendar