# frozen_string_literal: true

class Game
  def initialize(marks)
    @frames = formatted_marks(marks).map.with_index(1) do |formatted_marks, number|
      Frame.new(number, formatted_marks)
    end
  end

  def result
    scores = 0
    @frames.each do |frame|
      scores += frame.score(next_frame(frame), after_next_frame(frame))
    end
    scores
  end

  private

  def formatted_marks(marks)
    marks = marks.split(',')
    marks.each_with_index do |mark, i|
      marks.insert(i + 1, nil) if mark == 'X'
    end

    formatted_marks = marks.each_slice(2).map { |marks_per_frame| marks_per_frame }

    # 10フレーム目を整形
    if formatted_marks[10]
      while formatted_marks[10]
        formatted_marks[9] << formatted_marks[10]
        formatted_marks.delete_at(10)
      end

      formatted_marks[9].flatten!.compact!
    end
    formatted_marks
  end

  def frame(num)
    frames[num - 1]
  end

  def next_frame(frame)
    @frames[frame.number.to_i]
  end

  def after_next_frame(frame)
    @frames[frame.number.to_i + 1]
  end
end
