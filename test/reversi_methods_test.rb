# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/reversi_methods'

class ReversiMethodsTest < Minitest::Test
  include ReversiMethods

  def build_board(board_text)
    board = build_initial_board
    board_text.split("\n").each_with_index do |row, i|
      row.each_char.with_index do |cell, j|
        board[i][j] = cell
      end
    end
    board
  end

  def test_invalid_position
    board = build_initial_board
    e = assert_raises RuntimeError do
      put_stone(board, 'x0', BLACK_STONE)
    end
    assert_equal '無効なポジションです', e.message
  end

  def test_already_have_a_stone
    board = build_initial_board
    e = assert_raises RuntimeError do
      put_stone(board, 'd5', BLACK_STONE)
    end
    assert_equal 'すでに石が置かれています', e.message
  end

  def test_put_stone
    board = build_initial_board
    assert put_stone(board, 'e6', BLACK_STONE)
    assert_equal build_board(<<~BOARD), board
      --------
      --------
      --------
      ---WB---
      ---BB---
      ----B---
      --------
      --------
    BOARD
    assert put_stone(board, 'f4', WHITE_STONE)
    assert_equal build_board(<<~BOARD), board
      --------
      --------
      --------
      ---WWW--
      ---BB---
      ----B---
      --------
      --------
    BOARD
  end

  def test_cannot_put_stone
    initial_data = <<~BOARD
      W-WWWW--
      W-BWWW--
      WBWWWWW-
      WWBWWW--
      WBBBBB--
      --B-----
      --B-----
      --B-----
    BOARD
    board = build_board(initial_data)
    refute put_stone(board, 'b1', BLACK_STONE)
    assert_equal build_board(initial_data), board
  end

  def test_turn
    board = build_board(<<~BOARD)
      --------
      ---B----
      --WB----
      --WBB---
      --WWW---
      --------
      --------
      --------
    BOARD
    assert put_stone(board, 'b4', BLACK_STONE)
    assert_equal build_board(<<~BOARD), board
      --------
      ---B----
      --BB----
      -BBBB---
      --WWW---
      --------
      --------
      --------
    BOARD
  end

  def test_finished_of_initial_board
    board = build_initial_board
    refute finished?(board) # 初期盤面
  end

  def test_finished_of_full_board
    assert finished?(build_board(<<~BOARD)) # 全て埋まった盤面
      WWWWWWWW
      WBBWWBWB
      WBBBBWBB
      WBWBBBBB
      WBWWBBBB
      WBWWWBBB
      WWWWWWBB
      WBBBBBBB
    BOARD
  end

  def test_finished_of_quickest_win_board
    assert finished?(build_board(<<~BOARD)) # 白最短勝利
      --------
      ---W----
      ---WW---
      -WWWWW--
      ---WWW--
      ---WWW--
      --------
      --------
    BOARD
    assert finished?(build_board(<<~BOARD)) # 黒最短勝利
      --------
      --------
      ----B---
      ---BBB--
      --BBBBB-
      ---BBB--
      ----B---
      --------
    BOARD
  end

  def test_finished_of_player_skip_board
    refute finished?(build_board(<<~BOARD)) # 白配置可・黒配置不可
      WWWWWWWB
      WBBWWBWB
      WBBBBWBB
      WBWBBBB-
      WBWWBBBB
      WBWWWBBB
      WWWWBWBB
      WBBBBBBB
    BOARD
    refute finished?(build_board(<<~BOARD)) # 白配置不可・黒配置可
      WWWWWWWW
      WBBWWBWB
      WBBBBWBB
      WBWBBBBB
      WBWWBBBB
      WBWWWBBB
      BBBB-WBB
      WBBBBBBB
    BOARD
  end
end
