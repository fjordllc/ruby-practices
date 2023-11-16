class Frame
  attr_reader :first_shot, :second_shot, :third_shot

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
    sum_shots_score == 10 && !strike?
  end
end
