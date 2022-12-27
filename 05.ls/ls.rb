# frozen_string_literal: true

require 'optparse'
require 'etc'

# 表示列の最大数をココで変更
COLUMN = 3

cmod_table = {
  '01' => 'p',
  '02' => 'c',
  '04' => 'd',
  '06' => 'b',
  '10' => '-',
  '12' => 'l',
  '14' => 's',

  '0' => '',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}

month_table = {
  '1' => 'Jan',
  '2' => 'Feb',
  '3' => 'Mar',
  '4' => 'Apr',
  '5' => 'May',
  '6' => 'Jun',
  '7' => 'Jul',
  '8' => 'Aug',
  '9' => 'Sep',
  '10' => 'Oct',
  '11' => 'Nov',
  '12' => 'Dec'
}

# 表示時に必要な行数rowを求める
def calc_row(num)
  (num % 3).zero? ? num / 3 : (num / 3) + 1
end

# ファイル一覧をlsのルールに従い表示
def display(files, row)
  row.times do |y|
    COLUMN.times { |x| printf(files[x * row + y].to_s.ljust(files.map(&:size).max + 3)) }
    puts
  end
end

def display_l(files, row)
  row.times do |y|
    COLUMN.times { |x| printf(files[x * row + y].to_s.ljust(files.map(&:size).max + 3)) }
    puts
  end
end

opt = OptionParser.new
params = {}
opt.on('-l') { |v| params[:l] = v }
opt.parse!(ARGV)

# display files
sorted_files = Dir.glob('*').sort

# l オプション機能
if params[:l]
  # ブロックの合計値
  total = sorted_files.size.times.sum do |i|
    File::Stat.new(sorted_files[i]).blocks.to_i
  end
  puts "total #{total}"

  sorted_files.size.times do |i|
    fs = File::Stat.new(sorted_files[i])
    # 権限
    cmod = ''
    permittion_num = format('%06d', fs.mode.to_s(8)).split('')
    permittion_num = [permittion_num[0..1].join, permittion_num[2..5]].flatten
    permittion_num.size.times do |j|
      cmod += cmod_table[permittion_num[j]]
    end
    print format('%-10s', cmod)

    print format(' %3d', fs.nlink)
    print " #{Etc.getpwuid(fs.uid).name}"
    print " #{Etc.getgrgid(fs.gid).name}"
    print format(' %6d', fs.size)
    print " #{month_table[fs.mtime.to_a.slice(4).to_s]}"
    print format('% 3d', fs.mtime.to_a.slice(3))
    print Time.now - fs.mtime < 15_552_000 ? " #{fs.mtime.to_s.slice(11, 5)}" : " #{format(' %2d', fs.mtime.to_a.slice(5))}"
    print " #{sorted_files[i]}"
    puts
  end
else
  display(sorted_files, calc_row(sorted_files.size))
end
