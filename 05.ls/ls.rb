# !/usr/bin/env ruby
# frozen_string_literal: true

#ディレクトリの中身を取得(ls)
def ls
  Dir.glob("*").sort
end
puts ls.join(' ')
puts ls.each_slice(4).map {|arr| puts arr.join("   ")}
#ls1 = ls.join(' ',)
#puts ls1.split(' ',4)

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

#if などで他の条件の時も条件にあった値を出力する様にする
def mode_basea
  File::Stat.new(ls[0]).mode.to_s(8)
end
def mode_base01
  mode_basea[-5]='d'
end
def mode_base02
  mode_basea[-3]='rwx'
end
def mode_base03
  mode_basea[-2]='r-x'
end
def mode_base04
  mode_basea[-1]='r-x'
end

#def mode_base01
  #if mode_basea[-5] == 1
    #puts 'p'
  #end
  #if mode_basea[-5] == 2
    #puts 'c'
  #end  
  #if mode_basea[-5] == 4
    #puts 'd'
  #end  
  #if mode_basea[-5] == 6
    #puts 'b'
  #end  
#end
#puts mode_base01

#def mode_base01
  #mode_basea[-5]='d'
#end

#if などで他の条件の時も条件にあった値を出力する様にする
def mode_baseb
  File::Stat.new(ls[3]).mode.to_s(8)
end 
def mode_base11
  mode_baseb[-6..-5]='-'
end
def mode_base12
  mode_baseb[-3]='rw-'
end
def mode_base13
  mode_baseb[-2]='r--'
end
def mode_base14
  mode_baseb[-1]='r--'
end

mode_sum1 = [mode_base01] + [mode_base02] + [mode_base03] + [mode_base04]
mode_sum2 = [mode_base11] + [mode_base12] + [mode_base13] + [mode_base14]

mode_a = mode_sum1.join
mode_b = mode_sum2.join

#def mode
  #8進法の40755を6ケタに変換
  #printf("%06d\r\n", mode_base)
#end
#[04][0][7][5][5]に変換
#[04]=>d[0][7]=>rwx[5]=>r-x[5]=>r-x

#mode1 = File::Stat.new(ls[0]).mode.to_s(8)
mode1 = mode_a
#mode2 = File::Stat.new(ls[1]).mode.to_s(8)
mode2 = mode_a
#mode3 = File::Stat.new(ls[2]).mode.to_s(8)
mode3 = mode_a
#mode4 = File::Stat.new(ls[3]).mode.to_s(8)
mode4 = mode_b
#mode5 = File::Stat.new(ls[4]).mode.to_s(8)
mode5 = mode_b
#mode6 = File::Stat.new(ls[5]).mode.to_s(8)
mode6 = mode_b
#mode7 = File::Stat.new(ls[6]).mode.to_s(8)
mode7 = mode_b
#mode8 = File::Stat.new(ls[7]).mode.to_s(8)
mode8 = mode_b
#mode9 = File::Stat.new(ls[8]).mode.to_s(8)
mode9 = mode_b
#mode10 = File::Stat.new(ls[9]).mode.to_s(8)
mode10 = mode_b

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

# 後で左記を確認 https://docs.ruby-lang.org/ja/latest/method/String/i/rjust.html (rjust についt)
# 後で左記を確認 https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/collect.html (map についt)
l1 = [mode1] + [' '] + [fs1.nlink] + [uid1] + [' '] + [gid1] + [' '] + [fs1.size] + [' '] + [fs1.mtime.strftime("%b %e %H:%M")] + [' '] + [ls[0]] #01
l2 = [mode2] + [' '] + [fs2.nlink] + [uid2] + [' '] + [gid2] + [' '] + [fs2.size] + [' '] + [fs2.mtime.strftime("%b %e %H:%M")] + [' '] + [ls[1]] #02
l3 = [mode3] + [' '] + [fs3.nlink] + [uid3] + [' '] + [gid3] + [' '] + [fs3.size] + [' '] + [fs3.mtime.strftime("%b %e %H:%M")] + [' '] + [ls[2]] #03
l4 = [mode4] + [' '] + [fs4.nlink] + [uid4] + [' '] + [gid4] + [' '] + [fs4.size] + [' '] + [fs4.mtime.strftime("%b %e %H:%M")] + [' '] + [ls[3]] #04
l5 = [mode5] + [' '] + [fs5.nlink] + [uid5] + [' '] + [gid5] + [' '] + [fs5.size] + [' '] + [fs5.mtime.strftime("%b %e %H:%M")] + [' '] + [ls[4]] #05
l6 = [mode6] + [' '] + [fs6.nlink] + [uid6] + [' '] + [gid6] + [' '] + [fs6.size] + [' '] + [fs6.mtime.strftime("%b %e %H:%M")] + [' '] + [ls[5]] #06
l7 = [mode7] + [' '] + [fs7.nlink] + [uid7] + [' '] + [gid7] + [' '] + [fs7.size] + [' '] + [fs7.mtime.strftime("%b %e %H:%M")] + [' '] + [ls[6]] #07
l8 = [mode8] + [' '] + [fs8.nlink] + [uid8] + [' '] + [gid8] + [' '] + [fs8.size] + [' '] + [fs8.mtime.strftime("%b %e %H:%M")] + [' '] + [ls[7]] #08
l9 = [mode9] + [' '] + [fs9.nlink] + [uid9] + [' '] + [gid9] + [' '] + [fs9.size] + [' '] + [fs9.mtime.strftime("%b %e %H:%M")] + [' '] + [ls[8]] #09
l10 = [mode10] + [' '] + [fs10.nlink] + [uid10] + [' '] + [gid10] + [' '] + [fs10.size] + ['  '] + [fs10.mtime.strftime("%b %e %H:%M")] + ['  '] + [ls[9]] #10

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
