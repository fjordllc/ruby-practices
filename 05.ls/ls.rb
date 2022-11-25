# frozen_string_literal: true

require 'optparse'

# 表示列の最大数をココで変更
COLUMN = 3

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
  puts "l option"
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
  '7' => 'rwx',
  }

result_l_opt = []

sorted_files.size.times.with_index do |i|
  fs = File::Stat.new(sorted_files[i])
  puts fs.mode.to_s(8)
  # 0 4 0 7 5 5 
  permittion_num = format("%06d", fs.mode.to_s(8)).split("")
  # 04 0 7 5 5 
  permittion_num = [permittion_num[0..1].join,permittion_num[2..5]].flatten
  # d rwx r-x r-x
  # display
  permittion_num.size.times.with_index do |j|
    print cmod_table[permittion_num[j]]
  end

  print " #{fs.nlink}"
  print " #{fs.uid}"
  print " #{fs.gid}"
  print " #{fs.size}"
  print " #{fs.mtime}"
  print " #{sorted_files[i]}"




  # drwxr-xr-x  4 taku.fujisaki  staff   128 Nov 18 09:35 01.fizzbuzz
  puts

  

end







# params[:l] ? display_l(sorted_files, calc_row(sorted_files.size)) : display(sorted_files, calc_row(sorted_files.size))
