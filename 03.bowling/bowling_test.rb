# frozen_string_literal: true

require 'minitest/autorun'

class BowlingTest < Minitest::Test
  def test_bowling_case1
    ARGV.replace(['6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'])
    $stdout = StringIO.new
    load './bowling.rb'
    out = $stdout.string
    assert_equal '139', out.lines[0].chomp
  end

  def test_bowling_case2
    ARGV.replace(['6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'])
    $stdout = StringIO.new
    load './bowling.rb'
    out = $stdout.string
    assert_equal '164', out.lines[0].chomp
  end

  def test_bowling_case3
    ARGV.replace(['0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'])
    $stdout = StringIO.new
    load './bowling.rb'
    out = $stdout.string
    assert_equal '107', out.lines[0].chomp
  end

  def test_bowling_case4
    ARGV.replace(['6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'])
    $stdout = StringIO.new
    load './bowling.rb'
    out = $stdout.string
    assert_equal '134', out.lines[0].chomp
  end

  def test_bowling_case5
    ARGV.replace(['6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8'])
    $stdout = StringIO.new
    load './bowling.rb'
    out = $stdout.string
    assert_equal '144', out.lines[0].chomp
  end

  def test_bowling_case6
    ARGV.replace(['X,X,X,X,X,X,X,X,X,X,X,X'])
    $stdout = StringIO.new
    load './bowling.rb'
    out = $stdout.string
    assert_equal '300', out.lines[0].chomp
  end

  def test_bowling_case7
    ARGV.replace(['X,0,0,X,0,0,X,0,0,X,0,0,X,0,0 '])
    $stdout = StringIO.new
    load './bowling.rb'
    out = $stdout.string
    assert_equal '50', out.lines[0].chomp
  end
end
