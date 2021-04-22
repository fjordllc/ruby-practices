# frozen_string_literal: true

require './make_request'
require './monthly_calender'
require './merge_cal'

class RubyCalFactory
  def run
    make_result
  end

  private
  
  def make_result
    request = make_request
    make_cal(request)
  end

  def make_request
    MakeRequest.new.make_request
  end

  def make_cal(request)
    calender = MonthlyCalender.new(request)
    calender.make_cal
  end
end
