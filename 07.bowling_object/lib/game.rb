require_relative 'frame'

class Game
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

end
