# frozen_string_literal: true

module Bowling
  module Score
    class << self
      def strike_point = Strike.point

      def of(sym, rolls)
        bonus?(sym, rolls) && score_with_bonus_for(sym, rolls)
      end

      def bonus?(sym, rolls)
        bonus_type(sym).satisfied_by?(rolls)
      end

      private

      def score_with_bonus_for(sym, rolls)
        bonus_type(sym).score_for(rolls)
      end

      def bonus_type(sym)
        const_get(sym.to_s.capitalize)
      end
    end

    module Strike
      class << self
        def point = 10

        def satisfied_by?(rolls)
          rolls.roll(1) == Strike.point && rolls.roll(2).nil?
        end

        def score_for(rolls)
          point + rolls.bonus_point(roll_count: 2)
        end
      end
    end

    module Spare
      class << self
        def point = 10

        def satisfied_by?(rolls)
          !strike?(rolls) && rolls.sum == 10
        end

        def score_for(rolls)
          point + rolls.bonus_point(roll_count: 1)
        end

        private

        def strike?(rolls) = Score.bonus?(:strike, rolls)
      end
    end
  end
end
