require 'optparse'
require 'date'

# コマンドラインで指定されたオプション引数の取得
def get_options(year, month)
  opt = OptionParser.new

  # オプションの登録
  opt.on('-y VAL') {|v| year  = v }
  opt.on('-m VAL') {|v| month = v }

  # コマンドラインのparse
  argv = opt.parse(ARGV)

  # 年月がコマンドラインで指定されない場合の対応
  now = Date.today
  if year == 0
    year = now.year
  end
  if month == 0
    month = now.month
  end

  return year, month
end

# カレンダーのヘッダー(年月と曜日)の表示
def show_header(year, month, day_of_week)
  # 年月の表示
  puts "      #{month}月 #{year}"
  puts "日 月 火 水 木 金 土"
  
  # 1日までの空白埋め
  if day_of_week > 0
    print "  " + "   " * (day_of_week - 1)
  end
end

# カレンダーの日付の表示
def show_calendar(end_month, day_of_week)
  (1..end_month.day).each do |day|
    case day_of_week
    when 6 # 土曜日
      print_day = day.to_s.rjust(3, " ") + "\n"
      day_of_week = 0
    when 0 # 日曜日
      print_day = day.to_s.rjust(2, " ")
      day_of_week += 1
    else # 月~金曜日
      print_day = day.to_s.rjust(3, " ")
      day_of_week += 1
    end

    # 今日の日付のハイライト
    if Date.today == Date.new(end_month.year.to_i, end_month.month.to_i, day)
      print "\e[30m\e[47m#{print_day}\e[0m"
    else
      print print_day
    end
 
    # 月末が土曜でない場合、改行を出力する
    if day == end_month.day && day_of_week != 0
      puts
    end
  end
  puts
end

# 年月の初期化
year  = 0
month = 0

# コマンドラインで指定された年月を取得する
year, month = get_options(year, month)

# 月初の日付情報
begin_month = Date.new(year.to_i, month.to_i, 1)
# 月末の日付情報
end_month   = Date.new(year.to_i, month.to_i, -1)

# 月初の曜日(0~6の数値と日~土曜日が対応している)
day_of_week = begin_month.wday

# 年月と曜日を表示する
show_header(year, month, day_of_week)

# カレンダーの日付表示
show_calendar(end_month, day_of_week)