# frozen_string_literal: true

class Game
  attr_reader :first_frame, :second_frame, :third_frame, :fourth_frame, :fifth_frame, :sixth_frame, :seventh_frame, :eighth_frame, :ninth_frame, :tenth_frame
  def initialize(game_score)
    @game_score = game_score
    frames = GameSetting.new(@game_score)
    frame = frames.frames_array_convert
    @first_frame = Frame.new(frame[0])
    @second_frame = Frame.new(frame[1])
    @third_frame = Frame.new(frame[2])
    @fourth_frame = Frame.new(frame[3])
    @fifth_frame = Frame.new(frame[4])
    @sixth_frame = Frame.new(frame[5])
    @seventh_frame = Frame.new(frame[6])
    @eighth_frame = Frame.new(frame[7])
    @ninth_frame = Frame.new(frame[8])
    @tenth_frame = Frame.new(frame[9])
  end

  def score
    score_addition = [
      first_frame.score,
      second_frame.score,
      third_frame.score,
      fourth_frame.score,
      fifth_frame.score,
      sixth_frame.score,
      seventh_frame.score,
      eighth_frame.score,
      ninth_frame.score,
      tenth_frame.score
    ]
    # p score_addition
    score_result = GameScoreAddCal.new(score_addition)
    score_result.score_addition
  end
end

class GameScoreAddCal
  def initialize(game_score_addition)
    @game_score_addition = game_score_addition
  end

  def score_addition
    game_score_added = 0
    @game_score_addition.each_with_index do |f, idx|
      if f.size == 3 # 10フレーム目
        game_score_added += f.sum
      elsif f[0] == 10 # strike
        idx += 1
        next_frame = @game_score_addition[idx]
        idx += 1
        next_next_frame = @game_score_addition[idx]
        game_score_added += if next_frame[0] == 10 && !next_next_frame.nil?
                              10 + next_frame[0] + next_frame[1] + next_next_frame[0]
                            else
                              10 + next_frame[0] + next_frame[1]
                            end
      elsif f.sum == 10 # spare
        idx += 1
        next_frame = @game_score_addition[idx]
        game_score_added += 10 + next_frame[0]
      else
        game_score_added += f.sum
      end
    end
    game_score_added
  end
end

class GameSetting
  def initialize(game_score)
    @game_score = game_score
  end
  def frames_array_convert
    frames = StrikeConvert.new(@game_score).convert
    frames_slice = FramesSlice.new(frames).slice
    if frames_slice.size == 10
      frames_slice
    elsif frames_slice.size == 11
      frames_pop_convert = FramesPop.new(frames_slice)
      frames_pop_convert.frames_pop_eleven_frame if frames_slice.size == 11
    elsif frames_slice.size == 12
      frames_pop_convert = FramesPop.new(frames_slice)
      frames_pop_convert.frames_pop_twelve_frame
    end
  end
end

class StrikeConvert
  def initialize(frames_array)
    @frames_array = frames_array
  end
  def convert
    frames_array_converted = []
    shot_count = 0
    @frames_array.chars.each do |shot|
      shot_count += 1
      if shot == 'X' && shot_count == 1
        frames_array_converted << shot
        frames_array_converted << '0'
        shot_count += 1
      else
        frames_array_converted << shot
      end
      shot_count = 0 if shot_count == 2
    end
    frames_array_converted
  end
end

class FramesSlice
  def initialize(frames_array)
    @frames_array = frames_array
  end
  def slice
    frames = []
    @frames_array.each_slice(2) do |frame|
      frames << frame
    end
    frames
  end
end

class FramesPop
  def initialize(frames)
    @frames = frames
  end
  def frames_pop_eleven_frame
    last_flame = @frames.pop(2)
    @frames << last_flame[0] + last_flame[1]
    @frames
  end
  def frames_pop_twelve_frame
    last_flame = @frames.pop(3)
    @frames << last_flame[0] + last_flame[1] + last_flame[2]
    @frames.last.delete_if { |l| l == '0' }
    @frames
  end
end

class Frame
  attr_reader :first_shot, :second_shot, :third_shot
  def initialize(shots)
    @first_shot = Shot.new(shots[0])
    @second_shot = Shot.new(shots[1])
    @third_shot = Shot.new(shots[2])
  end
  def score
    third_shot.score.zero? ? [first_shot.score, second_shot.score] : [first_shot.score, second_shot.score, third_shot.score]
  end
end

class Shot
  attr_reader :mark
  def initialize(mark)
    @mark = mark
  end

  def score
    return 10 if mark == 'X'

    mark.to_i
  end
end

game = Game.new(ARGV[0])
puts game.score
