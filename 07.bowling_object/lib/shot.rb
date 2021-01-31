# frozen_string_literal: true

class Shot
  attr_reader :roll

  def initialize(roll)
    @roll = roll
  end

  def roll_to_integer
    @roll == 'X' ? 10 : @roll.to_i
  end
end
