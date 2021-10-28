# frozen_string_literal: true

class Bowling
  def calculate(scores)
    scores = scores.split(',')
    frames = divide_by_frame(convert(scores))
    points = 0
    frames.each_with_index do |score, index|
      if index == 9
        points += calculate_for_last_turn(frames, score, index)
      elsif index < 9
        points += calculate_for_normal_turns(frames, score, index)
      end
    end
    p points
  end

  def convert(scores)
    convert_scores = []
    scores.each do |score|
      if score == 'X'
        convert_scores << 10
        convert_scores << 0
      else
        convert_scores << score.to_i
      end
    end
    convert_scores
  end

  def divide_by_frame(array_of_scores)
    scores_by_frame = []
    array_of_scores.each_slice(2) do |score|
      scores_by_frame << score
    end
    scores_by_frame
  end

  def calculate_for_normal_turns(frames, score, index)
    points = 0
    points += score.sum
    if score[0] == 10
      if frames[index + 1][0] == 10
        points += frames[index + 1][0]
        points += frames[index + 2][0]
      elsif frames[index + 1][0] < 10
        points += frames[index + 1].sum
      end
    elsif score[0] < 10 && score.sum == 10
      points += frames[index + 1][0]
    end
    points
  end

  def calculate_for_last_turn(frames, score, index)
    points = 0
    points += score.sum
    return points unless score.sum == 10

    points += frames[index + 1] ? frames[index + 1][0] : 0
    points += frames[index + 2] ? frames[index + 2][0] : 0
    points
  end
end

bowling = Bowling.new
bowling.calculate(ARGV[0])
