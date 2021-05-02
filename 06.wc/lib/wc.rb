#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def count_character(str)
  str.size
end

def count_letter(str)
  str.split(/\s|\t|\n/).count { |x| x.size.positive? }
end

def count_line(str)
  str.count("\n")
end

def total_results!(results)
  total = { line: 0, letter: 0, char: 0, name: 'total' }
  results.each do |result|
    total[:line] += result[:line]
    total[:letter] += result[:letter]
    total[:char] += result[:char]
  end
  results.push(total)
end

def pritty_print(results, params)
  results.each do |result|
    print result[:line].to_s.rjust(8)
    unless params[:l]
      print result[:letter].to_s.rjust(8)
      print result[:char].to_s.rjust(8)
    end
    puts format(' %s', result[:name])
  end
end

def check_string(str, name)
  result = {}
  result[:line] = count_line(str)
  result[:letter] = count_letter(str)
  result[:char] = count_character(str)
  result[:name] = name
  result
end

params = {}
opt = OptionParser.new
opt.on('-l') { |v| params[:l] = v }
opt.permute!(ARGV)
target_files = ARGV != [] ? ARGV : ''

results = []
if target_files.size.positive?
  target_files.each do |f|
    if File.readable?(File.expand_path(f))
      io = File.open(File.expand_path(f))
      results.push(check_string(io.read, f))
    else
      echo "error: #{f} fail open"
    end
  end
else
  input = readlines.inject('') { |result, line| result + line }
  results.push(check_string(input, ''))
end

if results.size.positive?
  total_results!(results) if target_files.size > 1
  pritty_print(results, params)
else
  echo 'error: no file'
end
