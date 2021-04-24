#!/usr/bin/env ruby

class Bowling
  def self.calculate_score(score)
    self.new.calculate_score(score)
  end

  def calculate_score(score)
    shots = convert_to_value(score)
    frames = convert_to_frames(shots)
    indexes = find_indexes_of_strike_and_spare(frames)
    added_frames = add_points_for_strike_and_spare(indexes, frames)
    
    added_frames.map(&:sum).sum
  end

  private
  
  def convert_to_value(score)
    scores = score.split(',')
    shots = []
    scores.each do |shot|
      if shot == 'X' && shots.size < 18
        shots << 10 << 0
      elsif shot == 'X'
        shots << 10
      else
        shots << shot.to_i
      end
    end
    shots
  end

  def convert_to_frames(shots)
    frames = []
    shots.each_slice(2) do |shot|
      if frames.size <= 9
        frames << shot
      elsif frames.size == 10
        # 三投目があれば最後の配列は3つにする
        frames[9] += shot
      end
    end
    frames
  end

  def find_indexes_of_strike_and_spare(frames)
    indexes = {spare_indexes: [], strike_indexes: []}
    frames.each_with_index do |frame, index|
      if frame == [10, 0]
        indexes[:strike_indexes] << index
      elsif frame.sum == 10 && frame.size == 2 # 最終フレームは判定しない
        indexes[:spare_indexes] << index
      end
    end
    indexes
  end

  def add_points_for_strike_and_spare(indexes, frames)
    indexes[:spare_indexes].each do |spare_index|
      frames[spare_index] << frames[spare_index + 1][0]
    end

    indexes[:strike_indexes].each do |strike_index|
      case
      when frames[strike_index..(strike_index + 2)] == [[10, 0]] * 3
        frames[strike_index] << 20
      when frames[strike_index..(strike_index + 1)] == [[10, 0]] * 2
        frames[strike_index] << 10 + frames[strike_index + 2][0]
      else
        frames[strike_index] << frames[strike_index + 1][0..1].sum
      end
    end
    frames
  end
end

if $0 == __FILE__
  puts Bowling.calculate_score(ARGV[0])
end
