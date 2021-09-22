#!/usr/bin/env ruby

require 'date'

date = Date.today
puts ("#{date.month}月 #{date.year}")

week = ['日','月','火','水','木','金','土']
puts week.join(' ')

puts first_day = 1
puts last_day = Date.new(2021, 9, -1)