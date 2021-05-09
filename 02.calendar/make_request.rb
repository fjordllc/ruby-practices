require 'optparse'

class MakeRequest
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  
  def initialize
    @keys = { y: THIS_Y, m: THIS_M }
  end
  
  def optparse
    opt = OptionParser.new
    parse_year(opt)
    parse_month(opt)
    opt.parse!(ARGV)
    @keys
  end

  def parse_year(opt)
    opt.on('-y VAL') do |v|
      @keys[:y] = v if correct_year?(v)
    end
  end

  def parse_month(opt)
    opt.on('-m VAL') do |v|
      @keys[:m] = v if correct_month?(v)
    end
  end

  def correct_month?(num)
    num.to_i.between?(1, 12)
  end

  def correct_year?(num)
    num.to_i.between?(0, 9999)
  end
end