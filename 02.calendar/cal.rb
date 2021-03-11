require 'date'
require 'optparse'

class Calender
  CALENDER_WEEK = ["日","月","火","水","木","金","土"]

  def self.get_day(cal_day=1, cal_year=Date.today.year, cal_month=Date.today.month)
    Date.new(cal_year, cal_month, cal_day)
  end

  def self.create_space(x)
    get_day(1).strftime("%e").rjust(x)
  end

  def self.first_day_search
    if get_day(1).monday? then
      print(create_space(5))
    elsif get_day(1).tuesday? then
      print(create_space(8))
    elsif get_day(1).wednesday? then
      print(create_space(11))
    elsif get_day(1).thursday? then
      print(create_space(14))
    elsif get_day(1).friday? then
      print(create_space(17))
    end
  end

  CALENDER_START = get_day().strftime("%e").to_i
  CALENDER_END = get_day(-1).strftime("%e").to_i

  def self.show_calender
    puts get_day().strftime("     %-m月 %Y")
    puts CALENDER_WEEK.join(" ")
    (CALENDER_START..CALENDER_END).each do |x|
      if get_day(x).strftime("%e").to_i == CALENDER_START then
        print(first_day_search)
      elsif get_day(x).strftime("%e").to_i == CALENDER_END || get_day(x).saturday? then
        puts get_day(x).strftime("%e").rjust(3)
      elsif get_day(x).sunday?
        print(get_day(x).strftime("%e"))
      else
        print(get_day(x).strftime("%e").rjust(3))
      end
    end
  end
end

opt = OptionParser.new
Calender.show_calender