# frozen_string_literal: true

require './optparse_run'
require 'date'

class MakeRequest
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize
    @generate_request_result = {}
    @default_request_status = {
      basic_month: THIS_M,
      basic_year: THIS_Y,
      basic_day: THIS_D,
      pre_month: nil,
      next_month: nil,
      julius: false,
      highligth: true,
      year_position: 'default'
    }
  end

  def make_request
    parse_arge = OptparseRun.new(@default_request_status)
    parse_arge.optparse_run
  end
end
