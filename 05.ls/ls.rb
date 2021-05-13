# frozen_string_literal: true

require 'optparse'
options = ARGV.getopts('a', 'l', 'r')

# カレントディレクトリに含まれるファイルを配列で取得
lists = Dir.glob('*')
p lists.each_slice(3).to_a.transpose

if options['a']
  puts Dir.glob('*', File::FNM_DOTMATCH).sort.join(" ")
elsif options['r']
  puts lists.reverse.join(" ")
else
  puts lists.join(" ")
end

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

file_type = {
  "file" => '-',
  "directory" => 'd',
  "symblic-link" => 'l'
}

lists.each do |file|
  p file
end

filestat = File.stat("#{path}#{file}")
