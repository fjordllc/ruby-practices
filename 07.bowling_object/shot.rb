#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'game'

class Shot
  attr_accessor :score_number

  def initialize(score_number)
    @score_number = score_number
  end

end


