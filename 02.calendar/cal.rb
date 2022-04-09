# frozen_string_literal: true

require 'optparse'
require 'date'

opt = OptionParser.new
opt.on('-y') { |v| v }
opt.on('-m') { |v| v }
opt.parse!(ARGV)
y = ARGV[0].to_i
m = ARGV[1].to_i

begin
  dd = Date.new(y, m)
rescue ArgumentError
  dd = Date.new(y = Date.today.year, m = Date.today.month)
end

firstdate = Date.new(y, m, 1)
lastdate = Date.new(y, m, -1)
caltitle = "#{dd.month}月 #{dd.year}"
calwday = '日 月 火 水 木 金 土'

puts caltitle.center(20)
puts calwday
print ('   ' * firstdate.wday).to_s
(firstdate..lastdate).each do |calday|
  print "#{calday.mday.to_s.rjust(2)} ".to_s
  puts if calday.wday == 6
end
puts
