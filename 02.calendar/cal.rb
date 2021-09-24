require "date"
require "optparse"

MONTH_NAME = {
  "1" => "Jan", 
  "2" => "Feb",
  "3" => "Mar", 
  "4" => "Apr", 
  "5" => "May", 
  "6" => "Jun", 
  "7" => "Jul",
  "8" => "Aug",
  "9" => "Sep",
  "10" => "Oct",
  "11" => "Nov",
  "12" => "Dec"
}

Week_date = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

# ANSIエスケープシーケンス（背景：白、文字色：黒）
ANSI_ESC = "\e[47m\e[30m"

# ANSIエスケープシーケンスのクローズ
ANSI_ESC_END = "\e[m"


class Calendar

  def initialize(year, month, day)
    @year = year
    @month = month
    @day = day
  end

  def get_first_wday
    return Date.new(@year, @month, 1).wday
  end

  def convert_month_to_english(month)
    MONTH_NAME[month.to_s]
  end

  def print_all_weekdate
    puts " " + Week_date.join(' ')
  end

  # カレンダーの日付を整形して表示する
  #
  # 引数
  # first_date_by_num: 指定した月の曜日の整数表記
  # last_day: 表示する月の最終日(28 or 29 or 30 or 31)
  def print_date(first_date_by_num, last_day)

    set_first_position(first_date_by_num)
  
    (1..last_day).each do |i|
   
      # デフォルト出力フォーマット
      print_date = i.to_s
      
      print_date = "  " + ANSI_ESC + print_date + ANSI_ESC_END if today?(i)
    
      if Date.new(@year, @month, i).saturday?
        print_date = print_date.rjust(4) + "\n"
      end

      print print_date.rjust(4)

    end
    puts ""
  end
  
  def today?(day)
    Date.today == Date.new(@year, @month, day)
  end
  
  def print_formatted_calender

    puts "        #{convert_month_to_english(@month)} #{@year}"
    print_all_weekdate

    last_day = Date.new(@year, @month, -1).day

    print_date(get_first_wday(), last_day)
  end

  def set_first_position(first_date_by_num)
    print "    " * first_date_by_num
  end
end


# 今日の日付のオブジェクト
today = Date.today

year = today.year
month = today.month
day = today.day

params = ARGV.getopts("m:", "y:")

# -mオプションが指定されている場合
month = params["m"].to_i if params["m"]

# -yオプションが指定されている場合
year = params["y"].to_i if params['y']

cal = Calendar.new(year, month, day)

# カレンダー表示
cal.print_formatted_calender
