require "date"
require "optparse"

# 数字表記の月：英語表記の月
Month_name = {
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

  # 初期化
  def initialize(year, month, day)
    @year = year
    @month = month
    @day = day
  end

  # 月の最初の曜日を返す
  def get_first_wday
    return Date.new(@year, @month, 1).wday
  end

  # 月を数字表記から英語表記に直す
  def convert_month_to_english(month)
    # month_nameのハッシュデータのkeyを探索する
    Month_name[month.to_s]
  end

  # カレンダーの曜日をコンソールに表示する
  def print_all_weekdate
    puts " " + Week_date.join(' ')
  end

  # カレンダーの日付を整形して表示する
  #
  # 引数
  # wday: 指定した月の曜日の整数表記
  # last_day: 表示する月の最終日(28 or 29 or 30 or 31)
  def print_date(wday, last_day)

    # 開始位置の設定
    set_first_position(wday)
  
    (1..last_day).each do |i|
   
      # デフォルト出力フォーマット
      print_date = i.to_s
      
      # 今日日付の場合
      if today?(i)
        print_date = "  " + ANSI_ESC + print_date + ANSI_ESC_END
      end
    
      # 改行が必要の場合
      if saturday?(@year, @month, i)
        print_date = print_date.rjust(4) + "\n"
      end
    
      print print_date.rjust(4)

    end
    puts ""
  end
  
  def today?(day)
    if Date.today == Date.new(@year, @month,day)
      return true
    end
  end
  
  def saturday?(year, month, day)
    wday = Date.new(year, month, day).wday
    if wday == 6
      return true
    end
  end

  def print_formatted_calender

    puts "        #{convert_month_to_english(@month)} #{@year}"
    print_all_weekdate

    last_day = Date.new(@year, @month, -1).day

    print_date(get_first_wday(), last_day)
  end

  # １日の表示位置までスペースで埋める
  #
  # 引数
  # wday: 数字表記の曜日
  def set_first_position(wday)
    print "    " * wday
  end
end


# 今日の日付のオブジェクト
today = Date.today

# year, month
year = today.year
month = today.month
day = today.day

# コマンドライン引数をハッシュに格納する
params = ARGV.getopts("m:", "y:")
cmd_month  = params["m"]
cmd_year = params["y"]

# オプション指定がある場合 
# -mオプションが指定されている場合
if cmd_month
  month = cmd_month.to_i
end

# -yオプションが指定されている場合
if cmd_year
  year = cmd_year.to_i
end

cal = Calendar.new(year, month, day)

# カレンダー表示
cal.print_formatted_calender
