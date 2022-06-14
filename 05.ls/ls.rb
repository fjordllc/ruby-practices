def load_dir(dir) #引数に入力したディレクトリの内容一覧を配列として取得
  list = []
  Dir.each_child(dir) do |f|
    list << f
  end
  list
end

def sort_list(max_column) # 引数に入力した列数でディレクトリの内容一覧を表示
  max_low = get_ls('test').size / max_column + 1 # 表示する行数の最大を計算

  sorted_list = get_ls('test').sort.each_slice(max_low).to_a

  new_sorted_list = sorted_list.map do |a|
    a.values_at(0..max_low-1)
  end

  new_sorted_list.transpose.each do |files|
    print files.join(" ") + "\n"
  end
end

load_dir('test')
sort_list(3)


max_column = 3 # 表示する最大列数をここで設定

