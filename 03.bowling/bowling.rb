#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

STRIKE = 10
SPARE = 10
MAX_FLAME = 10

def option_perse
  opt = OptionParser.new
  opt.on('score', 'ボーリングのスコアを,区切りで入力してください。')
  opt.banner = 'ボーリングのスコアを,区切りで入力してください。'
  opt.parse(ARGV)
  ARGV
end

def array_to_i(scores)
  result = scores.gsub('X', '10').split(',')
  result.map(&:to_i)
end

def score_calc(int_scores)
  flame = []
  throw_count = 0
  MAX_FLAME.times.each do
    score = int_scores[throw_count]
    next_score = int_scores[throw_count + 1]
    next_next_score = int_scores[throw_count + 2]
    if score == STRIKE
      flame.push(STRIKE + next_score + next_next_score)
      throw_count += 1
    elsif score + next_score == SPARE
      flame.push(SPARE + next_next_score)
      throw_count += 2
    else
      flame.push(score + next_score)
      throw_count += 2
    end
  end
  flame.sum
end

input_scores = option_perse[0]
int_scores = array_to_i(input_scores)
puts score_calc(int_scores)
