#!/usr/bin/env ruby
# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize
    @shots = []
  end

  def add_shot(pins)
    @shots << pins
  end

  def strike?
    @shots.first == 10
  end

  def spare?
    @shots.sum == 10 && !strike?
  end

  def score
    @shots.sum
  end
end
