# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'
require_relative 'game'

throwings = ARGV[0].split(',')
shots = throwings.map { |throwing| Shot.new(throwing) }
divided_shots = Frame.divide(shots)
frames = divided_shots.map { |divided_shot| Frame.new(*divided_shot) }
puts Game.new(frames).score
