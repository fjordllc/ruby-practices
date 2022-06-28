# frozen_string_literal: true

require 'date'
require 'optparse'

LINE_LENGTH = 20

def cal
  params = ARGV.getopts('y:m:')

  if params['y'].nil? && params['m'].nil?
    date = Date.today
  elsif params['y'].present? && params['m'].present?
    date = Date.new(params['y'].to_i, params['m'].to_i, 1)
  else
    puts '引数が不正です。'
    puts '引数を設定する場合は、-yに年数、-mに月数の両方を渡してください'
    return
  end

  print_cal(date)
end

def print_cal(date)
  result_lines = []
  result_lines.push "#{date.month}月 #{date.year}".center(LINE_LENGTH)

  result_lines.push '日 月 火 水 木 金 土'

  first_day = 1
  last_day = Date.new(date.year, date.month, -1).day
  week = []

  (first_day..last_day).to_a.each do |day|
    week.push(day.to_s.rjust(2))

    if Date.new(date.year, date.month, day).saturday?
      result_lines.push week.join(' ').rjust(LINE_LENGTH)
      week.clear
    end
  end
  result_lines.push week.join(' ') unless week.empty?

  print result_lines.join('\n')
end

cal
