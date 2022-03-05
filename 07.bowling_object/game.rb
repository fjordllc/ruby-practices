require_relative 'translate_score'
require_relative 'frame'

class Game
  def initialize(frames)
    @frames = frames
  end

  def total_score
    total_points = 0
    @frames.each.with_index(1) do |frame, index|
      total_points += frame.sum

      break if index == @frames.size

      if frame[0] == 10
        total_points += @frames[index][0]
        total_points +=
          # 最初の投球の次の投球もストライクの場合
          if @frames[index][0] == 10
            index == @frames.size - 1 ? @frames[index][2] : @frames[index + 1][0]
          else
            @frames[index][1]
          end
      # スペアの場合
      elsif frame.sum == 10
        total_points += @frames[index][0]
      end
    end
    total_points
  end
end

translated_score = TranslateScore.new(ARGV[0].split(',')).translate_from_input_to_score
frames = Frame.new(translated_score).create_frames
game = Game.new(frames)
p game.total_score