# frozen_string_literal: true

require 'byebug'

TOTAL_PIN_COUNT_IN_1_FRAME = 10 # 1フレームの総ピン数
TOTAL_FLAME = 10 # 1ゲームの総フレーム数
# scores = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
scores = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'

class Bowling
  attr_reader :total_score, :flame_array

  def initialize
    @total_score = 0
    @flame_array = []

    TOTAL_FLAME.times do |i|
      if i == TOTAL_FLAME - 1
        @flame_array.push(LastFlame.new)
      else
        @flame_array.push(Flame.new)
      end
    end
  end

  def shot(score)
    score = score.to_i unless score == 'X'
    @flame_array.each do |flame|
      next if flame.is_recorded

      flame.add_flame_score(score)
      break
    end
  end

  def calculate_total_score
    @flame_array.each_with_index do |flame, i|
      @total_score += flame.flame_score

      break if flame.instance_of?(LastFlame)

      next_flame = @flame_array[i + 1]
      if flame.strike?
        @total_score += next_flame.first_shot_score
        @total_score += next_flame.second_shot_score
        @total_score += @flame_array[i + 1].first_shot_score if next_flame.strike?
      elsif flame.spare?
        @total_score += next_flame.first_shot_score
      end
    end
    @total_score
  end
end

class Flame
  attr_reader :flame_score, :first_shot_score, :second_shot_score, :is_recorded

  def initialize
    @first_shot_score = nil
    @second_shot_score = nil
    @flame_score = 0
    @is_recorded = false
  end

  def add_flame_score(score)
    return if @is_recorded

    score = score == 'X' ? TOTAL_PIN_COUNT_IN_1_FRAME : score

    unless @first_shot_score
      @first_shot_score = score
      @flame_score += @first_shot_score
      @is_recorded = true if strike?
      return
    end
    @second_shot_score = score
    @flame_score += @second_shot_score
    @is_recorded = true
  end

  def spare?
    !strike? && @first_shot_score.to_i + @second_shot_score.to_i == TOTAL_PIN_COUNT_IN_1_FRAME
  end

  def strike?
    @first_shot_score == TOTAL_PIN_COUNT_IN_1_FRAME
  end
end

class LastFlame < Flame
  attr_reader :third_shot_score

  def initialize
    super
    @third_shot_score = 0
  end

  def add_flame_score(score)
    return if @is_recorded

    score = score == 'X' ? TOTAL_PIN_COUNT_IN_1_FRAME : score

    unless @first_shot_score
      @first_shot_score = score
      @flame_score += @first_shot_score
      return
    end
    unless @second_shot_score
      @second_shot_score = score
      @flame_score += @second_shot_score
      return
    end
    @third_shot_score = score
    @flame_score += @third_shot_score

    @is_recorded = true
  end
end

scores_array = scores.split(',')
bowling = Bowling.new

scores_array.each do |score|
  bowling.shot(score)
end
total_score = bowling.calculate_total_score
byebug

p bowling
# binding.irb
