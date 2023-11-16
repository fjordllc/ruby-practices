# frozen_string_literal: true

class Game
  def initialize(marks)
    grouped_marks = Game.group_by_frame(marks.split(','))
    @frame1 = Frame.new(grouped_marks[0])
    @frame2 = Frame.new(grouped_marks[1])
    @frame3 = Frame.new(grouped_marks[2])
    @frame4 = Frame.new(grouped_marks[3])
    @frame5 = Frame.new(grouped_marks[4])
    @frame6 = Frame.new(grouped_marks[5])
    @frame7 = Frame.new(grouped_marks[6])
    @frame8 = Frame.new(grouped_marks[7])
    @frame9 = Frame.new(grouped_marks[8])
    @frame10 = Frame.new(grouped_marks[9])
  end

  def self.group_by_frame(marks)
    frames = Array.new(10) { [] }
    frames.each.with_index do |frame, i|
      if i == 9
        frame.concat(marks)
      elsif marks[0] == 'X'
        frame.push(marks.shift)
      else
        2.times { frame.push(marks.shift) }
      end
    end
    frames
  end

  def total_score
    sum_frames_score + sum_bonus_score
  end

  def sum_frames_score
    frames = [@frame1, @frame2, @frame3, @frame4, @frame5, @frame6, @frame7, @frame8, @frame9, @frame10]
    frames.map!(&:sum_shots_score).sum
  end

  def sum_bonus_score
    frames = [@frame1, @frame2, @frame3, @frame4, @frame5, @frame6, @frame7, @frame8, @frame9, @frame10]
    frames.map!.with_index do |frame, i|
      break if i == 9

      if frame.strike?
        calculate_strike_bonus(frames, i)
      elsif frame.spare?
        frames[i + 1].first_shot.score
      else
        0
      end
    end
    frames.pop
    frames.sum
  end

  def calculate_strike_bonus(frames, index)
    if index == 8 || !frames[index + 1].strike?
      frames[index + 1].first_shot.score + frames[index + 1].second_shot.score
    else
      10 + frames[index + 2].first_shot.score
    end
  end
end
