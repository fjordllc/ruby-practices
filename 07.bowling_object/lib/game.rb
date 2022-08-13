require_relative 'frame'

class Game
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def split_score
    @scores.split(',')
  end

  def frames
    scores = []
    frames = []

    split_score.each do |score|
      scores << score
      scores << '0' if scores.size < 18 && score == 'X'
    end

    scores.each_slice(2) { |score| frames.size == 10 ? frames[9] << score[-1] : frames << score }
    frames = frames.map { |frame| Frame.new(frame[0], frame[1], frame[2]) }
    Game.new(frames)
  end
end
