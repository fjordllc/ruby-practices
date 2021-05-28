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

    @frames = @frames
                .take_while
                .with_index {|_, idx| idx <= 9 }
                .filter_map
                .with_index do |frame, idx|
                  last_frame = idx == 9

                  if last_frame
                    @frames.slice(idx..).reduce {|result, frame| result + frame }
                  else
                    frame
                  end
                end
    # p "@frames: #{@frames}"
    # @frames
  end

  def calcurate_point
    point = 0

    @frames.each_with_index do |frame, idx|
      point += cal_point(frame, idx)
    end

    # p "point: #{point}"
    point
  end

  def cal_point(frame, idx)
    return frame.sum if idx == 9 # 10 frame

    next_frame = next_frame(idx)

    if strike?(frame)
      if idx.between?(0, 7)
        # 1 frame - 8 frame
        if strike?(next_frame)
          frame.sum + next_frame.sum + next_next_frame(idx)[0]
        else
          frame.sum + next_frame.sum
        end
      else
        # 9 frame
        frame.sum + next_frame[0..1].sum
      end
    elsif spare?(frame)
      frame.sum + next_frame[0]
    else
      frame.sum
    end

    # next_frame = next_frame(idx)

    # case idx
    # when 0..7 # 1 frame - 8 frame
    #   if strike?(frame)
    #     if strike?(next_frame)
    #       frame.sum + next_frame.sum + next_next_frame(idx)[0]
    #     else
    #       frame.sum + next_frame.sum
    #     end
    #   elsif spare?(frame)
    #     frame.sum + next_frame[0]
    #   else
    #     frame.sum
    #   end
    # when 8 # 9 frame
    #   if strike?(frame)
    #     frame.sum + next_frame[0..1].sum
    #   elsif spare?(frame)
    #     frame.sum + next_frame[0]
    #   else
    #     frame.sum
    #   end
    # when 9 # 10 frame
    #   frame.sum
    # end
  end

  def next_frame(idx)
    @frames[idx + 1]
  end

  def next_next_frame(idx)
    @frames[idx + 2]
  end

  def strike?(frame)
    frame[0] == 10
  end

  def spare?(frame)
    frame[0..1].sum == 10
  end
end
