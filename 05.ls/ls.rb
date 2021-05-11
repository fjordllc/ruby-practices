# - 引数を受け取る
p dir = ARGV[0]
# カレントディレクトリを表示
p Dir.pwd
p Dir.glob("*")

# - ディレクトリ名を受け取る
# - ディレクトリに含まれるファイル、ディレクトリを解析する
# - ↑ で解析した内容をコンソールに出力する

Dir.foreach('.') do |item|
  next if item == '.' or item == '..'
  puts item
end
