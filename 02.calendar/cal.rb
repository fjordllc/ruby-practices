#!/usr/bin/env ruby

# frozen_string_literal: true

require 'date'
require 'optparse'

LINE_LENGTH = 20

def cal
  params = ARGV.getopts('y:m:')

  if !params['y'].nil? && params['m'].nil?
    puts '引数を設定する場合は、-yのみを指定することはできません。'
    return
  end

  year = params['y'].nil? ? Date.today.year : params['y'].to_i
  month = params['m'].nil? ? Date.today.month : params['m'].to_i
  first_date = Date.new(year, month, 1)

  print_cal(first_date)
end

def print_cal(first_date)
  result_lines = []
  result_lines.push "#{first_date.month}月 #{first_date.year}".center(LINE_LENGTH)
  result_lines.push '日 月 火 水 木 金 土'

  last_date = Date.new(first_date.year, first_date.month, -1)
  week = []

  (first_date..last_date).each do |date|
    week.push(date.day.to_s.rjust(2))

    if date.saturday? || date == last_date
      result_lines.push date.day < 7 ? week.join(' ').rjust(LINE_LENGTH) : week.join(' ')
      week.clear
    end
  end

  puts result_lines
end

cal
