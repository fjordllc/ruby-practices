# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(one, two = nil, three = nil)
    @shots = []
    @shots[0] = Shot.new(one)
    @shots[1] = two.nil? ? nil : Shot.new(two)
    @shots[2] = three.nil? ? nil : Shot.new(three)
  end

  def one
    @shots[0].score
  end

  def two
    @shots[1]&.score
  end

  def three
    @shots[2]&.score
  end

  def strike?
    @shots[0].count == 'X'
  end

  def spare?
    return one + two == 10 unless two.nil?

    false
  end

  def total
    @shots.compact.map(&:score).sum
  end

  def score(next_frame, after_next)
    if strike? && next_frame
      strike_score(next_frame, after_next)
    elsif spare? && next_frame
      total + next_frame.one
    else
      total
    end
  end

  private

  def strike_score(next_frame, after_next)
    if !next_frame.two.nil?
      total + next_frame.one + next_frame.two
    else
      total + next_frame.one + after_next.one
    end
  end
end
