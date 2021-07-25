require "date"
require "optparse"

# 数字表記の月：英語表記の月
$month_name = {"1" => "Jan", "2" => "Feb", "3" => "Mar", "4" => "Apr", "5" => "May", "6" => "Jun", "7" => "Jul", "8" => "Aug", "9" => "Sep", "10" => "Oct", "11" => "Nov", "12" => "Dec"}

# 数字表記の曜日：英語表記の月
$week_date = {"0":"Sun", "1":"Mon", "2":"Tue", "3":"Wed", "4":"Thr", "5":"Fri", "6":"Sat"}

# 日付の初期値
$today_date = 1

# 年の初期値
$this_year = 1970

# 月の初期値
$this_month = 1

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
		return first_day = Date.new(@year, @month, 1).wday
	end

	# 月を数字表記から英語表記に直す
	# 
	# 引数
	# month: 数字表記の月
	#
	# For examlpe:
	#		convert_month_to_english("1")
	#			=> Jan
	def convert_month_to_english(month)

		# month_nameのハッシュデータのkeyを探索する
		$month_name.each_key do |key|
			# keyと引数のmonthを比較して等しければ、対応するvalueを返す
			if key.to_i == month
				return $month_name[month.to_s]
			end
		end
	end

	# カレンダーの曜日をコンソールに表示する
	#
	# For example:
	#			print_all_weekdate
	#    		=> Sun Mon Tue Wed Thr Fri Sat
	def print_all_weekdate
		$week_date.each_key do |key|
			print $week_date[key] + " "
		end
		puts ""
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
				if i == $today_date
					flg_today = true
				else
					flg_today = false
				end
			end

			if i % 7 == 7 - date
				if i < 10
					if flg_today
						puts " " + ANSI_ESC + " " + i.to_s + ANSI_ESC_END
					else
						puts "  " + i.to_s
					end
				else
					if flg_today
						puts ANSI_ESC + " " + i.to_s + ANSI_ESC_END
					else
						puts " " + i.to_s
					end
				end
			else
				if i < 10
					if flg_today
						print " " + ANSI_ESC + " " + i.to_s + ANSI_ESC_END + " "
					else
						print "  " + i.to_s + " "
					end
				else
					if flg_today
						print ANSI_ESC + " " + i.to_s + ANSI_ESC_END + " "
					else
						print " " + i.to_s + " "
					end
				end
			end
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

		flg_year= false

		flg_month = false

		if @year == $this_year
			flg_year = true
		end

		if @month == $this_month
			flg_month = true
		end

		#puts(get_first_wday())

		# 日付表示
		print_date(get_first_wday(), last_day, flg_year, flg_month)
	end

	# １日の表示位置までスペースで埋める
	#
	# 引数
	# date: 数字表記の曜日
	def set_first_position(date)
		date.times do
			print "    "
		end
	end
end


# 今日の日付のオブジェクト
day = Date.today

# year, month
day_year = day.year
day_month = day.month
day_day = day.day

# 現在の年、月を取得
$today_date= day_day
$this_month = day_month
$this_year = day_year

# コマンドライン引数をハッシュに格納する
# paramsには{"m"=>ARGV[0] ,"y"=>ARGV[1]}のハッシュが代入される
params = ARGV.getopts("m:", "y:")
cmd_month  = params["m"]
cmd_year = params["y"]

# オプション指定がない場合
if cmd_month == nil && cmd_year == nil

	cal = Calendar.new(day_year, day_month, day_day)

# オプション指定がある場合	
else
	
	# -mオプションが指定されている場合
	if cmd_month != nil
		day_month = cmd_month.to_i
	end
	
	# -yオプションが指定されている場合
	if cmd_year != nil
		day_year = cmd_year.to_i
	end

	cal = Calendar.new(day_year, day_month, day_day)

end

# カレンダー表示
cal.print_calender
