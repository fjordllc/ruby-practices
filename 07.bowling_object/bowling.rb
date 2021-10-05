# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'
require_relative 'game'

throwings = ARGV[0].split(',')

shots = throwings.map do |throwing|
  Shot.new(throwing).numerate
end

frames = Frame.new(shots).score
puts Game.new(frames).score
