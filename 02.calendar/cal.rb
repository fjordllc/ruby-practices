require 'date'
require 'optparse'

class Calender
  CALENDER_WEEK = ["日","月","火","水","木","金","土"]
  # カレンダーの日を取得
  def self.get_day(cal_day=1, cal_year=Date.today.year, cal_month=Date.today.month)
    # Date.new(cal_year, cal_month, cal_day)
    @start_day = Date.new(cal_year, cal_month, 1)
    @start_day_num = @start_day.strftime("%e").to_i
    @end_day_num = Date.new(cal_year, cal_month, -1).strftime("%e").to_i
    @cal_day = Date.new(cal_year, cal_month, cal_day)
  end
  # 日の間隔を調整
  def self.adjust_space(x)
    #get_day(1, cal_year, cal_month).strftime("%e").rjust(x)
    @start_day.strftime("%e").rjust(x)
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
        puts @cal_day.strftime("%e")
      elsif x == @end_day_num || @cal_day.saturday? then
        puts @cal_day.strftime("%e").rjust(3)
      elsif get_day(x, cal_year, cal_month).sunday?
        print(@cal_day.strftime("%e"))
      else
        print(@cal_day.strftime("%e").rjust(3))
      end
    end
  end
end

# Calender.show_calender(2022, 3)

opt = OptionParser.new
opt.on('-m [month]', Integer, 'show calender set month') {|v| Calender.show_calender(Date.today.year, v) }
opt.parse!(ARGV)
ARGV