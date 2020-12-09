# frozen_string_literal: true

class Game
  def initialize(frame)
    @frame = frame
  end
  def score
    score = 0
    @frame.each_with_index do |f, idx|
      if f.size == 3 # 10フレーム目
        score += f.sum
      elsif f[0] == 10 # strike
        idx += 1
        next_frame = @frame[idx]
        idx += 1
        next_next_frame = @frame[idx]
        score += if next_frame[0] == 10 && !next_next_frame.nil?
                              10 + next_frame[0] + next_frame[1] + next_next_frame[0]
                            else
                              10 + next_frame[0] + next_frame[1]
                            end
      elsif f.sum == 10 # spare
        idx += 1
        next_frame = @frame[idx]
        score += 10 + next_frame[0]
      else
        score += f.sum
      end
    end
    score
  end
end

class Frame
  def initialize(shot)
    @shot = shot
  end
  def convert
    frame = []
    @shot.each_slice(2) do |s|
      frame << s
    end
    if frame.size == 11
      last_flame = frame.pop(2)
      frame << last_flame[0] + last_flame[1]
    end
    if frame.size == 12
      last_flame = frame.pop(3)
      frame << last_flame[0] + last_flame[1] + last_flame[2]
      frame.last.delete_if { |l| l == 0 }
    end
    frame
  end
end

class Shot
  def initialize(mark)
    @mark = mark
  end
  def convert
    shots = []
    shot_count = 0
    @mark.chars.each do |shot|
      shot_count += 1
      if shot == 'X' && shot_count == 1
        shots << 10
        shots << 0
        shot_count += 1
      elsif shot == 'X'
        shots << 10
      else
        shots << shot.to_i
      end
      shot_count = 0 if shot_count == 2
    end
    shots
  end
end

shot = Shot.new(ARGV[0]).convert
frame = Frame.new(shot).convert
game_score = Game.new(frame).score
puts game_score
