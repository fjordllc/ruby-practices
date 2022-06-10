# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'

class ListTest < Minitest::Test
  def setup
    @list = List.new
  end

  def test_show
    output1 = 'column_test.rb   ls_test.rb   '
    assert_equal output1, @list.show
  end
end
