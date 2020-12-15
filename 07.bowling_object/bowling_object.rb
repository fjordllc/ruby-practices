# frozen_string_literal: true

class Game
  def initialize(marks)
    @frames = Frame.shots_to_frames(marks)
  end

  def score
    score = 0
    @frames.each_with_index do |f, idx|
      if f.tenth_frame?
        score += f.shots_score
      elsif f.strike?
        next_frame = @frames[idx + 1]
        next_next_frame = @frames[idx + 2]
        score += if next_frame.strike? && !next_next_frame.nil?
                   10 + next_frame.shots_score + next_next_frame.first_shot_score
                 else
                   10 + next_frame.first_shot_score + next_frame.second_shot_score
                 end
      elsif f.spare?
        next_frame = @frames[idx + 1]
        score += 10 + next_frame.first_shot_score
      else
        score += f.shots_score
      end
    end
    score
  end
end

class Frame
  def initialize(shots)
    @shots = shots
  end

  def shots_score
    @shots.size == 3 ? [@shots[0].score, @shots[1].score, @shots[2].score].sum : [@shots[0].score, @shots[1].score].sum
  end

  def strike?
    @shots[0].score == 10
  end

  def tenth_frame?
    @shots[2].nil? ? false : true
  end

  def spare?
    @shots[0].score != 10 && [@shots[0].score, @shots[1].score].sum == 10
  end

  def first_shot_score
    @shots[0].score
  end

  def second_shot_score
    @shots[1].score
  end

  def self.shots_to_frames(marks)
    shots = Shot.marks_to_shots(marks)
    frame_array = shots.each_slice(2).to_a
    if frame_array.size == 11
      last_flame = frame_array.pop(2)
      frame_array << last_flame[0] + last_flame[1]
    end
    if frame_array.size == 12
      last_flame = frame_array.pop(3)
      frame_array << last_flame[0] + last_flame[1] + last_flame[2]
      frame_array.last.delete_if { |l| l.to_s == '0' }
    end
    (0..9).map do |num|
      Frame.new(frame_array[num])
    end
  end
end

class Shot
  def initialize(mark)
    @mark = mark
  end

  def score
    @mark == 'X' ? 10 : @mark.to_i
  end

  def to_s
    @mark
  end

  def self.marks_to_shots(marks)
    shot_count = 0
    shots = []
    marks.chars.each do |mark|
      shot_count += 1
      if mark == 'X' && shot_count == 1
        shots << Shot.new(mark)
        shots << Shot.new('0')
        shot_count += 1
      elsif mark == 'X'
        shots << Shot.new(mark)
      else
        shots << Shot.new(mark)
      end
      shot_count = 0 if shot_count == 2
    end
    shots
  end
end

game = Game.new(ARGV[0])
puts game.score
