# 表示列の最大数をココで変更
ROW = 3

# scale変数を求める
def calc_scale(num)
  if (num % 3) == 0
    num / 3
  else
    (num / 3) + 1
  end
end

# ファイル一覧をlsのルールに従い表示
def display(files, scale)
  scale.times do |y|
    ROW.times {|x| printf "#{files[x * scale + y]}     "}
    printf "\n"
  end
end

files = Dir.glob("*") 
files.sort!
display(files, calc_scale(files.size))
