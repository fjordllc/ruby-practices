# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(one, two = nil, three = nil)
    @one = Shot.new one
    @two = two.nil? ? nil : Shot.new(two)
    @three = three.nil? ? nil : Shot.new(three)
  end

  def one
    @one.score
  end

  def two
    @two.nil? ? nil : @two.score
  end

  def three
    @three.nil? ? nil : @three.score
  end

  def print
    "#{one} #{two} #{three}"
  end

  def strike?
    @one.count == 'X'
  end

  def spare?
    return one + two == 10 unless two.nil?

    false
  end

  def total
    if two.nil?
      one
    elsif three.nil?
      one + two
    else
      one + two + three
    end
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
