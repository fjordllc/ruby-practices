require_relative './shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    return 10 if first_shot.score == 'X'
    [first_shot.score + second_shot.score + @third_shot.score].sum
  end
end
