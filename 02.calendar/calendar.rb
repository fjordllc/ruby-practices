=begin
方向性
- 年、月を入力すると日にちの一覧が返ってくる
- 初日の曜日を取得し、曜日分ずらして配列に入れる
- そのあとは、自動的に終わりの日にちまで入れていく
- 7日ごとに分割し、一週間ごとに表示 
- putsで一週間ごとを表示
=end

require "date"
require 'enumerator'

def days_alignment(first, last) 
    days_array_origin = (first.day..last.day).to_a
    days_alignment_array = days_array_origin.map do |day|
        if day < 10 #日にちが一桁だと他の数字と位置がズレるので修正
            " #{day}"
        else
            day
        end
    end
    days_array = (["  "] * first.cwday) + days_alignment_array #初日の曜日を合わせる
end

def calc_month_days(year, month) #1ヶ月の日にちを表示
    first_date = Date.new(year, month, 1)
    last_date = Date.new(year, month, -1)
    week_array = days_alignment(first_date,last_date).each_slice(7)
end

def text_color(text, color)
    "\033["+ color +"m#{text}\033[0m"
end

def print_month_year(year, month, length, color) #月と日を表示
    year_month_str = "#{month}月 #{year}年".center(length) + "\n"
    text_center = year_month_str.center(length)
    text_center.gsub!(/\d+/){|str| text_color(str, color)} #数字だけ色変更
    print text_center
end

def day_color(array, normal, invert)
    array.map{|day| 
        if day.to_i == Date.today.day
            text_color(day, invert) #今日の日付だけ反転
        else
            text_color(day, normal)
        end
    }
end

year = 2023
month = 3

# def print_month(year, month)
    normal_color = "38;5;208"
    invert_color = "7"
    dayofweek_jp_array = ["日", "月", "火", "水", "木", "金", "土"]
    week_array = calc_month_days(year, month)
    column_length = week_array.first.join(" ").length #月の表示を真ん中に持ってくるために列の数を計算
    print_month_year(year, month, column_length, normal_color)
    print dayofweek_jp_array.join(" ") + "\n"
    (1..week_array.size).each{print day_color(week_array.next, normal_color, invert_color).join(" "), + "\n"}
# end




# print_month(year, month)

# p month2dates(2023, 3)

# def dates2week(year, month)

# end

# def calender_display(year, month)
#     week_list = dates2week(year,month)
#     week_list.each{|week| puts week }
# end

