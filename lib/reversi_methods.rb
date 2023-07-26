# frozen_string_literal: true

require_relative './position'

WHITE_STONE = 1
BLACK_STONE = 2
BLANK_CELL = 0

# チェスボードを参考として、マスを 'a8', 'd6' と書いて表現する。
# 変数名cellstrとして取り扱う。
ROW = %w[a b c d e f g h].freeze
COL = %w[8 7 6 5 4 3 2 1].freeze

DIRECTIONS = [
  DIRECTION_TOP_LEFT      = :top_left,
  DIRECTION_TOP           = :top,
  DIRECTION_TOP_RIGHT     = :top_right,
  DIRECTION_LEFT          = :left,
  DIRECTION_RIGHT         = :right,
  DIRECTION_BOTTOM_LEFT   = :bottom_left,
  DIRECTION_BOTTOM        = :bottom,
  DIRECTION_BOTTOM_RIGHT  = :bottom_right
].freeze

def output(board)
  puts "  #{ROW.join(' ')}"
  board.each.with_index do |row, i|
    print COL[i].to_s
    row.each do |cell|
      case cell
      when WHITE_STONE then print ' ○'
      when BLACK_STONE then print ' ●'
      else print ' -'
      end
    end
    print "\n"
  end
end

def copy_board(to_board, from_board)
  from_board.each.with_index do |col, col_i|
    col.each.with_index do |cell, row_j|
      to_board[col_i][row_j] = cell
    end
  end
end

def put_stone!(board, cellstr, stone_color, execute = true) # rubocop:disable Style/OptionalBooleanParameter
  pos = Position.new(cellstr:)
  raise '無効なポジションです' if pos.invalid?
  raise 'すでに石が置かれています' unless pos.stone_color(board) == BLANK_CELL

  # コピーした盤面にて石の配置を試みて、成功すれば反映する
  copied_board = Marshal.load(Marshal.dump(board))
  copied_board[pos.row][pos.col] = stone_color

  turn_succeed = false
  DIRECTIONS.each do |direction|
    next_pos = pos.next_position(direction)
    turn_succeed = true if turn!(copied_board, next_pos, stone_color, direction)
  end

  copy_board(board, copied_board) if execute && turn_succeed

  turn_succeed
end

# target_posはひっくり返す対象セル
def turn!(board, target_pos, attack_stone_color, direction)
  return false if target_pos.out_of_board?
  return false if target_pos.stone_color(board) == attack_stone_color

  next_pos = target_pos.next_position(direction)
  if (next_pos.stone_color(board) == attack_stone_color) || turn!(board, next_pos, attack_stone_color, direction)
    board[target_pos.col][target_pos.row] = attack_stone_color
    true
  else
    false
  end
end

def finished?(board)
  !placeable?(board, WHITE_STONE) && !placeable?(board, BLACK_STONE)
end

def placeable?(board, attack_stone_color)
  board.each.with_index do |cols, col|
    cols.each.with_index do |cell, row|
      next unless cell == BLANK_CELL # 空セルでなければ判定skip

      position = Position.new(row:, col:)
      return true if put_stone!(board, position.to_cellstr, attack_stone_color, false)
    end
  end
end

def count_stone(board, stone_color)
  board.flatten.count { |n| n == stone_color }
end
