# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize(shots)
    @shots = shots
    @frames = []
    @frame = []
  end

  def score
    shots.each do |shot|
      @frame << shot

      if @frames.size < 10
        if @frame.size >= 2 || shot == 10
          @frames << @frame.dup
          @frame.clear
        end
      else
        @frames.last << shot
      end
    end

    @frames
  end
end
