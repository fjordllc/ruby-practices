# frozen_string_literal: true

require 'date'
require_relative 'make_request'
require_relative 'ganarate_cal_elements'
require_relative 'display'

class Rubycal
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize
    @keys = { y: THIS_Y, m: THIS_M }
    @layout = {
      mergin: "\s",
      blank_cell: "\s\s",
      blank_for_1char: "\s",
      blank_for_2char: '',
      column: nil
    }
  end

  def run
    make_request
    display_rubycal(generate_cal_elements)
  end

  def make_request
    make_request = MakeRequest.new
    @keys = make_request.optparse
  end

  def generate_cal_elements
    generate_cal_elements = GanarateCalElements.new(@keys, @layout)
    generate_cal_elements.generate
  end

  def display_rubycal(cal_elements)
    display = Display.new(cal_elements, @layout)
    display.run
  end
end

def run
  rubycal = Rubycal.new
  rubycal.run
end

run
