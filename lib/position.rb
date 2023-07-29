# frozen_string_literal: true

class Position
  # チェスボードを参考として、マスを 'a8', 'd6' と書いて表現する。
  # 変数名cell_refとして取り扱う。
  ROW = %w[a b c d e f g h].freeze
  COL = %w[8 7 6 5 4 3 2 1].freeze

  DIRECTIONS = [
    TOP_LEFT      = :top_left,
    TOP           = :top,
    TOP_RIGHT     = :top_right,
    LEFT          = :left,
    RIGHT         = :right,
    BOTTOM_LEFT   = :bottom_left,
    BOTTOM        = :bottom,
    BOTTOM_RIGHT  = :bottom_right
  ].freeze

  attr_accessor :row, :col

  def initialize(row_or_cell_ref, col = nil)
    if col
      # Position.new(1, 5) のような呼び出し
      @row = row_or_cell_ref
      @col = col
    else
      # Position.new('f7')のような呼び出し
      @row = ROW.index(row_or_cell_ref[0])
      @col = COL.index(row_or_cell_ref[1])
    end
  end

  def invalid?
    row.nil? || col.nil?
  end

  def out_of_board?
    !((0..7).cover?(row) && (0..7).cover?(col))
  end

  def stone_color(board)
    return nil if out_of_board?

    board[row][col]
  end

  def to_cell_ref
    return '盤面外' if out_of_board?

    "#{ROW[row]}#{COL[col]}"
  end

  def next_position(direction)
    case direction
    when TOP_LEFT     then Position.new(row - 1,  col - 1)
    when TOP          then Position.new(row,      col - 1)
    when TOP_RIGHT    then Position.new(row + 1,  col - 1)
    when LEFT         then Position.new(row - 1,  col)
    when RIGHT        then Position.new(row + 1,  col)
    when BOTTOM_LEFT  then Position.new(row - 1,  col + 1)
    when BOTTOM       then Position.new(row,      col + 1)
    when BOTTOM_RIGHT then Position.new(row + 1,  col + 1)
    else raise 'Unknown direction'
    end
  end
end
