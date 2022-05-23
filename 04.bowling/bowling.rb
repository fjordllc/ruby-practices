# frozen_string_literal: true

class Bowling
  attr_reader :total_score, :frames

  TOTAL_FRAME = 10 # 1ゲームの総フレーム数

  def initialize
    @total_score = 0
    @frames = []

    TOTAL_FRAME.times do |i|
      if i == TOTAL_FRAME - 1
        @frames.push(LastFrame.new)
      else
        @frames.push(Frame.new)
      end
    end
  end

  def shot(score)
    score = score.to_i unless score == 'X'
    current_frame = @frames.find { |frame| frame.recorded? == false }
    current_frame.add_frame_score(score)
  end

  def calculate_total_score
    @total_score = @frames.each_with_index.sum do |frame, i|
      frame_total_score = frame.frame_score
      next_frame = @frames[i + 1]
      if frame.strike?
        frame_total_score += next_frame.first_shot_score
        frame_total_score += next_frame.strike? ? @frames[i + 2].first_shot_score : next_frame.second_shot_score
      elsif frame.spare?
        frame_total_score += next_frame.first_shot_score
      end
      frame_total_score
    end
  end
end

class Frame
  attr_reader :frame_score, :first_shot_score, :second_shot_score

  TOTAL_PIN_COUNT_IN_1_FRAME = 10 # 1フレームの総ピン数

  def initialize
    @first_shot_score = nil
    @second_shot_score = nil
    @frame_score = 0
  end

  def add_frame_score(score)
    return if recorded?

    score = score == 'X' ? TOTAL_PIN_COUNT_IN_1_FRAME : score

    unless @first_shot_score
      @first_shot_score = score
      @frame_score += @first_shot_score
      return
    end
    @second_shot_score = score
    @frame_score += @second_shot_score
  end

  def spare?
    !strike? && @first_shot_score.to_i + @second_shot_score.to_i == TOTAL_PIN_COUNT_IN_1_FRAME
  end

  def strike?
    @first_shot_score == TOTAL_PIN_COUNT_IN_1_FRAME
  end

  def recorded?
    strike? || !@second_shot_score.nil?
  end
end

class LastFrame < Frame
  attr_reader :third_shot_score

  def initialize
    super
    @third_shot_score = 0
  end

  def add_frame_score(score)
    unless @second_shot_score.nil?
      score = score == 'X' ? TOTAL_PIN_COUNT_IN_1_FRAME : score
      @third_shot_score = score
      @frame_score += @third_shot_score
      return
    end
    super
  end

  def spare?
    false
  end

  def strike?
    false
  end

  def recorded?
    false
  end
end

def show_bowling_total_score(scores)
  scores_array = scores.split(',')
  bowling = Bowling.new
  scores_array.each do |score|
    bowling.shot(score)
  end

  puts bowling.calculate_total_score
end

show_bowling_total_score(ARGV[0])
