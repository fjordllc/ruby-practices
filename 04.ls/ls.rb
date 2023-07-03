require "debug"

# homeディレクトリのファイル取得
home = Dir::home
file = Dir::entries("#{home}")
files = []
cols = [*0..4]
rows = [*0..16]

file.each do |x|
  next if x.match?(/^\./)
  files.push(x)
end

nothing_option = files.sort
rows.each do |row|
  cols.each do |col|
    print nothing_option[row + col * 5].ljust(25)
  end
  puts
end
