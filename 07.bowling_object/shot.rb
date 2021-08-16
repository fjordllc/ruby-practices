class Shot
  def initialize(marks)
    @marks = marks
  end

  def parse_marks
    @marks.split(',').map do |s|
      if s == 'X'
        10
      else
        s.to_i
      end
    end
  end
end
