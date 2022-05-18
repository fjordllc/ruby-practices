require 'date'
require 'optparse'

opt = OptionParser.new

params = {}

opt.on('-m MONTH') {|v| v}
opt.on('-y YEAR') {|v| v}

argument = ARGV
opt.parse!(argument, into: params)
# 年と月を格納するハッシュ
month_year = {}

def convert_to_integer(month_year)
  month_year.each {|key, value| month_year[key] = Integer(value)}
end

def check_month(month)
  return true if (1..12).include?(month)

  puts "月は1から12月までを入力してください"
  false
end

def check_year(year)
  return true if year > 0

  puts "年は1以上を入力してください"
  false
end

def convert_and_check_value(hash)
  convert_to_integer(hash)
  if hash.length == 2
    exit unless check_month(hash[:m]) && check_year(hash[:y])
  else
    exit unless check_year(hash[:y])
  end
end

# month_yearハッシュに月と年の値を設定
def set_month_and_year(argument, params, month_year)
  unless argument.length + params.length <= 2
    puts "月と年のみを指定してください"
    exit
  end
  
  # オプションが指定されているときに、値を取り出す
  if params.has_key?(:m) && params.has_key?(:y)
    month_year[:m] = params[:m]
    month_year[:y] = params[:y]
    convert_and_check_value(month_year)
    return
  elsif params.has_key?(:y)
    month_year[:m] = argument.shift unless argument.empty?
    month_year[:y] = params[:y]
    convert_and_check_value(month_year)
    return
  elsif params.has_key?(:m)
    month_year[:m] = params[:m]
    month_year[:y] = argument.shift
    convert_and_check_value(month_year)
    return
  end
  
  # 引数のみ指定されている時に、値を取り出す
  if argument.length == 2
    month_year[:m] = argument.shift
    month_year[:y] = argument.shift
    convert_and_check_value(month_year)
    return
  elsif argument.length == 1
    month_year[:y] = argument.shift
    convert_and_check_value(month_year)
    return
  else
    ## オプションも引数も指定されていない場合。
    month_year[:m] = Date.today.month
    month_year[:y] = Date.today.year
  end
end

# 1ヶ月分のカレンダーを配列に格納するメソッド
def create_month_array(month_year)
  month = month_year[:m]
  year = month_year[:y]

  first_day = Date.new(year, month, 1)
  last_day = Date.new(year, month, -1)
  all_days = (first_day..last_day)
  all_days_of_month = []

  all_days.each do |day| 
    all_days_of_month.push day.day.to_s
    all_days_of_month.push "\n" if day.wday == 6
  end

  # 初日の曜日を揃えるための空白を挿入する
  first_day.wday.times {all_days_of_month.unshift " "}
  return all_days_of_month
end

# 1年分のカレンダーを表示するためのメソッド

# 配列に指定した数の空白を追加するメソッド
def add_blank(array, number_of_times)
  number_of_times.times {array.push " "}
end

# 月の初日前に、表示調整用の空白を挿入するメソッド
def add_beggining_blank(first_day, all_days_of_month)
  first_day.wday.times {all_days_of_month.unshift " "}
end

# 月の最終日以降に、表示調整用の空白を挿入するメソッド
# カレンダーのマス目(field)は、全部で7日 * 6週
def add_end_blank(all_days_of_month)
  number_of_calender_field = 7 * 6
  blank_number = number_of_calender_field - all_days_of_month.length
  add_blank(all_days_of_month, blank_number)
  # return all_days_of_month
end

# 1日から最終日までと、空白を配列に格納するメソッド
def set_days(month, year)
  first_day = Date.new(year, month, 1)
  last_day = Date.new(year, month, -1)
  all_days_of_month = []

  add_beggining_blank(first_day, all_days_of_month)
  (first_day..last_day).each do |day| 
    all_days_of_month.push day.day.to_s
  end
  add_end_blank(all_days_of_month)

  return all_days_of_month
end

# 月のレコードを作成するメソッド
def month_record(first_month, second_month, third_month)
  month_record = []
  add_blank(month_record, 3)
  month_record.push "#{first_month}"

  add_blank(month_record, 7)
  month_record.push "#{second_month}"

  add_blank(month_record, 7)
  month_record.push "#{third_month}"

  month_record.push "\n"
  return month_record
end

# 曜日のレコードを作成するメソッド
def day_of_week_record
  day_of_week_record = []
  day_of_week_array = ["日", "月", "火", "水", "木", "金", "土"]

  3.times do
    day_of_week_array.each do |day|
      day_of_week_record.push day
    end
    day_of_week_record.push "   "
  end

  day_of_week_record.push "\n"
  return day_of_week_record
end

# 3ヶ月分のカレンダーをまとめて、配列に格納するメソッド
def create_table(first_month, second_month, third_month, year)
  table = []
  # 月と曜日の行を挿入
  table.push month_record(first_month, second_month, third_month)
  table.push day_of_week_record

  first_month_days = set_days(first_month, year)
  second_month_days = set_days(second_month, year)
  third_month_days = set_days(third_month, year)
  
  6.times do |i|
    record = []
    first_index = 7 * i
    last_index = 7 * i + 6

    array = first_month_days[first_index..last_index]
    array.each {|value| record.push value}
    add_blank(record, 1)

    array = second_month_days[first_index..last_index]
    array.each {|value| record.push value}
    add_blank(record, 1)

    array = third_month_days[first_index..last_index]
    array.each {|value| record.push value}
    record.push "\n"
    
    record.map!{|value| value.to_s}
    # 既に2つのレコード(月と曜日)を挿入しているので、+2番目にレコードを挿入する
    table[i+2] = record
  end

  return table
end

def calender(month_year)
  if month_year.length == 2
    month = month_year[:m]
    year = month_year[:y]

    # カレンダーの横幅 = 7(曜日) * 3byte
    width = 21
    puts "#{month}月 #{year}".center(width)
    puts " 日 月 火 水 木 金 土"
    date = create_month_array(month_year)
    date.each {|day| print day.rjust(3)}
  else
    year = month_year[:y]

    # カレンダーの横幅 = (7(曜日)* 3(月) * 3byte + 2(空白) * 3byte)
    width =  69
    puts "#{year}年".center(width)

    (1..12).each_slice(3) do |month|
      first_month = month[0]
      second_month = month[1]
      third_month = month[2]

      table = create_table(first_month, second_month, 
                           third_month, year)
      table.each_with_index do |record, index|
        if index == 1
          # 曜日を表示する
          record.each {|value| print value.rjust(2)}
        else
          record.each {|value| print value.rjust(3)}
        end
      end
    end
  end
end

set_month_and_year(argument, params, month_year)
calender(month_year)
