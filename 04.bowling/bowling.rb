# frozen_string_literal: true

class Bowling
  attr_reader :total_score, :frame_array

  TOTAL_FRAME = 10 # 1ゲームの総フレーム数

  def initialize
    @total_score = 0
    @frame_array = []

    TOTAL_FRAME.times do |i|
      if i == TOTAL_FRAME - 1
        @frame_array.push(LastFrame.new)
      else
        @frame_array.push(Frame.new)
      end
    end
  end

  def shot(score)
    score = score.to_i unless score == 'X'
    @frame_array.each do |frame|
      next if frame.is_recorded

      frame.add_frame_score(score)
      break
    end
  end

  def calculate_total_score
    @frame_array.each_with_index do |frame, i|
      @total_score += frame.frame_score

      break if frame.instance_of?(LastFrame)

      next_frame = @frame_array[i + 1]
      if frame.strike?
        @total_score += next_frame.first_shot_score
        @total_score += next_frame.strike? ? @frame_array[i + 2].first_shot_score : next_frame.second_shot_score
      elsif frame.spare?
        @total_score += next_frame.first_shot_score
      end
    end
    @total_score
  end
end

class Frame
  attr_reader :frame_score, :first_shot_score, :second_shot_score, :is_recorded

  TOTAL_PIN_COUNT_IN_1_FRAME = 10 # 1フレームの総ピン数

  def initialize
    @first_shot_score = nil
    @second_shot_score = nil
    @frame_score = 0
    @is_recorded = false
  end

  def add_frame_score(score)
    return if @is_recorded

    score = score == 'X' ? TOTAL_PIN_COUNT_IN_1_FRAME : score

    unless @first_shot_score
      @first_shot_score = score
      @frame_score += @first_shot_score
      @is_recorded = true if strike?
      return
    end
    @second_shot_score = score
    @frame_score += @second_shot_score
    @is_recorded = true
  end

  def spare?
    !strike? && @first_shot_score.to_i + @second_shot_score.to_i == TOTAL_PIN_COUNT_IN_1_FRAME
  end

  def strike?
    @first_shot_score == TOTAL_PIN_COUNT_IN_1_FRAME
  end
end

class LastFrame < Frame
  attr_reader :third_shot_score

  def initialize
    super
    @third_shot_score = 0
  end

  def add_frame_score(score)
    return if @is_recorded

    score = score == 'X' ? TOTAL_PIN_COUNT_IN_1_FRAME : score

    unless @first_shot_score
      @first_shot_score = score
      @frame_score += @first_shot_score
      return
    end
    unless @second_shot_score
      @second_shot_score = score
      @frame_score += @second_shot_score
      return
    end
    @third_shot_score = score
    @frame_score += @third_shot_score

    @is_recorded = true
  end

  def spare?
    false
  end

  def strike?
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
