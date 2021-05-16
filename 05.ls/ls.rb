# frozen_string_literal: true

require 'optparse'
require 'etc'

options = ARGV.getopts('a', 'l', 'r')
# カレントディレクトリに含まれるファイルを配列で取得
files = Dir.glob('*')

files = Dir.glob('*', File::FNM_DOTMATCH) if options['a']
files = files.reverse if options['r']

if options['l']
  def file_type(type)
    file_type = {
      'file' => '-',
      'directory' => 'd',
      'link' => 'l'
    }[type]
  end

  def file_mode(mode)
    permissions = {
      '0' => '---',
      '1' => '--x',
      '2' => 'r--',
      '3' => '-w-',
      '4' => '-wx',
      '5' => 'r-x',
      '6' => 'rw-',
      '7' => 'rwx'
    }
    mode.map { |i| permissions[i] }
  end

  # totalを取得
  file_blocks = files.map { |list| File.stat(list).blocks }
  total = file_blocks.sum
  puts "total #{total}"

  files.each do |list|
    file = File.stat(list) # File::Statオブジェクトを作成
    file_mode = file_mode(file.mode.to_s(8)[-3, 3].chars).join
    file_type = file_type(file.ftype)
    file_link = file.nlink
    file_uid = Etc.getpwuid(file.uid).name
    file_gid = Etc.getgrgid(file.gid).name
    file_size = file.size
    time_stamp = file.mtime.strftime('%m %d %H:%M')
    file_name = list
    puts "#{file_type}#{file_mode} #{file_link.to_s.rjust(2)} #{file_uid} #{file_gid} #{file_size.to_s.rjust(4)} #{time_stamp} #{file_name}"
  end
  return
end

first_column = if (files.size % 3).zero?
                 files.size / 3 + 1
               else
                 files.size / 3 + files.size % 3
               end
# 最初の列のファイル数に合わせて配列を作る。配列の要素数が足りない時はスペースを詰め込む
lines = files.each_slice(first_column).to_a
lines.each do |line|
  next unless line.size < first_column

  (first_column - line.size).times do
    line << ' '
  end
end

unless options['l']
  # transposeする。ljustはとりあえず24にしてみる
  lines.transpose.each do |new_line|
    new_line.each do |file|
      print file.ljust(24)
    end
    print "\n"
  end
end
