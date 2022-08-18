require_relative 'frame'

class Game
  def initialize(scores)
    @frames = []
    @scores = scores
  end

  def calc_scores
    frames.each_with_index.sum do |frame, index|
      if frame.strike? && index <= 8
        if @frames[index + 1].strike? && index < 8
          frame.sum_shots + @frames[index + 1].first_shot.score + @frames[index + 2].first_shot.score
        else
          frame.sum_shots + @frames[index + 1].first_shot.score + @frames[index + 1].second_shot.score
        end
      elsif frame.spare? && index < 9
        frame.sum_shots + @frames[index + 1].first_shot.score
      else
        frame.sum_shots
      end
    end
  end

  private
  def split_scores
    split_scores = []
    @scores.split(',').each do |score|
      split_scores << score
      split_scores << '0' if split_scores.size < 18 && score == 'X'
    end
    split_scores
  end

  def frames
    split_scores.each_slice(2) { |score| @frames.size == 10 ? @frames[9] << score[-1] : @frames << score }
    @frames = @frames.map { |frame| Frame.new(frame[0], frame[1], frame[2]) }
  end
end
