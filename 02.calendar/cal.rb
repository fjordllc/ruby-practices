#!/usr/bin/env ruby

# frozen_string_literal: true

require 'date'
require 'optparse'

LINE_LENGTH = 20

def cal
  params = ARGV.getopts('y:m:')

  if params['y'].nil? && params['m'].nil?
    first_date = Date.new(Date.today.year, Date.today.month, 1)
  elsif !params['y'].nil? && !params['m'].nil?
    first_date = Date.new(params['y'].to_i, params['m'].to_i, 1)
  else
    puts '引数が不正です。'
    puts '引数を設定する場合は、-yに年数、-mに月数の両方を渡してください'
    return
  end

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
