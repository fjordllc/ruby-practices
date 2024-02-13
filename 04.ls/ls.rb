# frozen_string_literal: true

require 'optparse'

NUM_COLUMNS = 3 # 列幅の最大数

def main
  taken_items = take_items
  sliced_items = slice_items(taken_items)
  transposed_items = transpose_items(sliced_items)
  display_items(transposed_items)
end

def take_items
  take_hidden_files = false

  OptionParser.new do |opt|
    opt.on('-a') do
      take_hidden_files = true
    end
  end.parse!

  if take_hidden_files
    Dir.foreach('.').to_a
  else
    Dir.glob('*')
  end.sort
end

def slice_items(taken_items)
  slice_number = if (taken_items.size % NUM_COLUMNS).zero?
                   taken_items.size / NUM_COLUMNS.ceil # NUM_COLUMNSの倍数の時だけ、NUM_COLUMNSで割り込む
                 else
                   taken_items.size / NUM_COLUMNS.ceil + 1 # 最大NUM_COLUMNS列に収める
                 end
  taken_items.each_slice(slice_number).to_a
end

def transpose_items(sliced_items)
  max_size = sliced_items.map(&:size).max
  sliced_items.map do |item| # サブ配列の要素数を揃える
    (max_size - item.size).times { item << nil }
    item
  end.transpose
end

def display_items(transposed_items)
  max_word_count = transposed_items.flatten.compact.map(&:size).max
  transposed_items.each do |items|
    items.compact.each do |item|
      print item.ljust(max_word_count + 5)
    end
    puts
  end
end

main
