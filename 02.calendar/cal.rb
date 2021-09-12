require "date"
require "optparse"

# 数字表記の月：英語表記の月
$month_name = {
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

# 数字表記の曜日：英語表記の月
$week_date = {
  "0":"Sun", 
  "1":"Mon", 
  "2":"Tue", 
  "3":"Wed",
  "4":"Thr",
  "5":"Fri",
  "6":"Sat"
}

# ANSIエスケープシーケンス（背景：白、文字色：黒）
ANSI_ESC = "\e[47m\e[30m"

# ANSIエスケープシーケンスのクローズ
ANSI_ESC_END = "\e[m"


class Calendar

 # 初期化
 def initialize(year, month, day, flg_year, flg_month)
  @year = year
  @month = month
  @day = day
  @flg_year = flg_year
  @flg_month = flg_month
 end

 # 月の最初の曜日を返す
 def get_first_wday
  return first_day = Date.new(@year, @month, 1).wday
 end

 # 月を数字表記から英語表記に直す
 # 
 # 引数
 # month: 数字表記の月
 #
 # For examlpe:
 #  convert_month_to_english("1")
 #   => Jan
 def convert_month_to_english(month)

  # month_nameのハッシュデータのkeyを探索する
  $month_name[month.to_s]

 end

 # カレンダーの曜日をコンソールに表示する
 #
 # For example:
 #   print_all_weekdate
 #      => Sun Mon Tue Wed Thr Fri Sat
 def print_all_weekdate
  $week_date.each_key do |key|
   print $week_date[key] + " "
  end
  puts ""
 end

 # カレンダー表示で改行される日付かどうかの判定をする
 # 引数
 #  first_date: カレンダー表示する月の1日にあたる曜日
 #  date: 判定対象の日付
 #
 # For example:
 #    check_newline(1,1)
 #      => false 
 #         # first_date == 1 のとき、表示月の1日は月曜日である。
 #           その場合、土曜日は 7 % date == 6 のときであり、そのときに改行する。    
 #    check_newline(3,4)
 #      => True
 #         # first_date == 3 のとき、表示月の1日は水曜日である。
 #           その場合、土曜日は 7 % date == 4 のときである、そのときに改行する。
 def check_newline(first_date, date)
  date_mod = date % 7
  if first_date == 1
    if date_mod == 6
      return true
    end
  elsif first_date == 2
    if date_mod == 5
      return true
    end
  elsif first_date == 3
    if date_mod == 4
      return true
    end
  elsif first_date == 4
    if date_mod == 3
      return true
    end
  elsif first_date == 5
    if date_mod == 2
      return true
    end
  elsif first_date == 6
    if date_mod == 1
      return true
    end
  elsif first_date == 0
    if date == 1
      return false
    elsif date_mod == 0
      return true
    end
  end

  return false
 end

 # カレンダーの日付を整形して表示する
 #
 # 引数
 # date: 指定した月の曜日の整数表記
 # last_day: 表示する月の最終日(28 or 29 or 30 or 31)
 # flg_year: 表示するカレンダーの年がオプションで指定されているかの判定フラグ
 # flg_month: 表示するカレンダーの月がオプションで指定されているかの判定フラグ
 #
 #
 def print_date(date, last_day, flg_year, flg_month)

  # 開始位置の設定
  set_first_position(date)
  
  # 今日の日付のフラグ
  flg_today = false
	
  (1..last_day).each do |i|
   
   # オプションにかかわるフラグ
   if flg_year and flg_month
    if i == @day
     flg_today = true
    else
     flg_today = false
    end
   end

    # デフォルト出力フォーマット
    print_str = " " + i.to_s
    
    # 今日日付の場合
    if flg_today
      print_str = ANSI_ESC + print_str + ANSI_ESC_END
    end
    
    # 表示位置を調整するための半角スペースを末尾に付ける
    print_str = print_str + " "
    
    # 日付が一桁の場合、表示位置を調整するため先頭に半角スペースをつける
    if i < 10
      print_str = " " + print_str
    end
    
    # 改行が必要の場合
    if check_newline(date,i)
      print_str = print_str.rstrip + "\n"
    end
    
    print print_str

  end
  puts ""
 end


 # 整形後のカレンダーを出力する
 #
 # 引数
 # 
 def print_calender

  # カレンダーのタイトル表示
  puts "        #{convert_month_to_english(@month)} #{@year}"

  # 曜日表示
  print_all_weekdate

  last_day = Date.new(@year, @month, -1).day

  # 日付表示
  print_date(get_first_wday(), last_day, @flg_year, @flg_month)
 end

 # １日の表示位置までスペースで埋める
 #
 # 引数
 # date: 数字表記の曜日
 def set_first_position(date)
   print "    " * date
 end
end


# 今日の日付のオブジェクト
day = Date.today

# year, month
day_year = day.year
day_month = day.month
day_day = day.day

# 今日日付用のフラグ
flg_year = true
flg_month = true

# コマンドライン引数をハッシュに格納する
# paramsには{"m"=>ARGV[0] ,"y"=>ARGV[1]}のハッシュが代入される
params = ARGV.getopts("m:", "y:")
cmd_month  = params["m"]
cmd_year = params["y"]

# オプション指定がある場合 
# -mオプションが指定されている場合
if cmd_month != nil
 if cmd_month != day_month
   flg_month = false
 end
 day_month = cmd_month.to_i
end

# -yオプションが指定されている場合
if cmd_year != nil
 if cmd_year != day_year
   flg_year = false
 end
 day_year = cmd_year.to_i
end

cal = Calendar.new(day_year, day_month, day_day, flg_year, flg_month)

# カレンダー表示
cal.print_calender
