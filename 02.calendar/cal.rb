require 'date'
require 'optparse'

#今日の日付とオプション入力から出力する年月を決定するメソッド
def identify_tgt_date(today)
  #出力する日付データを持たせるハッシュ変数「date」を作成 
  #初期値として今日の年月日を代入
  date = {year:today.year, month:today.mon, day:today.mday} 

  #オプション引数が指定された場合、その値を出力する年月に設定
  opt = OptionParser.new
  opt.on('-m VAL',Integer) do |m|
    if m >=1 && m<=12 #mが有効な値ならdateに反映
    date[:month]= m
    else #mが無効な値の場合、"invailid month"を返して終了
      return "invailid month"
    end 
  end
  opt.on('-y VAL',Integer) do |y| 
    if y >= 1 #yが有効な値ならdateに反映
      date[:year] = y
    else #yが無効な値の場合、"invailed year"を返して終了
      return "invailed year"
    end
  end
  opt.parse(ARGV)

  #オプション引数が有効な範囲であれば、それを反映した「date」を返す
  return date 
end

#日付ハッシュと今日のDateオブジェクトから、カレンダー出力に必要な情報へ加工するメソッド
def processing_date (date:, today:)
  info_for_cal = {} #カレンダー出力に必要な情報をまとめるハッシュを作成
  info_for_cal[:month] = date[:month]
  info_for_cal[:year] = date[:year]

  #出力する年月の初日の曜日を整数値で「:first_yobi」に設定
  info_for_cal[:first_yobi] = Date.new(date[:year],date[:month],1).wday

  #出力する年月の末日の数値を「:last_day」に設定
  info_for_cal[:last_day]= Date.new(date[:year],date[:month],-1).mday


  #出力する年月が今日の年月と一致していたら「:color_inv_date」に今日の日付(整数)を設定、
  #今日の年月と一致していなければ「:color_inv_date」にnilを設定
  if date[:year] == today.year && date[:month] == today.mon
    info_for_cal[:color_inv_date] = today.mday
  else
    info_for_cal[:color_inv_date] = nil
  end
  
  return info_for_cal
end

#カレンダーを出力するメソッド
def output_cal(info_for_cal)
  #月と年を出力
  puts "      #{info_for_cal[:month]}月 #{info_for_cal[:year]}"
  #曜日の名称を出力
  puts "日 月 火 水 木 金 土"
  #初日の曜日に応じて日付の出力開始位置を調整のためスペースを出力
  print "   " * info_for_cal[:first_yobi]
  #改行位置を決めるための変数countを設定
  count = info_for_cal[:first_yobi] 

  #カレンダーの日付部分を出力
  (1..info_for_cal[:last_day]).each do |day| 
    #color_inv_dateがdayと一致していたら色反転
    if info_for_cal[:color_inv_date] == day 
      print "\e[30m\e[47m"
      print "#{day}".rjust(2)
      print "\e[0m"
      print " "
      count += 1 
    else #一致していなければ通常の出力
      print "#{day}".rjust(2)+" "
      count += 1
    end
    if count >= 7  #7日分文字が出力されていれば改行文字を出力
      print "\n"
      count = 0
    end
  end
  puts "" #なぜか最後に%が表示されてしまう問題への暫定策
end
」

#mainプログラム
today = Date.today
tgt_date = identify_tgt_date(today)
#バリデーションチェック
if tgt_date == "invailid month"
  puts "指定された月の値は無効です。1～12の範囲で入力して下さい。"
elsif tgt_date == "invailed year"
  puts "指定された西暦の値は無効です。1以上の値を入力して下さい"
else
  #入力値が適正であれば出力の処理を進める
  info_for_cal = processing_date(date:tgt_date,today:today)
  output_cal(info_for_cal)
end