#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './src/bowling'

bowling = Bowling.new(ARGV)
p bowling.run
