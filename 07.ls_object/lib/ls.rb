# frozen_string_literal: true

items = []

def get_items(items)
  items.concat(Dir.glob('*'))
end

def slice_items(items)
  get_items(items)
  if (0..3).cover?(items)
    print items.join(' ') # 要素数が3つ以下は横並び出力
    puts
  elsif (items.size % 3).zero?
    order_id = items.size / 3.ceil # 3の倍数の時だけ、3で割り込む
    sliced_items = items.each_slice(order_id).to_a
  else
    order_id = items.size / 3.ceil + 1 # 最大3列に収める
    sliced_items = items.each_slice(order_id).to_a
  end
end

def sorting(items)
  sliced_items = slice_items(items)
  case items.size
  when 0..3
    # 何もしない
  else
    max_size = sliced_items.map(&:size).max
    sliced_items.each do |item| # サブ配列の要素数を揃える
      item << nil while item.size < max_size
    end
    sliced_items.transpose.each do |items|
      items.each do |item|
        print item.to_s.ljust(20)
      end
      puts
    end
  end
end

sorting(items)
