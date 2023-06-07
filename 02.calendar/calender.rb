require "optparse"
require "date"

#現在時刻のデータと、引数が与えられた時のデータを設定する
module Base_Date
  Today = Date.today
  opts = OptionParser.new
  input_time = opts.getopts(ARGV,"y:","m:")
  Get_year = input_time["y"].to_i 
  Get_month = input_time["m"].to_i
end


class Calender
  include Base_Date
  #年を設定する
  def year
    if Get_year != 0
      @year = Get_year
    else
      @year = Today.year
    end
  end
  #月を設定する
  def month
    if Get_month != 0
      @month = Get_month
    else 
      @month = Today.month
    end
  end
  #週を設定して、出力する
  def week
    week = ["日","月","火","水","木","金","土"]
    week.each{|wday| print wday.center(2)}
    puts "\n"
  end
  #日付を設定して、出力する
  def day
    first_day = Date.new(@year,@month,1).day
    last_day = Date.new(@year,@month,-1).day
    first_wday = Date.new(@year,@month,1).wday
    days = []
    #月の初日〜最終日までをdaysにpushする
    while  first_day <= last_day
      days.push(first_day)
      first_day += 1
    end
    #日付を表示する処理（最初の日の曜日によって分岐）
    case first_wday
    when 0
      days[0..6].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[7..13].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[14..20].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[21..27].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[28..30].each{|day| print day.to_s.center(3)}
      puts "\n"
    when 1
      print " ".center(3)
      days[0..5].each {|day| print day.to_s.center(3)}
      puts "\n"
      days[6..12].each {|day| print day.to_s.center(3)}
      puts "\n"
      days[13..19].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[20..26].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[27..30].each{|day| print day.to_s.center(3)}
      puts "\n"
    when 2
      2.times do print " ".center(3)
      end
      days[0..4].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[5..11].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[12..18].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[19..25].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[26..30].each{|day| print day.to_s.center(3)}
      puts "\n"
    when 3
      3.times do print " ".center(3)
      end
      days[0..3].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[4..10].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[11..17].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[18..24].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[25..30].each{|day| print day.to_s.center(3)}
      puts "\n"
    when 4
      4.times do print " ".center(3)
      end
      days[0..2].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[3..9].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[10..16].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[17..23].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[24..30].each{|day| print day.to_s.center(3)}
      puts "\n"
    when 5
      5.times do print " ".center(3)
      end
      days[0..1].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[2..8].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[9..15].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[16..22].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[23..29].each{|day| print day.to_s.center(3)}
      puts "\n"
      print days[30].to_s.center(3)
      puts "\n"
    when 6
      6.times do print " ".center(3)
      end
      print days[0].to_s.center(3)
      puts "\n"
      days[1..7].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[8..14].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[15..21].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[22..28].each{|day| print day.to_s.center(3)}
      puts "\n"
      days[29..30].each{|day| print day.to_s.center(3)}
      puts "\n"
    end
  end
end

calender = Calender.new

#表示する
print "#{calender.month.to_s}月 #{calender.year.to_s}\n".rjust(15)
calender.week
calender.day




