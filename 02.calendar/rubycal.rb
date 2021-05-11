# frozen_string_literal: true

require 'optparse'
require 'date'
keys = { y: Date.today.year, m: Date.today.mon }

opt = OptionParser.new
opt.on('-y VAL') { |v| keys[:y] = v }
opt.on('-m VAL') { |v| keys[:m] = v }
opt.parse!(ARGV)

month_last_d = Date.new(keys[:y].to_i, keys[:m].to_i, -1).day
month_first_w = Date.new(keys[:y].to_i, keys[:m].to_i, 1).wday

days = (1..month_last_d).to_a.map { |day| day.to_s.rjust(3) }
month_first_w.times { days.unshift("\s\s\s") }
result = days.each_slice(7).map { |week| week << "\n"}
puts "      #{keys[:m]}月 #{keys[:y]}年"
puts ' 日 月 火 水 木 金 土'
puts result.join
