require 'date'
require 'optparse'

def option_parse
  options = {}
  OptionParser.new do |opts|
    opts.on('-y', '--year YEAR') do |v|
      options[:year] = v.to_i
    end
    opts.on('-m', '--month MONTH') do |v|
      options[:month] = v.to_i
    end
  end.parse!

  options
end


def calendar(year:, month:)

  firstday = Date.new(year, month, 1)#月の最初の日
  lastday = Date.new(year, month, -1) #月の最終日
  dt = Date.today

  first_wday = firstday.wday #曜日を返す (0-6、日曜日は零)。ただし最初日が1のため、実質は1-7
  lastday_date = lastday.day #月の日を返す (1-31)。

  puts firstday.strftime("%m月 %Y").center(20)  #中央寄り
  puts "日 月 火 水 木 金 土"
  print " " * 3 * first_wday  #最初日をスペース(3bytes)でずらす。putsは改行するため、改行しないprint

  wday = first_wday
  (1..lastday_date).each do |date|    # 1~最終日まで繰り返し
    if dt.year == year && dt.month == month && dt.day == date  #今日の日付だったら
      print "\e[31m" #赤色にする
      print date.to_s.rjust(2) + " "  
      wday = wday+1
      print "\e[0m" #元の色に戻す
    else
      print date.to_s.rjust(2) + " "  # 日付を文字列＋右寄せ＋数字の間にスペースで表示
      wday = wday+1
      if wday%7==0  # 土曜日まで表示したら改行。実質土==7
        print "\n"
      end
    end
  end
  if wday%7!=0  #最終日が土曜日以外改行しないための処理
    print "\n"
  end
end

calendar(**option_parse) #**とするとHashの引数を受け取ることができる。
