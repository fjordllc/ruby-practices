require 'minitest/autorun'
require_relative '../lib/bowling'

class BowlingTest < Minitest::Test
  # ストライクの記号を点数(10)に変換できること
  def score_parse_to_number
    assert_equal [6,3,9,0,0,3,8,2,7,3,10,9,1,8,0,10,6,4,5], Bowling.score
  end

  # ストライク、スペアが含まれないスコア計算
  def score_of_nothing_spare_and_strike
    assert_equal [6,3, 9,0, 0,3, 8,2, 7,3, 10, 9,1, 8,0, 10, 6,4,5], Bowling.score
  end

  # スペアが含まれるスコアの計算
  def score_has_spare
  end

  # ストライクが含まれるスコアの計算
  def score_has_strike
  end

  # スペアとストライクが含まれるスコアの計算(ストライクは最終フレーム以外)
  def score_has_spare_and_strike
  end

  # 最終フレームが3投である場合
  def score_last_frame_is_three_shots
  end
end
