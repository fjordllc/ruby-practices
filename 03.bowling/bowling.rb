#!/usr/bin/env ruby
# frozen_string_literal: true

class BowlingGame
  def initialize(scores)
    @shots = []
    scores.each do |s|
      @shots << if s == 'X'
                  10
                else
                  s.to_i
                end
    end
  end

  # スコアを計算するメイン関数
  def score
    total_score = 0 # スコアの合計
    shot_index = 0 # 何投目かのインデックス

    (1..10).each do |i|
      if lastframe?(i)
        total_score += lastframe_score(shot_index)
      elsif strike?(shot_index)
        total_score += strike_score(shot_index)
        shot_index += 1
      elsif spare?(shot_index)
        total_score += spare_score(shot_index)
        shot_index += 2
      else
        total_score += frame_score(shot_index)
        shot_index += 2
      end
    end
    total_score
  end

  # 最後のフレームか判定する関数
  def lastframe?(frame_index)
    frame_index == 10
  end

  # ストライクか判定する関数
  def strike?(shot_index)
    @shots[shot_index] == 10
  end

  # スペアか判定する関数
  def spare?(shot_index)
    @shots[shot_index] + @shots[shot_index + 1] == 10
  end

  # 最後のフレームのスコアを計算する関数
  def lastframe_score(shot_index)
    lastframe_score = 0
    (shot_index..@shots.length - 1).each do |i|
      lastframe_score += @shots[i]
    end
    lastframe_score
  end

  # ストライクのスコアを計算する関数
  def strike_score(shot_index)
    @shots[shot_index] + @shots[shot_index + 1] + @shots[shot_index + 2]
  end

  # スペアのスコアを計算する関数
  def spare_score(shot_index)
    @shots[shot_index] + @shots[shot_index + 1] + @shots[shot_index + 2]
  end

  # ストライクやスペアでないスコアを計算する関数
  def frame_score(shot_index)
    @shots[shot_index] + @shots[shot_index + 1]
  end
end

scores = ARGV[0].split(',')
game = BowlingGame.new(scores)
puts game.score
