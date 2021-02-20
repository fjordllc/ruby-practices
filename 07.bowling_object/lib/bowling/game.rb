# frozen_string_literal: true

module Bowling
  class Game
    class << self
      def frame_size = 10

      def final_frame?(index) = (index == final_frame_idx)

      private

      def final_frame_idx = 9
    end

    def initialize(marks)
      @frames = Parse.call(marks)
    end

    def score
      frames.sum(&:score)
    end

    private

    attr_reader :frames
  end
end
