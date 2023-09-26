#!/usr/bin/env ruby

# frozen_string_literal: true

require './file_system'
require 'debug'

file_system = FileSystem.new(ARGV)
file_system.display
