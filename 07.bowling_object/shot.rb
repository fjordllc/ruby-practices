require 'minitest/autorun'

class Shot
  def initialize(argv)
    @score = argv
    @scores = @score.split(',')
  end

  def convert_num
    @shots = @scores.map do |s|
      if s == 'X'
        10
      else
        s.to_i
      end
    end
  end
end
