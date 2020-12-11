# frozen_string_literal: true

class Game
  def initialize(marks)
    @marks = marks
    shot_count = 0
    shots = []
    @marks.chars.each do |mark|
      shot_count += 1
      if mark == 'X' && shot_count == 1
        shots << mark
        shots << "0"
        shot_count += 1
      elsif mark == 'X'
        shots << mark
      else
        shots << mark
      end
      shot_count = 0 if shot_count == 2
    end
    @frames = shots.each_slice(2).to_a
    if @frames.size == 11
      last_flame = @frames.pop(2)
      @frames << last_flame[0] + last_flame[1]
    end
    if @frames.size == 12
      last_flame = @frames.pop(3)
      @frames << last_flame[0] + last_flame[1] + last_flame[2]
      @frames.last.delete_if{ |l| l == "0" }
    end
    @frame_array = [
      first_frame = Frame.new(@frames[0]),
      second_frame = Frame.new(@frames[1]),
      third_frame = Frame.new(@frames[2]),
      forth_frame = Frame.new(@frames[3]),
      fifth_frame = Frame.new(@frames[4]),
      sixth_frame = Frame.new(@frames[5]),
      seventh_frame = Frame.new(@frames[6]),
      eighth_frame = Frame.new(@frames[7]),
      nineth_frame = Frame.new(@frames[8]),
      tenth_frame = Frame.new(@frames[9])
    ]
  end

  def score
    score = 0
    @frame_array.each_with_index do |f, idx|
      if f.tenth_frame?
         score += f.score
      elsif f.strike?
        idx += 1
        next_frame = @frame_array[idx]
        idx += 1
        next_next_frame = @frame_array[idx]
         score += if next_frame.strike? && !next_next_frame.nil?
                   10 + next_frame.score + next_next_frame.first_shot_score
                 else
                   10 + next_frame.first_shot_score + next_frame.second_shot_score
                 end
      elsif f.spare?
        idx += 1
        next_frame = @frame_array[idx]
         score += 10 + next_frame.first_shot_score
      else
        score += f.score
      end
    end
    score
  end
end

class Frame
  def initialize(frame)
    @first_mark = Shot.new(frame[0])
    @second_mark = Shot.new(frame[1])
    @third_mark = Shot.new(frame[2])
  end

  def score
    [@first_mark.score, @second_mark.score, @third_mark.score].sum
  end

  def strike?
    if @first_mark.score == 10
      true
    else
      false
    end
  end

  def tenth_frame?
    if @third_mark.to_s.nil?
      false
    else
      true
    end
  end

  def spare?
    return true if [@first_mark.score, @second_mark.score].sum == 10
  end

  def first_shot_score
    @first_mark.score
  end

  def second_shot_score
    @second_mark.score
  end
end

class Shot
  def initialize(mark)
    @mark = mark
  end

  def score
    if @mark == "X"
      10
    else
      @mark.to_i
    end
  end

  def to_s
    @mark
  end
    
end

game = Game.new(ARGV[0])
puts game.score
