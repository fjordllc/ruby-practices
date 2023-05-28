# frozen_string_literal: true

require_relative './lib/reversi_methods'

QUIT_COMMANDS = %w[quit exit q].freeze
@quit = false

# @boardは盤面を示す二次元配列
@board = Array.new(8) { Array.new(8, BLANK_CELL) }
@board[3][3] = WHITE_STONE # d5
@board[4][4] = WHITE_STONE # e4
@board[3][4] = BLACK_STONE # d4
@board[4][3] = BLACK_STONE # e5

@turn_stone_color = BLACK_STONE # 現在の手番の石色、初手は黒から

def turn_stone_color_str
  return '黒●' if @turn_stone_color == BLACK_STONE
  return '白○' if @turn_stone_color == WHITE_STONE

  raise '石色エラー'
end

def switch_stone_color
  case @turn_stone_color
  when BLACK_STONE then @turn_stone_color = WHITE_STONE
  when WHITE_STONE then @turn_stone_color = BLACK_STONE
  end
end

until @quit
  output(@board)

  if finished?(@board)
    puts '試合終了'
    puts "白○:#{count_stone(@board, WHITE_STONE)}"
    puts "黒●:#{count_stone(@board, BLACK_STONE)}"
    @quit = true
    next
  end

  unless placeable?(@board, @turn_stone_color)
    puts '詰みのためターンを切り替えます'
    switch_stone_color
    next
  end

  print "command? (#{turn_stone_color_str}) >"
  command = gets.chomp
  @quit = true and next if QUIT_COMMANDS.include?(command)

  begin
    if put_stone!(@board, command, @turn_stone_color)
      puts '配置成功、次のターン'
      switch_stone_color
    else
      puts '配置失敗、ターン据え置き'
    end
  rescue StandardError => e
    puts "ERROR: #{e.message}"
  end
end

puts 'finished!'
