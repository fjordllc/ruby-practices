# frozen_string_literal: true

class Shot
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def strike_mark?
    mark == 'X'
  end

  def score
    strike_mark? ? 10 : mark.to_i
  end
end
