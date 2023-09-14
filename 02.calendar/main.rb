# !ruby
# frozen_string_literal: true

require 'optparse'
require_relative './calendar'

# argvでコマンドライン引数を受け取る
params = ARGV.getopts('y:', 'm:') # ruby main.rb -m 1 => {"y"=>nil, "m"=>"01"}

# 受け取った日付からCalendarのインスタンスを作成
calendar = Calendar.new(params['y'], params['m'])
calendar.desplay_this_month_calendar
