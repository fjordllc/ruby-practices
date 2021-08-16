class Shot
  def initialize(argv)
    @score = argv
  end

  def convert_num
    scores = @score.split(',')
    shots = scores.map do |s|
      if s == 'X'
        10
      else
        s.to_i
      end
    end
  end
end
