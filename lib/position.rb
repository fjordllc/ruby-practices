# frozen_string_literal: true

class Position

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

  def initialize(cellstr: nil, row: nil, col: nil)
    if cellstr
      @row = ROW.index(cellstr[0])
      @col = COL.index(cellstr[1])
    else
      @row = row
      @col = col
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

    board[col][row]
  end

  def to_cellstr
    return '盤面外' if out_of_board?

    "#{ROW[row]}#{COL[col]}"
  end

  def next_position(direction)
    case direction
    when TOP_LEFT     then Position.new(row: row - 1, col: col - 1)
    when TOP          then Position.new(row:, col: col - 1)
    when TOP_RIGHT    then Position.new(row: row + 1, col: col - 1)
    when LEFT         then Position.new(row: row - 1, col:)
    when RIGHT        then Position.new(row: row + 1, col:)
    when BOTTOM_LEFT  then Position.new(row: row - 1, col: col + 1)
    when BOTTOM       then Position.new(row:, col: col + 1)
    when BOTTOM_RIGHT then Position.new(row: row + 1, col: col + 1)
    else raise 'Unknown direction'
    end
  end
end
