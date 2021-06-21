#!/usr/bin/env ruby

require 'date'
require 'optparse'

opt = OptionParser.new
opt.on('-m','-y')
opt.parse!(ARGV)

now = Time.now
day_of_week = ' 日 月 火 水 木 金 土'
day1 = Date.new(2021,6 ,1)
day2 = Date.new(2021,6 ,2)
day3 = Date.new(2021,6 ,3)
day4 = Date.new(2021,6 ,4)
day5 = Date.new(2021,6 ,5)
day6 = Date.new(2021,6 ,6)
day7 = Date.new(2021,6 ,7)
day8 = Date.new(2021,6 ,8)
day9 = Date.new(2021,6 ,9)
day10 = Date.new(2021,6 ,10)
day11 = Date.new(2021,6 ,11)
day12 = Date.new(2021,6 ,12)
day13 = Date.new(2021,6 ,13)
day14 = Date.new(2021,6 ,14)
day15 = Date.new(2021,6 ,15)
day16 = Date.new(2021,6 ,16)
day17 = Date.new(2021,6 ,17)
day18 = Date.new(2021,6 ,18)
day19 = Date.new(2021,6 ,19)
day19 = Date.new(2021,6 ,19)
day20 = Date.new(2021,6 ,20)
day21 = Date.new(2021,6 ,21)
day22 = Date.new(2021,6 ,22)
day23 = Date.new(2021,6 ,23)
day24 = Date.new(2021,6 ,24)
day25 = Date.new(2021,6 ,25)
day26 = Date.new(2021,6 ,26)
day27 = Date.new(2021,6 ,27)
day28 = Date.new(2021,6 ,28)
day29 = Date.new(2021,6 ,29)
daylast = Date.new(2021,6 ,-1)
print("      ",now.month, "月 ", now.year, "\n")
print(day_of_week,"\n")

print day1.strftime('       %e')
print day2.strftime(' %e')
print day3.strftime(' %e')
print day4.strftime(' %e')
print day5.strftime(' %e'),"\n"
print day6.strftime(' %e')
print day7.strftime(' %e')
print day8.strftime(' %e')
print day9.strftime(' %e')
print day10.strftime(' %e')
print day11.strftime(' %e')
print day12.strftime(' %e'),"\n"
print day13.strftime(' %e')
print day14.strftime(' %e')
print day15.strftime(' %e')
print day16.strftime(' %e')
print day17.strftime(' %e')
print day18.strftime(' %e')
print day19.strftime(' %e'),"\n"
print day20.strftime(' %e')
print day21.strftime(' %e')
print day22.strftime(' %e')
print day23.strftime(' %e')
print day24.strftime(' %e')
print day25.strftime(' %e')
print day26.strftime(' %e'),"\n"
print day27.strftime(' %e')
print day28.strftime(' %e')
print day29.strftime(' %e')
print daylast.strftime(' %e'),"\n"
