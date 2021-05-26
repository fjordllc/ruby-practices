#!/usr/bin/env ruby

class Bowling
  attr_accessor :scores, :shots, :frames

  def initialize(scores)
    @scores = scores[0].split(',')
    # scores = ARGV[0].split(',')
    # p "scores: #{scores}"
    @shots = []
    @frames = []
  end

  def run
    build_shots
    build_frames

    calcurate_point
  end

  private

  def build_shots
    @scores.each do |score|
      if score == 'X'
        @shots << 10
        @shots << 0
      else
        @shots << score.to_i
      end
    end
  end

  def build_frames
    @shots.each_slice(2) {|s| @frames << s }

    @frames = @frames.map {|frame| frame[0] == 10 ? frame.slice(0, 1) : frame }

    @frames = @frames.filter_map.with_index do |frame, idx|
      valid_frame = idx <= 9
      last_frame = idx == 9

      if valid_frame
        if last_frame
          @frames.slice(idx..).reduce {|result, frame| result + frame }
        else
          frame
        end
      end
    end
  end

  def calcurate_point
    point = 0

    @frames.each_with_index do |frame, idx|
      frame_number = idx + 1
      next_frame = @frames[idx + 1]
      next_next_frame = @frames[idx + 2]

      if frame_number == 10

        point += frame.sum

      elsif frame_number == 9

        if strike?(frame)
          point += frame.sum + next_frame[0..1].sum
        elsif spare?(frame)
          point += frame.sum + next_frame[0]
        else
          point += frame.sum
        end

      elsif frame_number == 8

        if strike?(frame)
          if strike?(next_frame)
            point += frame.sum + next_frame.sum + next_next_frame[0]
          elsif spare?(next_frame)
            point += frame.sum + next_frame.sum
          else
            point += frame.sum
          end
        elsif spare?(frame)
          point += frame.sum + next_frame[0]
        else
          point += frame.sum
        end

      else

        if strike?(frame)
          if strike?(next_frame) && next_next_frame
            point += frame.sum + next_frame.sum + next_next_frame.sum
          else
            point += frame.sum + next_frame.sum
          end
        elsif spare?(frame)
          point += frame.sum + next_frame[0]
        else
          point += frame.sum
        end

      end

    end
    # p point
    point
  end

  def strike?(frame)
    frame[0] == 10
  end

  def spare?(frame)
    frame.sum == 10
  end
end
