# frozen_string_literal: true

require 'optparse'
require 'etc'

# 表示列の最大数をココで変更
COLUMN = 3

CMOD_TABLE = {
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
}.freeze

MONTH_TABLE = {
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
}.freeze

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

  # 各項目の最大文字数を求める
  nlink_str_size = []
  uid_str_size = []
  gid_str_size = []
  filesize_str_size = []

  sorted_files.size.times do |i|
    fs = File::Stat.new(sorted_files[i])
    nlink_str_size << fs.nlink.to_s.size
    uid_str_size << Etc.getpwuid(fs.uid).name.to_s.size
    gid_str_size << Etc.getgrgid(fs.gid).name.to_s.size
    filesize_str_size << fs.size.to_s.size
  end

  nlink_brank = nlink_str_size.max
  uid_brank = uid_str_size.max + 2
  gid_brank = gid_str_size.max + 1
  filesize_brank = filesize_str_size.max + 1

  # 表示
  sorted_files.size.times do |i|
    fs = File::Stat.new(sorted_files[i])
    # 権限
    cmod = ''
    permission_num = format('%06d', fs.mode.to_s(8)).split('')
    permission_num = [permission_num[0..1].join, permission_num[2..5]].flatten
    permission_num.size.times do |j|
      cmod += CMOD_TABLE[permission_num[j]]
    end

    print cmod.ljust(12)
    print fs.nlink.to_s.rjust(nlink_brank)
    print ' '
    print Etc.getpwuid(fs.uid).name.ljust(uid_brank)
    print Etc.getgrgid(fs.gid).name.ljust(gid_brank)
    print fs.size.to_s.rjust(filesize_brank)
    print MONTH_TABLE[fs.mtime.to_a.slice(4).to_s].rjust(4)
    print fs.mtime.to_a.slice(3).to_s.rjust(3)
    print Time.now - fs.mtime < 15_552_000 ? fs.mtime.to_s.slice(11, 5).to_s.rjust(6) : fs.mtime.to_a.slice(5).to_s.rjust(6)
    print ' '
    print sorted_files[i]
    puts
  end
else
  display(sorted_files, calc_row(sorted_files.size))
end
