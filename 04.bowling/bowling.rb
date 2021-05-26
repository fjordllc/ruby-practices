#!/usr/bin/env ruby

class Bowling
  class << self
    def strike?(frame)
      frame[0] == 10
    end

    def spare?(frame)
      frame.sum == 10
    end

    def run(scores)
      scores = scores[0].split(',')
      # scores = ARGV[0].split(',')
      # p "scores: #{scores}"

      shots = []
      scores.each do |score|
        if score == 'X'
          shots << 10
          shots << 0
        else
          shots << score.to_i
        end
      end
      # p "shots: #{shots}"

      frames = []
      shots.each_slice(2) {|s| frames << s }

      frames = frames.map {|frame| frame[0] == 10 ? frame.slice(0, 1) : frame }

      frames = frames.filter_map.with_index do |frame, idx|
        valid_frame = idx <= 9
        last_frame = idx == 9

        if valid_frame
          if last_frame
            frames.slice(idx..).reduce {|result, frame| result + frame }
          else
            frame
          end
        end
      end

      # p "frames: #{frames}"
      # p "frames.count: #{frames.count}"

      point = 0
      frames.each.with_index(1) do |frame, frame_number|
        # strike = frame[0] == 10
        # spare = frame.sum == 10

        next_frame = frames[frame_number]
        next_next_frame = frames[frame_number + 1]


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
            # 2投を取得する
            # next_frameの1st shotが10 => strikie
              # next_next_frameの1st shotも加える
            # next_frameの1st shotが10以外
              # next_frame.sumでOK

            if next_frame
              if strike?(next_frame) && next_next_frame
                point += frame.sum + next_frame.sum + next_next_frame.sum
              else
                point += frame.sum + next_frame.sum
              end
            else
              point += frame.sum
            end
          elsif spare?(frame)
            if next_frame
              point += frame.sum + next_frame[0]
            else
              point += frame.sum
            end
          else
            point += frame.sum
          end
        end

        # p "#{frame_number}:#{point}"
      end

      p point
    end
  end
end