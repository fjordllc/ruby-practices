# frozen_string_literal: true

items = []

num_columns = 3 # 列幅の最大数

def get_items(items)
  items.concat(Dir.glob('*'))
end

def slice_items(items, num_columns)
  get_items(items)
  if (0..num_columns).cover?(items.size)
    print items.join(' ') # 要素数が3つ以下は横並び出力
    puts
  elsif (items.size % num_columns).zero?
    order_id = items.size / num_columns.ceil # 3の倍数の時だけ、3で割り込む
    items.each_slice(order_id).to_a
  else
    order_id = items.size / num_columns.ceil + 1 # 最大3列に収める
    items.each_slice(order_id).to_a
  end
end

def sort_items(items, num_columns)
  sliced_items = slice_items(items, num_columns)
  return unless items.size > num_columns

  max_size = sliced_items.map(&:size).max
  sliced_items.each do |item| # サブ配列の要素数を揃える
    item << nil while item.size < max_size
  end
  sliced_items.transpose.each do |elements|
    elements.each do |element|
      print element.to_s.ljust(20)
    end
    puts
  end
end

sort_items(items, num_columns)
