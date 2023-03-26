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


def text_color(text, color)
    "\033["+ color +"m#{text}\033[0m"
end

def length_2byte(str_2byte)
    len = 0
    str_2byte.each_char{ |char|
        if char.bytesize == 1
            len += 1
        else
            len += 2
        end
    }
    return len
end

def print_month_year(year, month, length, color) #月と年を表示
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

def date_color(date, normal, invert)
    if date.day < 10 #日にちが一桁だと他の数字と位置がズレるので修正
        day = " #{date.day}"
    else
        day = date.day
    end
    if date == Date.today #今日の日付は色を反転する
        text_color(day, invert)
    else
        text_color(day, normal)
    end
end

def days_alignment(first, last, normal, invert) 
    days_array_origin = (first..last).to_a
    days_alignment_array = days_array_origin.map do |date|
        date_color(date, normal, invert)
    end
    days_array = (["  "] * first.cwday) + days_alignment_array #初日の曜日を合わせる
end

def calc_month_days(year, month, normal, invert) #1ヶ月の日にちを表示
    first_date = Date.new(year, month, 1)
    last_date = Date.new(year, month, -1)
    week_array = days_alignment(first_date, last_date, normal, invert).each_slice(7)
end

year = 2023
month = 3

# def print_month(year, month)
    normal_color = "38;5;208" #オレンジ
    invert_color = "7" #白
    dayofweek_jp_array = ["日", "月", "火", "水", "木", "金", "土"]

    length_dayofweek = length_2byte(dayofweek_jp_array.join(" ")) #月の表示を真ん中に持ってくるために列の数を計算
    print_month_year(year, month, length_dayofweek, normal_color)
    print (dayofweek_jp_array.join(" ") + "\n")

    week_array = calc_month_days(year, month, normal_color, invert_color)
    (1..week_array.size).each{print week_array.next.join(" ") + "\n"}
# end

