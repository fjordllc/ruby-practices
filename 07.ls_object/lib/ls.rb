# frozen_string_literal: true

items = []

NUM_COLUMNS = 3 # 列幅の最大数

def main(items)
  taken_items = take_items(items)
  sliced_items = slice_items(taken_items)
  sorted_items = sort_items(sliced_items)
  display_items(sorted_items)
end

def take_items(items)
  items.concat(Dir.glob('*'))
end

def slice_items(taken_items)
  order_id = if (taken_items.size % NUM_COLUMNS).zero?
               taken_items.size / NUM_COLUMNS.ceil # NUM_COLUMNSの倍数の時だけ、NUM_COLUMNSで割り込む
             else
               taken_items.size / NUM_COLUMNS.ceil + 1 # 最大NUM_COLUMNS列に収める
             end
  taken_items.each_slice(order_id).to_a
end

def sort_items(sliced_items)
  if (0..NUM_COLUMNS).cover?(sliced_items.flatten.size)
    sliced_items.flatten
  else
    max_size = sliced_items.map(&:size).max
    sliced_items.each do |item| # サブ配列の要素数を揃える
      item << nil while item.size < max_size
    end
  end
  sliced_items.transpose
end

def display_items(sorted_items)
  max_word_count = sorted_items.flatten.compact.map(&:size).max
  if (0..NUM_COLUMNS).cover?(sorted_items.flatten.size)
    sorted_items.flatten.map do |item|
      print item.to_s.ljust(max_word_count + 5)
    end
    puts
  else
    sorted_items.each do |items|
      items.compact.each do |item|
        print item.ljust(max_word_count + 5)
      end
      puts
    end
  end
end

main(items)
