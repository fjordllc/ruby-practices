require 'date'
require 'optparse'

class Calender
  CALENDER_WEEK = ["日","月","火","水","木","金","土"]

  def self.get_day(cal_day=1, cal_year=Date.today.year, cal_month=Date.today.month)
    Date.new(cal_year, cal_month, cal_day)
  end

  def self.create_space(x, cal_year, cal_month)
    get_day(1, cal_year, cal_month).strftime("%e").rjust(x)
  end

  def self.first_day_search(cal_year, cal_month)
    if get_day(1, cal_year, cal_month).sunday? then
      print(create_space(0, cal_year, cal_month))
    elsif get_day(1, cal_year, cal_month).monday? then
      print(create_space(5, cal_year, cal_month))
    elsif get_day(1, cal_year, cal_month).tuesday? then
      print(create_space(8, cal_year, cal_month))
    elsif get_day(1, cal_year, cal_month).wednesday? then
      print(create_space(11, cal_year, cal_month))
    elsif get_day(1, cal_year, cal_month).thursday? then
      print(create_space(14, cal_year, cal_month))
    elsif get_day(1, cal_year, cal_month).friday? then
      print(create_space(17, cal_year, cal_month))
    elsif get_day(1, cal_year, cal_month).saturday? then
      puts create_space(20, cal_year, cal_month)
    end
  end

  def self.show_calender(cal_year, cal_month)
    puts get_day(1, cal_year, cal_month).strftime("     %-m月 %Y")
    puts CALENDER_WEEK.join(" ")
    (get_day(1, cal_year, cal_month).strftime("%e").to_i..get_day(-1, cal_year, cal_month).strftime("%e").to_i).each do |x|
      if get_day(x, cal_year, cal_month).strftime("%e").to_i == get_day(1, cal_year, cal_month).strftime("%e").to_i then
        print(first_day_search(cal_year, cal_month))
      elsif get_day(x, cal_year, cal_month).strftime("%e").to_i == get_day(-1, cal_year, cal_month).strftime("%e").to_i || get_day(x, cal_year, cal_month).saturday? then
        puts get_day(x, cal_year, cal_month).strftime("%e").rjust(3)
      elsif get_day(x, cal_year, cal_month).sunday?
        print(get_day(x, cal_year, cal_month).strftime("%e"))
      else
        print(get_day(x, cal_year, cal_month).strftime("%e").rjust(3))
      end
    end
  end
end
# Calender.show_calender(Date.today.year, v)
opt = OptionParser.new
opt.on('-m [month]', Integer, 'show calender set month') {|v| Calender.show_calender(Date.today.year, v) }
opt.on('-y [year]', Integer, 'show calender set month') {|v| Calender.show_calender(v, Date.today.month) }
opt.parse!(ARGV)
ARGV