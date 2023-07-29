# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/reversi_methods'

def build_board(datas)
  board = Array.new(8) { Array.new(8, BLANK_CELL) }
  datas.split("\n").each.with_index do |row, j|
    row.chars.each.with_index do |cell, i|
      board[i][j] = cell.to_i
    end
  end
  board
end

def initial_board
  build_board(<<~BOARD)
    00000000
    00000000
    00000000
    00012000
    00021000
    00000000
    00000000
    00000000
  BOARD
end

class TestReversi < Minitest::Test
  def test_invalid_position
    e = assert_raises RuntimeError do
      put_stone!(initial_board, 'x0', BLACK_STONE)
    end
    assert_equal '無効なポジションです', e.message
  end

  def test_already_have_a_stone
    e = assert_raises RuntimeError do
      put_stone!(initial_board, 'd5', BLACK_STONE)
    end
    assert_equal 'すでに石が置かれています', e.message
  end

  def test_put_stone
    board = initial_board
    assert put_stone!(board, 'e6', BLACK_STONE)
    assert_equal build_board(<<~BOARD), board
      00000000
      00000000
      00000000
      00012000
      00022000
      00002000
      00000000
      00000000
    BOARD
    assert put_stone!(board, 'f4', WHITE_STONE)
    assert_equal build_board(<<~BOARD), board
      00000000
      00000000
      00000000
      00011100
      00022000
      00002000
      00000000
      00000000
    BOARD
  end

  def test_cannot_put_stone
    initial_data = <<~BOARD
      10111100
      10211100
      12111110
      11211100
      12222200
      00200000
      00200000
      00200000
    BOARD
    board = build_board(initial_data)
    refute put_stone!(board, 'b1', BLACK_STONE)
    assert_equal build_board(initial_data), board
  end

  def test_turn
    board = build_board(<<~BOARD)
      00000000
      00020000
      00120000
      00122000
      00111000
      00000000
      00000000
      00000000
    BOARD
    assert put_stone!(board, 'b4', BLACK_STONE)
    assert_equal build_board(<<~BOARD), board
      00000000
      00020000
      00220000
      02222000
      00111000
      00000000
      00000000
      00000000
    BOARD
  end

  def test_finished_of_initial_board
    refute finished?(initial_board) # 初期盤面
  end

  def test_finished_of_full_board
    assert finished?(build_board(<<~BOARD)) # 全て埋まった盤面
      11111111
      12211212
      12222122
      12122222
      12112222
      12111222
      11111122
      12222222
    BOARD
  end

  def test_finished_of_quickest_win_board
    assert finished?(build_board(<<~BOARD)) # 白最短勝利
      00000000
      00010000
      00011000
      01111100
      00011100
      00011100
      00000000
      00000000
    BOARD
    assert finished?(build_board(<<~BOARD)) # 黒最短勝利
      00000000
      00000000
      00002000
      00022200
      00222220
      00022200
      00002000
      00000000
    BOARD
  end

  def test_finished_of_player_skip_board
    refute finished?(build_board(<<~BOARD)) # 白配置可・黒配置不可
      11111112
      12211212
      12222122
      12122220
      12112222
      12111222
      11112122
      12222222
    BOARD
    refute finished?(build_board(<<~BOARD)) # 白配置不可・黒配置可
      11111111
      12211212
      12222122
      12122222
      12112222
      12111222
      22220122
      12222222
    BOARD
  end
end
