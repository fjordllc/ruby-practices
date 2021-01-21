# !/usr/bin/env ruby
# frozen_string_literal: true

#ディレクトリの中身を取得(ls)
def ls
  Dir.glob("*").sort
end
puts ls.join("\n")
ls1 = ls.join(' ',)
puts ls1.split(' ',4)

#ディレクトリの中身を逆から取得(ls -r)
def lsr
  Dir.glob("*").sort.reverse
end
puts lsr.join(' ')

#ディレクトリの隠しファイルを含めた中身を取得(ls -a)
def lsa
  Dir.glob("*", File::FNM_DOTMATCH).sort
end
puts lsa.join(' ')
#ディレクトリの隠しファイルえお含めた中身を取得(ls -ar/ls -ra)
def lsar
  Dir.glob("*", File::FNM_DOTMATCH).sort.reverse
end
puts lsar.join(' ')

#ディレクトリの詳細を含めた中身を取得(考え中)
#下記はディレクトリの詳細と思われるのでディレクトリ内のファイルの詳細を出力するようにする
#ループで-lの出力結果に近づける？(21.01.10)
#ディレクトリ内のファイルの数も出力が必要

total_size = ["total"] + [File::Stat.new($0).size]
total_blksize = ["total"] + [File::Stat.new($0).blksize]
total_blocks = ["total"] + [File::Stat.new($0).blocks]

fs1 = File::Stat.new(ls[0])
fs2 = File::Stat.new(ls[1])
fs3 = File::Stat.new(ls[2])
fs4 = File::Stat.new(ls[3])
fs5 = File::Stat.new(ls[4])
fs6 = File::Stat.new(ls[5])
fs7 = File::Stat.new(ls[6])
fs8 = File::Stat.new(ls[7])
fs9 = File::Stat.new(ls[8])
fs10 = File::Stat.new(ls[9])

require 'etc'
uid1 = Etc.getpwuid(File.stat(ls[0]).uid).name
uid2 = Etc.getpwuid(File.stat(ls[1]).uid).name
uid3 = Etc.getpwuid(File.stat(ls[2]).uid).name
uid4 = Etc.getpwuid(File.stat(ls[3]).uid).name
uid5 = Etc.getpwuid(File.stat(ls[4]).uid).name
uid6 = Etc.getpwuid(File.stat(ls[5]).uid).name
uid7 = Etc.getpwuid(File.stat(ls[6]).uid).name
uid8 = Etc.getpwuid(File.stat(ls[7]).uid).name
uid9 = Etc.getpwuid(File.stat(ls[8]).uid).name
uid10 = Etc.getpwuid(File.stat(ls[9]).uid).name

require 'etc'
gid1 = Etc.getgrgid(File.stat(ls[0]).gid).name
gid2 = Etc.getgrgid(File.stat(ls[1]).gid).name
gid3 = Etc.getgrgid(File.stat(ls[2]).gid).name
gid4 = Etc.getgrgid(File.stat(ls[3]).gid).name
gid5 = Etc.getgrgid(File.stat(ls[4]).gid).name
gid6 = Etc.getgrgid(File.stat(ls[5]).gid).name
gid7 = Etc.getgrgid(File.stat(ls[6]).gid).name
gid8 = Etc.getgrgid(File.stat(ls[7]).gid).name
gid9 = Etc.getgrgid(File.stat(ls[8]).gid).name
gid10 = Etc.getgrgid(File.stat(ls[9]).gid).name

l1 = [fs1.rdev_major] + [fs1.mode] + [fs1.nlink] + [uid1] + [gid1] + [fs1.size] + [fs1.mtime.strftime("%b %e %H:%M")] + [ls[0]] #01
l2 = [fs2.rdev_major] + [fs2.mode] + [fs2.nlink] + [uid2] + [gid2] + [fs2.size] + [fs2.mtime.strftime("%b %e %H:%M")] + [ls[1]] #02
l3 = [fs3.rdev_major] + [fs3.mode] + [fs3.nlink] + [uid3] + [gid3] + [fs3.size] + [fs3.mtime.strftime("%b %e %H:%M")] + [ls[2]] #03
l4 = [fs4.rdev_major] + [fs4.mode] + [fs4.nlink] + [uid4] + [gid4] + [fs4.size] + [fs4.mtime.strftime("%b %e %H:%M")] + [ls[3]] #04
l5 = [fs5.rdev_major] + [fs5.mode] + [fs5.nlink] + [uid5] + [gid5] + [fs5.size] + [fs5.mtime.strftime("%b %e %H:%M")] + [ls[4]] #05
l6 = [fs6.rdev_major] + [fs6.mode] + [fs6.nlink] + [uid6] + [gid6] + [fs6.size] + [fs6.mtime.strftime("%b %e %H:%M")] + [ls[5]] #06
l7 = [fs7.rdev_major] + [fs7.mode] + [fs7.nlink] + [uid7] + [gid7] + [fs7.size] + [fs7.mtime.strftime("%b %e %H:%M")] + [ls[6]] #07
l8 = [fs8.rdev_major] + [fs8.mode] + [fs8.nlink] + [uid8] + [gid8] + [fs8.size] + [fs8.mtime.strftime("%b %e %H:%M")] + [ls[7]] #08
l9 = [fs9.rdev_major] + [fs9.mode] + [fs9.nlink] + [uid9] + [gid9] + [fs9.size] + [fs9.mtime.strftime("%b %e %H:%M")] + [ls[8]] #09
l10 = [fs10.rdev_major] + [fs10.mode] + [fs10.nlink] + [uid10] + [gid10] + [fs10.size] + [fs10.mtime.strftime("%b %e %H:%M")] + [ls[9]] #10

puts total_size.join(' ')
puts total_blksize.join(' ')
puts total_blocks.join(' ')
puts l1.join(' ')
puts l2.join(' ')
puts l3.join(' ')
puts l4.join(' ')
puts l5.join(' ')
puts l6.join(' ')
puts l7.join(' ')
puts l8.join(' ')
puts l9.join(' ')
puts l10.join(' ')

puts fs1.mode
puts fs1.mode.to_s(8)

puts fs4.mode
puts fs4.mode.to_s(8)
