# frozen_string_literal: true

THROW_TIMES_PER_1_FRAME = 2 # 1フレームにおける最大投球回数
TOTAL_PIN_COUNT_IN_1_FRAME = 10 # 1フレームの総ピン数
TOTAL_FLAME = 10 # 1ゲームの総フレーム数
scores = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'

class Bowling
  attr_reader :total_score, :flame_array

  def initialize
    @total_score = 0
    @flame_array = []

    TOTAL_FLAME.times do
      @flame_array.push(FlameScore.new)
    end
  end

  def throw(score)
    @total_score += score
    @flame_array
    # ストライクかどうか判定

  end

  private

end

class FlameScore
  attr_reader :flame_score, :first_throw_score, :second_throw_score

  def initialize(first_throw_score: false, second_throw_score: false)
    @first_throw_score = first_throw_score
    @second_throw_score = second_throw_score

    @flame_score = if first_throw_score
                     strike? ? TOTAL_PIN_COUNT_IN_1_FRAME : first_throw_score + second_throw_score
                   else
                     0
                   end
  end

  def record_flame_score(score)
    if !@first_throw_score
      @first_throw_score = score
    else
      @second_throw_score = score
    end
  end

  def spare?
    @first_throw_score + @second_throw_score == TOTAL_PIN_COUNT_IN_1_FRAME
  end

  def strike?
    @first_throw_score == 'X'
  end
end

def format_scores(scores_string)
  scores_array = scores_string.split(',')
  scores_array.push(0)
  scores_array.each_with_index do |score, i|
    if score == 'X'
      scores_array.insert(i + 1, false)
    elsif score
      scores_array[i] = score.to_i
    end
  end

  flame_scores = []
  scores_array.each_slice(THROW_TIMES_PER_1_FRAME) do |first_throw_score, second_throw_score|
    flame_scores.push(FlameScore.new(first_throw_score: first_throw_score, second_throw_score: second_throw_score))
  end

  flame_scores
end

def show_total_score(flame_scores)
  total_score = 0
  flame_scores.each_with_index do |flame, i|
    total_score += flame.flame_score
    next_flame = flame_scores[i + 1]
    if flame.strike? && i != flame_scores.size - 1
      total_score += next_flame.flame_score
      total_score += flame_scores[i + 2].first_throw_score if next_flame.strike? && i != flame_scores.size - 1
    elsif flame.spare? && i != flame_scores.size - 1
      total_score += next_flame.strike? ? next_flame.flame_score : next_flame.first_throw_score
    end
    p total_score
  end
  total_score
end

# fs = format_scores(scores)
# t = show_total_score(fs)

b = Bowling.new

p b
# binding.irb
