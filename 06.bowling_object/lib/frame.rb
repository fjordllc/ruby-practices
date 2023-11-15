class Frame
  attr_reader :first_shot, :second_shot, :third_shot

#  def initialize(first_mark, second_mark = nil, third_mark = nil)
#    @first_shot = Shot.new(first_mark)
#    @second_shot = Shot.new(second_mark)
#    @third_shot = Shot.new(third_mark)
#  end

  def initialize(shots)
    @first_shot = Shot.new(shots[0])
    @second_shot = Shot.new(shots[1])
    @third_shot = Shot.new(shots[2])
  end

  def sum_shots_score
    first_shot.score + second_shot.score + third_shot.score
  end

  def strike?
    first_shot.mark == 'X'
  end

  def spare?
    sum_shots_score == 10 && first_shot.mark != 'X'
  end
end
