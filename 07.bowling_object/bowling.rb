# frozen_string_literal: true

require_relative 'game'

result = Game.new(ARGV[0])

p result.total_score
