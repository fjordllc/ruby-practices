require 'date'

class Calendar
  def initialize(month, year)
    @today = Date.today
    @dates = []
    @month = month || @today.month
    @year = year || @today.year
    print_header
    print_week
    print_calendar
  end

  private
    # 表示するカレンダー用の配列を作成する
    def calendar_init
      endof_month = Date.new(@year, @month, -1)
      endof_month.day.times do |i|
        @dates.push(Date.new(@year, @month, i + 1))
      end
    end

    # 見出しの年月表示用
    def print_header
      puts "#{@month}月 #{@year}".center(28)
    end

    # 見出しの曜日表示用
    def print_week
      week = ["日", "月", "火", "水", "木", "金", "土"]
      week.each_index do |i|
        print " #{week[i]} "
        puts "\n" if i == 6
      end
    end

    # カレンダーの出力
    def print_calendar
      calendar_init
      @dates.each do |d|
        str = insert_space(d)
        # 月の指定が今月の場合の今日の日付の出力色反転
        print d == @today ? "\e[47m\e[30m#{str}\e[0m" : str
        # 曜日が土曜日の時の改行
        print "\n" if d.wday == 6
      end
    end
    
    # カレンダーの各日付の空白挿入処理
    def insert_space(d)
      str = "  #{d.day} "
      if d.wday != 0 && d.day == 1
        print "    " * d.wday
      elsif d.day >= 10
        str = " #{d.day} "
      end
      return str
    end
end
