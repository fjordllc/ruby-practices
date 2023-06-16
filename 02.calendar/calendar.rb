#!/Users/iwamurahiroshi/.rbenv/shims/ruby

require 'date'
require 'optparse'

opt = OptionParser.new
displayed_year = Date.today.strftime('%Y').to_i
displayed_month = Date.today.strftime('%m').to_i
opt.on('-y VAL'){|v| displayed_year = v.to_i}
opt.on('-m VAL'){|v| displayed_month = v.to_i}
opt.parse!(ARGV)

biginning_of_the_month = Date.new(displayed_year, displayed_month, 1)
end_of_the_month = Date.new(displayed_year, displayed_month, -1)

all_days_of_the_month = [*biginning_of_the_month..end_of_the_month].map {|date| date.strftime('%e')}
biginning_of_the_month.strftime('%u').to_i.times {all_days_of_the_month.unshift('  ')} unless biginning_of_the_month.strftime('%u').to_i == 7

puts "#{displayed_month}月 #{displayed_year}".center(20)
puts "日 月 火 水 木 金 土"
all_days_of_the_month.each_slice(7) do |days|
  puts days.join(" ")
end
