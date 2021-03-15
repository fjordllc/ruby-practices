require 'date'
require 'optparse'
require "colcolor"
class Calender
  CALENDER_WEEK = ["日","月","火","水","木","金","土"]
  # カレンダーの日を取得
  def self.get_day(cal_day=1, cal_year, cal_month)
    @start_day = Date.new(cal_year, cal_month, 1)
    @start_day_num = @start_day.strftime("%e").to_i
    @end_day_num = Date.new(cal_year, cal_month, -1).strftime("%e").to_i
    @cal_day = Date.new(cal_year, cal_month, cal_day)
  end
  # 日の間隔を調整
  def self.adjust_space(x)
    if @cal_day == Date.today.strftime("%e").to_i then
      @start_day.strftime("%e").rjust(x).colco(:black_white)
    else
      @start_day.strftime("%e").rjust(x)
    end
  end
  # 月初日の表示位置を調整して表示
  def self.place_first_day
    if @start_day.sunday? then
      print(adjust_space(0))
    elsif @start_day.monday? then
      print(adjust_space(5))
    elsif @start_day.tuesday? then
      print(adjust_space(8))
    elsif @start_day.wednesday? then
      print(adjust_space(11))
    elsif @start_day.thursday? then
      print(adjust_space(14))
    elsif @start_day.friday? then
      print(adjust_space(17))
    elsif @start_day.saturday? then
      puts adjust_space(20)
    end
  end
  # カレンダーを表示
  def self.show_calender(cal_year, cal_month)
    get_day(1, cal_year, cal_month)
    # 月と年(西暦)を表示
    puts @start_day.strftime("     %-m月 %Y")
    # 曜日の間隔を調整して表示
    puts CALENDER_WEEK.join(" ")
    # 日を表示
    (@start_day_num..@end_day_num).each do |x|
      get_day(x, cal_year, cal_month)
      if x == @start_day_num then
        print(place_first_day)
      elsif x == @end_day_num && get_day(x, cal_year, cal_month).sunday?
        if @cal_day == Date.today.strftime("%e").to_i then
          puts @cal_day.strftime("%e").colco(:black_white)
        else
          puts @cal_day.strftime("%e")
        end
      elsif x == @end_day_num || @cal_day.saturday? then
        if @cal_day == Date.today.strftime("%e").to_i then
          puts @cal_day.strftime("%e").rjust(3).colco(:black_white)
        else
          puts @cal_day.strftime("%e").rjust(3)
        end
      elsif get_day(x, cal_year, cal_month).sunday?
        if @cal_day == Date.today.strftime("%e").to_i then
          print(@cal_day.strftime("%e").colco(:black_white))
        else
          print(@cal_day.strftime("%e"))
        end
      else
        if @cal_day == Date.today then
          print(@cal_day.strftime("%e").rjust(3).colco(:black_white))
        else
          print(@cal_day.strftime("%e").rjust(3))
        end
      end
    end
  end
end
# オプション引数を取得
options = {}
OptionParser.new do |opt|
  opt.on('-m [month]', Integer, 'Display the specified month.') {|v| options[:m] = v }
  opt.on('-y [year]', Integer, 'Display a calendar for the specified year.') {|v| options[:y] = v }
  opt.parse!(ARGV)
end
# オプション引数をもとに表示するカレンダーを選択
if options.empty? then
  Calender.show_calender(Date.today.year, Date.today.month)
elsif options.has_key?(:y) && options.has_key?(:m) then
  Calender.show_calender(options[:y], options[:m])
elsif options.has_key?(:y) then
  Calender.show_calender(options[:y], Date.today.month)
elsif options.has_key?(:m) then
  Calender.show_calender(Date.today.year, options[:m])
end