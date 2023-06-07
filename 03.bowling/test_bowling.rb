# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'bowling'

class BowlingTest < Minitest::Test
  def test_bowling
    assert_output("139\n") { bowling('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5') }
    assert_output("164\n") { bowling('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X') }
    assert_output("107\n") { bowling('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4') }
    assert_output("134\n") { bowling('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0') }
    assert_output("144\n") { bowling('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8') }
    assert_output("300\n") { bowling('X,X,X,X,X,X,X,X,X,X,X,X') }
  end
end
