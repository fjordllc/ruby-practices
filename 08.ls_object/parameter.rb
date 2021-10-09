# frozen_string_literal: true

require 'optparse'

class Parameter
  attr_reader :params

  def initialize
    @params = ARGV.getopts('alr')
  end
end
