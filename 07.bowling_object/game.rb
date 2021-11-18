require_relative './frame'

class Game
  def initialize(pin)
    @game = pin
  end

  def frame_ary
    frame = []
    frames = []
    score_ary = @game.split(",")
    score_ary.each do |sa|
      frame.push(sa)
      if frames.length == 10
        frames.last.push(sa)
      elsif frame.size >= 2 || sa == 'X'
        frames.push(frame.dup)
        frame.clear
      end
    end
    frames
  end

  def frame_instance_ary
    frames = []
    frame_ary.each do |frame|
      frames.push(Frame.new(*frame))
    end
    frames
  end

  def score
    score = []
    frame_instance_ary.each_with_index do |frame, i|
      if frame.first_shot.score == 10 && !last_frame?(i)
        score.push(frame.score + add_strike_points(i))
      elsif frame.score == 10 && !last_frame?(i)
        score.push(frame.score + add_spare_points(i))
      else
        score.push(frame.score)
      end
    end
    score
  end

  def total_score
    score.sum
  end

  private

  def add_strike_points(index)
    # 次のフレームもストライクだった場合、次々のものを見る
    # ストライクだった場合、フレーム両方に加点する
    next_frame = frame_instance_ary[index + 1]
    next_next_frame = frame_instance_ary[index + 2]
    if ninth_frame?(index)
      next_frame.first_shot.score + next_frame.second_shot.score
    elsif next_frame.first_shot.score == 10
      next_frame.score + next_next_frame.first_shot.score
    else
      next_frame.score
    end
  end

  def add_spare_points(index)
    next_frame = frame_instance_ary[index + 1]
    next_frame.first_shot.score
  end

  def last_frame?(frame_index)
    last_frame_index = 9
    last_frame_index == frame_index
  end

  def ninth_frame?(frame_index)
    ninth_frame = 8
    ninth_frame == frame_index
  end
end
