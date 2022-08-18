# frozen_string_literal: true

class Shot
  attr_accessor :mark

  def initialize(mark)
    @mark = mark
  end

  # 活用できていない
  # def score
  #   @mark == 'X' ? 10 : @mark.to_i
  # end
end
