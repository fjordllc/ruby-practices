#!/usr/bin/env ruby
require 'date'

date = Date.new(2023, 6, -1)

printf("      \e[31m%d\e[0m月 \e[31m%d\e[0m     \n", date.month, date.year)
puts '日 月 火 水 木 金 土'

(1..date.mday).each do |each_date|
  printf("\e[31m%2d \e[0m", each_date)
  puts "\n" if (each_date % 7).zero?
end
