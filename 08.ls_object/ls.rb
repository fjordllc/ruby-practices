# frozen_string_literal: true

require_relative 'parameter'
require_relative 'file_collecter'
require_relative 'file_analyser'
require_relative 'rendering'

params = Parameter.new.params
files = FileCollecter.new(params).collect
Rendering.new(params, files).output
