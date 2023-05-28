# frozen_string_literal: true

class Position
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
    when DIRECTION_TOP_LEFT     then Position.new(row: row - 1, col: col - 1)
    when DIRECTION_TOP          then Position.new(row:, col: col - 1)
    when DIRECTION_TOP_RIGHT    then Position.new(row: row + 1, col: col - 1)
    when DIRECTION_LEFT         then Position.new(row: row - 1, col:)
    when DIRECTION_RIGHT        then Position.new(row: row + 1, col:)
    when DIRECTION_BOTTOM_LEFT  then Position.new(row: row - 1, col: col + 1)
    when DIRECTION_BOTTOM       then Position.new(row:, col: col + 1)
    when DIRECTION_BOTTOM_RIGHT then Position.new(row: row + 1, col: col + 1)
    else raise 'Unknown direction'
    end
  end
end
