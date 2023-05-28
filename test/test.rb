# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/reversi_methods'

def build_board(filename)
  target_file = File.join(File.dirname(__FILE__), filename)
  datas = File.open(target_file).read.split("\n")
  board = Array.new(8) { Array.new(8, BLANK_CELL) }
  datas.each.with_index do |row, i|
    row.chars.each.with_index do |cell, j|
      board[i][j] = cell.to_i
    end
  end
  board
end

class TestReversi < Minitest::Test
  def test_invalid_position
    board = build_board('pattern00.txt')
    e = assert_raises RuntimeError do
      put_stone!(board, 'x0', BLACK_STONE)
    end
    assert_equal '無効なポジションです', e.message
  end

  def test_already_have_a_stone
    board = build_board('pattern00.txt')
    e = assert_raises RuntimeError do
      put_stone!(board, 'd5', BLACK_STONE)
    end
    assert_equal 'すでに石が置かれています', e.message
  end

  def test_put_stone
    board = build_board('pattern00.txt')
    assert_equal true, put_stone!(board, 'e3', BLACK_STONE)
    assert_equal build_board('pattern00_step1.txt'), board
    assert_equal true, put_stone!(board, 'f5', WHITE_STONE)
    assert_equal build_board('pattern00_step2.txt'), board
  end

  def test_cannot_put_stone
    board = build_board('pattern01.txt')
    assert_equal false, put_stone!(board, 'b8', BLACK_STONE)
    assert_equal build_board('pattern01.txt'), board
  end

  def test_turn
    board = build_board('pattern02.txt')
    assert_equal true, put_stone!(board, 'b5', BLACK_STONE)
    assert_equal build_board('pattern02_after.txt'), board
  end

  def test_finished?
    assert_equal false, finished?(build_board('pattern00.txt'))  # 初期盤面
    assert_equal true,  finished?(build_board('pattern03a.txt')) # 全て埋まった
    assert_equal true,  finished?(build_board('pattern03b.txt')) # 白最短勝利
    assert_equal true,  finished?(build_board('pattern03c.txt')) # 黒最短勝利
    assert_equal false, finished?(build_board('pattern03d.txt')) # 白配置可・黒配置不可
    assert_equal false, finished?(build_board('pattern03e.txt')) # 白配置不可・黒配置可
  end
end
