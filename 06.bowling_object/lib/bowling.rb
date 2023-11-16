require_relative 'game'
require_relative 'frame'
require_relative 'shot'

def group_by_frame(marks)
  frames = Array.new(10) { [] }
  frames.each.with_index do |frame, i|
    if i == 9
      frame.concat(marks)
    elsif marks[0] == 'X'
      frame.push(marks[0])
      marks.delete_at(0)
    else
      2.times do
        frame.push(marks[0])
        marks.delete_at(0)
      end
    end
  end
  frames
end

marks = ARGV[0].split(',')
frames = group_by_frame(marks)
puts Game.new(frames).total_score
