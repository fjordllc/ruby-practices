#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'optparse'

DOW = "日 月 火 水 木 金 土\n"
opt = OptionParser.new
params = {}

opt.on('-m VAL') { |v| params[:month] = v }
opt.on('-y VAL') { |v| params[:year] = v }
opt.parse!(ARGV)

# 引数が渡されなかった際に当年当月を格納する
params[:month] = Date.today.month if params[:month].nil?
params[:year] = Date.today.year if params[:year].nil?

def title(month, year)
  "      #{month}月 #{year}\n"
end

def render(month, year)
  result = title(month, year) + DOW
  puts result
end

render(params[:month], params[:year])
