# frozen_string_literal: true

require 'optparse'
require 'prettyprint'
require 'etc'

class Array
  def count_longest_letters(plus)
    inject(0) do |result, item|
      result = item.size if item.size > result
      result
    end + plus
  end

  # ディレクトリの場合は'/'を後ろにつける
  def add_slash_on_dir
    map do |file|
      File.directory?(file) ? "#{file}/" : file
    end
  end
end

all = false
long = false
reverse = false

opt = OptionParser.new
opt.on('-a', 'Include directory entries whose names begin with a dot (.).') { all = true }
opt.on('-l', 'List in long format.') { long = true }
opt.on('-r', 'Reverse the order of the sort') { reverse = true }
opt.parse(ARGV)

p2 = PrettyPrint.new

files = Dir.entries('.').sort.add_slash_on_dir
# .を含むかどうか切り替える
files = all ? files : files.filter { |path| !path.match?(/^\./) }
# 反転させるかどうか切り替える
files = reverse ? files.reverse : files

def permission(stat)
  temp = stat.directory? ? 'd' : '-'
  format('0%o', stat.mode)[-3, 3].each_char do |i|
    case i
    when '7' then temp += 'rwx'
    when '6' then temp += 'rw-'
    when '5' then temp += 'r-x'
    when '4' then temp += 'r--'
    when '3' then temp += '-wx'
    when '2' then temp += '-w-'
    when '1' then temp += '--x'
    when '0' then temp += '---'
    end
  end
  temp
end

if long
  blocks = 0
  p2.group do
    files.each do |file|
      stat = File.stat file
      blocks += stat.blocks
      p2.text(permission(stat))
      p2.text(stat.nlink.to_s.rjust(3))
      p2.text(" #{Etc.getpwuid(stat.uid).name}")
      p2.text("  #{Etc.getgrgid(stat.gid).name}")
      p2.text("  #{stat.size.to_s.rjust(4)}")
      p2.text(stat.mtime.strftime(' %_m %_d %R '))
      p2.text(file)
      p2.breakable
    end
  end
  puts "total #{blocks}"
else
  height = files.size / 3
  mod = files.size % 3

  fst = files.slice!(0, mod.positive? ? height + 1 : height)
  snd = files.slice!(0, mod.positive? ? height + 1 : height)
  trd = files

  f_max = fst.count_longest_letters 4
  s_max = snd.count_longest_letters 4
  t_max = trd.count_longest_letters 4

  p2.group do
    fst.size.times do |i|
      p2.text(fst[i].ljust(f_max))
      p2.text(snd[i].ljust(s_max)) unless i >= snd.size
      p2.text(trd[i].ljust(t_max)) unless i >= trd.size
      p2.breakable
    end
  end
end

p2.flush
puts p2.output
