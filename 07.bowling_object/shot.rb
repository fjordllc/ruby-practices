# frozen_string_literal: true

class Shot
  def initialize(marks)
    @marks = marks
  end

  def parse_marks
    @marks.split(',').map { |s| s == 'X' ? 10 : s.to_i }
  end
end
