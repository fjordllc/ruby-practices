#!/usr/bin/env ruby

ScoresWithX = ARGV[0]
ScoresWithoutX = ScoresWithX.gsub(/X/, '10')
actual_throws = ScoresWithoutX.split(',')

# 1-9
score_board = []
9.times do
  if actual_throws[0] == '10'
    score_board << [10, 0]
    actual_throws.shift
  else
    score_board << actual_throws.slice!(0, 2).map(&:to_i)
  end
end

# 10
score_board << if actual_throws[0] == '10'
                 [10, actual_throws[1].to_i, actual_throws[2].to_i]
               elsif actual_throws[0].to_i + actual_throws[1].to_i == 10
                 [actual_throws[0].to_i, actual_throws[1].to_i, actual_throws[2].to_i]
               else
                 [actual_throws[0].to_i, actual_throws[1].to_i, 0]
               end

score_by_frame = [score_board[9][0] + score_board[9][1] + score_board[9][2]]
9.times do |n|
  score_by_frame << if score_board[n][0] == 10 && score_board[n + 1][0] == 10
                      if n == 8
                        20 + score_board[n + 1][1]
                      else
                        20 + score_board[n + 2][0]
                      end
                    elsif score_board[n][0] == 10
                      10 + score_board[n + 1][0] + score_board[n + 1][1]
                    elsif score_board[n][0] + score_board[n][1] == 10
                      10 + score_board[n + 1][0]
                    else
                      score_board[n][0] + score_board[n][1]
                    end
end

p score_by_frame.sum
