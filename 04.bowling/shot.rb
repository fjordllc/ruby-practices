class Shot
  def initialize(mark)
    @mark = mark
  end

  def score
    return 10 if @mark == 'X'
    return 0 if @mark == 'G'

    @mark.to_i
  end
end
