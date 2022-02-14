require "date"
require "optparse"

class Calendar
    def initialize(year, month)
        @year = year
        @month = month
    end
    def create
        # 月の最初の日付を取得
        @month_first = Date.new(@year, @month, 1)
        # 月の最後の日付を取得
        @month_last = Date.new(@year, @month, -1)
        # 最初の日付の曜日数を取得
        @month_first_wday = @month_first.wday
        # 最後の日を取得
        @month_last_day = @month_last.day
        # 月と年を表示
        top = "#{@month}月 #{@year}"
        puts top.center(20)
        # 曜日を表示
        puts "日 月 火 水 木 金 土"
        # 余分な曜日数を字下げ
        print "   " * @month_first_wday
        # 最初の日から最後の日まで順番に表示
        (1..@month_last_day).each do |day|
            print day.to_s.rjust(2) + " "
            @month_first_wday += 1
            print "\n" if @month_first_wday % 7 == 0
        end
        print "\n"
    end
end

# 引数付きショートネームオプションの作成
params = ARGV.getopts("y:","m:")
# yオプションの引数
get_year = params["y"] ? params["y"].to_i : Date.today.year
# mオプションの引数
get_month = params["m"] ? params["m"].to_i : Date.today.month
# Calendarクラスのインスタンスの作成
calendar = Calendar.new(get_year, get_month)
# createメソッドの呼び出し
calendar.create
