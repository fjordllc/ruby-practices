# frozen_string_literal: true

class Shot
  attr_reader :count

  def initialize(count)
    @count = count
  end

  def score
    @count == 'X' ? 10 : @count.to_i
  end
end
