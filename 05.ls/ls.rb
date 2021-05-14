# frozen_string_literal: true

require 'optparse'
require 'etc'

options = ARGV.getopts('a', 'l', 'r')

# カレントディレクトリに含まれるファイルを配列で取得
p lists = Dir.glob('*')
p lists.each_slice(3).to_a.transpose

if options['a']
  puts Dir.glob('*', File::FNM_DOTMATCH).sort.join(" ")
elsif options['r']
  puts lists.reverse.join(" ")
else
  puts lists.join(" ")
end

file_type = {
  "file" => '-',
  "directory" => 'd',
  "symblic-link" => 'l'
}

# file_status = File.stat("#{path}#{file}")

def file_mode(mode)
  s = []
  mode.each do |i|
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
    s << permissions[i] 
  end
  s.join
end

lists.each do |list|
  file = File.stat(list) # File::Statオブジェクトを作成
  file_type = file.ftype
  file_uid = Etc.getpwuid(file.uid).name
  file_gid = Etc.getgrgid(file.gid).name
  file_size = file.size
  time_stamp = file.mtime.strftime("%m %d %H:%M")
  file_name = list
  puts "#{file_uid} #{file_gid} #{file_size} #{time_stamp} #{file_name}" 
end
