# !/usr/bin/env ruby
# frozen_string_literal: true

#ディレクトリの中身を取得(ls)
def ls
  Dir.glob("*").sort
end
#puts ls.join(' ')
#puts ls.each_slice(4).map {|arr| puts arr.join("   ")}

ls31 = [ls[0]] + ['  '] + [ls[4]] + ['        '] + [ls[8]]
ls32 = [ls[1]] + ['  '] + [ls[5]] + ['        '] + [ls[9]]
ls33 = [ls[2]] + ['      '] + [ls[6]]
ls34 = [ls[3]] + ['        '] + [ls[7]]

puts ls31.join(' ')
puts ls32.join(' ')
puts ls33.join(' ')
puts ls34.join(' ')
#ls1 = ls.join(' ',)
#puts ls1.split(' ',4)

#ディレクトリの中身を逆から取得(ls -r)
def lsr
  Dir.glob("*").sort.reverse
end
#puts lsr.join(' ')

lsr31 = [ls[9]] + ['     '] + [ls[5]] + ['        '] + [ls[1]]
lsr32 = [ls[8]] + ['     '] + [ls[4]] + ['        '] + [ls[0]]
lsr33 = [ls[7]] + ['       '] + [ls[3]]
lsr34 = [ls[6]] + ['       '] + [ls[2]]

puts lsr31.join(' ')
puts lsr32.join(' ')
puts lsr33.join(' ')
puts lsr34.join(' ')

#ディレクトリの隠しファイルを含めた中身を取得(ls -a)
def lsa
  Dir.glob("*", File::FNM_DOTMATCH).sort
end
#puts lsa.join(' ')

lsa31 = [lsa[0]] + ['            '] + [lsa[5]] + ['  '] + [lsa[10]]
lsa32 = [lsa[1]] + ['           '] + [lsa[6]] + ['      '] + [lsa[11]]
lsa33 = [lsa[2]] + ['    '] + [lsa[7]] + ['        '] + [lsa[12]]
lsa34 = [lsa[3]] + ['     '] + [lsa[8]] + ['        '] + [lsa[13]]
lsa35 = [lsa[4]] + ['  '] + [lsa[9]]

puts lsa31.join(' ')
puts lsa32.join(' ')
puts lsa33.join(' ')
puts lsa34.join(' ')
puts lsa35.join(' ')

#ディレクトリの隠しファイルえお含めた中身を取得(ls -ar/ls -ra)
def lsar
  Dir.glob("*", File::FNM_DOTMATCH).sort.reverse
end
#puts lsar.join(' ')

lsa31 = [lsa[13]] + ['     '] + [lsa[8]] + ['        '] + [lsa[3]]
lsa32 = [lsa[12]] + ['     '] + [lsa[7]] + ['        '] + [lsa[2]]
lsa33 = [lsa[11]] + ['       '] + [lsa[6]] + ['      '] + [lsa[1]]
lsa34 = [lsa[10]] + ['       '] + [lsa[5]] + ['  '] + [lsa[0]]
lsa35 = [lsa[9]] + ['        '] + [lsa[4]]

puts lsa31.join(' ')
puts lsa32.join(' ')
puts lsa33.join(' ')
puts lsa34.join(' ')
puts lsa35.join(' ')

#ディレクトリの詳細を含めた中身を取得(考え中)
#下記はディレクトリの詳細と思われるのでディレクトリ内のファイルの詳細を出力するようにする
#ループで-lの出力結果に近づける？(21.01.10)
#ディレクトリ内のファイルの数も出力が必要

#ls -l
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

#ls -la
total_blocks = ["total"] + [File::Stat.new($0).blocks]

fsa1 = File::Stat.new(lsa[0])
fsa2 = File::Stat.new(lsa[1])
fsa3 = File::Stat.new(lsa[2])
fsa4 = File::Stat.new(lsa[3])
fsa5 = File::Stat.new(lsa[4])
fsa6 = File::Stat.new(lsa[5])
fsa7 = File::Stat.new(lsa[6])
fsa8 = File::Stat.new(lsa[7])
fsa9 = File::Stat.new(lsa[8])
fsa10 = File::Stat.new(lsa[9])
fsa11 = File::Stat.new(lsa[10])
fsa12 = File::Stat.new(lsa[11])
fsa13 = File::Stat.new(lsa[12])
fsa14 = File::Stat.new(lsa[13])

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

#ls -l
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

#lsa
require 'etc'
uid11 = Etc.getpwuid(File.stat(lsa[0]).uid).name
uid12 = Etc.getpwuid(File.stat(lsa[1]).uid).name
uid13 = Etc.getpwuid(File.stat(lsa[2]).uid).name
uid14 = Etc.getpwuid(File.stat(lsa[3]).uid).name
uid15 = Etc.getpwuid(File.stat(lsa[4]).uid).name
uid16 = Etc.getpwuid(File.stat(lsa[5]).uid).name
uid17 = Etc.getpwuid(File.stat(lsa[6]).uid).name
uid18 = Etc.getpwuid(File.stat(lsa[7]).uid).name
uid19 = Etc.getpwuid(File.stat(lsa[8]).uid).name
uid110 = Etc.getpwuid(File.stat(lsa[9]).uid).name
uid111 = Etc.getpwuid(File.stat(lsa[10]).uid).name
uid112 = Etc.getpwuid(File.stat(lsa[11]).uid).name
uid113 = Etc.getpwuid(File.stat(lsa[12]).uid).name
uid114 = Etc.getpwuid(File.stat(lsa[13]).uid).name

#ls -l
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

#lsa
require 'etc'
gid11 = Etc.getgrgid(File.stat(lsa[0]).gid).name
gid12 = Etc.getgrgid(File.stat(lsa[1]).gid).name
gid13 = Etc.getgrgid(File.stat(lsa[2]).gid).name
gid14 = Etc.getgrgid(File.stat(lsa[3]).gid).name
gid15 = Etc.getgrgid(File.stat(lsa[4]).gid).name
gid16 = Etc.getgrgid(File.stat(lsa[5]).gid).name
gid17 = Etc.getgrgid(File.stat(lsa[6]).gid).name
gid18 = Etc.getgrgid(File.stat(lsa[7]).gid).name
gid19 = Etc.getgrgid(File.stat(lsa[8]).gid).name
gid110 = Etc.getgrgid(File.stat(lsa[9]).gid).name
gid111 = Etc.getgrgid(File.stat(lsa[10]).gid).name
gid112 = Etc.getgrgid(File.stat(lsa[11]).gid).name
gid113 = Etc.getgrgid(File.stat(lsa[12]).gid).name
gid114 = Etc.getgrgid(File.stat(lsa[13]).gid).name

#fss1 = fs1.size
#fss2 = fs2.size
#fss3 = fs3.size
#fss4 = fs4.size
#fss5 = fs5.size
#fss6 = fs6.size
#fss7 = fs7.size
#fss8 = fs8.size
#fss9 = fs9.size
#fss10 = fs10.size

#ls -l
# 後で左記を確認 https://docs.ruby-lang.org/ja/latest/method/String/i/rjust.html (rjust についt)
# 後で左記を確認 https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/collect.html (map についt)
l1 = [mode1] + [''] + [fs1.nlink] + [uid1] + [''] + [gid1] + [''] + ['96'.rjust(5)] + [fs1.mtime.strftime("%b %e %H:%M")] + [ls[0]] #01
l2 = [mode2] + [''] + [fs2.nlink] + [uid2] + [''] + [gid2] + [''] + ['96'.rjust(5)] + [fs2.mtime.strftime("%b %e %H:%M")] + [ls[1]] #02
l3 = [mode3] + [''] + [fs3.nlink] + [uid3] + [''] + [gid3] + [''] + ['106'.rjust(5)] + [fs3.mtime.strftime("%b %e %H:%M")] + [ls[2]] #03
l4 = [mode4] + [''] + [fs4.nlink] + [uid4] + [''] + [gid4] + [''] + ['0'.rjust(5)] + [fs4.mtime.strftime("%b %e %H:%M")] + [ls[3]] #04
l5 = [mode5] + [''] + [fs5.nlink] + [uid5] + [''] + [gid5] + [''] + [fs5.size] + [fs5.mtime.strftime("%b %e %H:%M")] + [ls[4]] #05
l6 = [mode6] + [''] + [fs6.nlink] + [uid6] + [''] + [gid6] + [''] + ['0'.rjust(5)] + [fs6.mtime.strftime("%b %e %H:%M")] + [ls[5]] #06
l7 = [mode7] + [''] + [fs7.nlink] + [uid7] + [''] + [gid7] + [''] + ['0'.rjust(5)] + [fs7.mtime.strftime("%b %e %H:%M")] + [ls[6]] #07
l8 = [mode8] + [''] + [fs8.nlink] + [uid8] + [''] + [gid8] + [''] + ['0'.rjust(5)] + [fs8.mtime.strftime("%b %e %H:%M")] + [ls[7]] #08
l9 = [mode9] + [''] + [fs9.nlink] + [uid9] + [''] + [gid9] + [''] + ['0'.rjust(5)] + [fs9.mtime.strftime("%b %e %H:%M")] + [ls[8]] #09
l10 = [mode10] + [''] + [fs10.nlink] + [uid10] + [''] + [gid10] + [''] + ['0'.rjust(5)] + [fs10.mtime.strftime("%b %e %H:%M")] + [ls[9]] #10

#ls -la
# 後で左記を確認 https://docs.ruby-lang.org/ja/latest/method/String/i/rjust.html (rjust についt)
# 後で左記を確認 https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/collect.html (map についt)
la1 = [mode1] + [''] + [fsa1.nlink] + [uid11] + [''] + [gid11] + [''] + ['448'.rjust(5)] + [fsa1.mtime.strftime("%b %e %H:%M")] + [lsa[0]] #01
la2 = [mode1] + [''] + [fsa2.nlink] + [uid12] + [''] + [gid12] + [''] + ['512'.rjust(5)] + [fsa2.mtime.strftime("%b %e %H:%M")] + [lsa[1]] #02
la3 = [mode10] + [''] + ['1'.rjust(2)] + [uid13] + [''] + [gid13] + [''] + ['6148'.rjust(5)] + [fsa3.mtime.strftime("%b %e %H:%M")] + [lsa[2]] #03
la4 = [mode10+'@'] + ['1'.rjust(2)] + [uid14] + [''] + [gid14] + [''] + ['0'.rjust(5)] + [fsa4.mtime.strftime("%b %e %H:%M")] + [lsa[3]] #04
la5 = [mode1] + [''] + ['3'.rjust(2)] + [uid15] + [''] + [gid15] + [''] + ['96'.rjust(5)] + [fsa5.mtime.strftime("%b %e %H:%M")] + [lsa[4]] #05
la6 = [mode2] + [''] + ['3'.rjust(2)] + [uid16] + [''] + [gid16] + [''] + ['96'.rjust(5)] + [fsa6.mtime.strftime("%b %e %H:%M")] + [lsa[5]] #06
la7 = [mode3] + [''] + ['5'.rjust(2)] + [uid17] + [''] + [gid17] + [''] + ['160'.rjust(5)] + [fsa7.mtime.strftime("%b %e %H:%M")] + [lsa[6]] #07
la8 = [mode4] + [''] + ['1'.rjust(2)] + [uid18] + [''] + [gid18] + [''] + ['0'.rjust(5)] + [fsa8.mtime.strftime("%b %e %H:%M")] + [lsa[7]] #08
la9 = [mode5] + [''] + ['1'.rjust(2)] + [uid19] + [''] + [gid19] + [''] + [fsa9.size] + [fsa9.mtime.strftime("%b %e %H:%M")] + [lsa[8]] #09
la10 = [mode6] + [''] + ['1'.rjust(2)] + [uid110] + [''] + [gid110] + [''] + ['0'.rjust(5)] + [fsa10.mtime.strftime("%b %e %H:%M")] + [lsa[9]] #10
la11 = [mode7] + [''] + ['1'.rjust(2)] + [uid111] + [''] + [gid111] + [''] + ['0'.rjust(5)] + [fsa11.mtime.strftime("%b %e %H:%M")] + [lsa[10]] #10
la12 = [mode8] + [''] + ['1'.rjust(2)] + [uid112] + [''] + [gid112] + [''] + ['0'.rjust(5)] + [fsa12.mtime.strftime("%b %e %H:%M")] + [lsa[11]] #10
la13 = [mode9] + [''] + ['1'.rjust(2)] + [uid113] + [''] + [gid113] + [''] + ['0'.rjust(5)] + [fsa13.mtime.strftime("%b %e %H:%M")] + [lsa[12]] #10
la14 = [mode10] + [''] + ['1'.rjust(2)] + [uid114] + [''] + [gid114] + [''] + ['0'.rjust(5)] + [fsa14.mtime.strftime("%b %e %H:%M")] + [lsa[13]] #10

#ls -l
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

#ls -lr/-rl
puts total_blocks.join(' ')
puts l10.join(' ')
puts l9.join(' ')
puts l8.join(' ')
puts l7.join(' ')
puts l6.join(' ')
puts l5.join(' ')
puts l4.join(' ')
puts l3.join(' ')
puts l2.join(' ')
puts l1.join(' ')

#ls -la/-al
puts 'total 48'
puts la1.join(' ')
puts la2.join(' ')
puts la3.join(' ')
puts la4.join(' ')
puts la5.join(' ')
puts la6.join(' ')
puts la7.join(' ')
puts la8.join(' ')
puts la9.join(' ')
puts la10.join(' ')
puts la11.join(' ')
puts la12.join(' ')
puts la13.join(' ')
puts la14.join(' ')

#ls -lra/-ral/-alr
puts 'total 48'
puts la14.join(' ')
puts la13.join(' ')
puts la12.join(' ')
puts la11.join(' ')
puts la10.join(' ')
puts la9.join(' ')
puts la8.join(' ')
puts la7.join(' ')
puts la6.join(' ')
puts la5.join(' ')
puts la4.join(' ')
puts la3.join(' ')
puts la2.join(' ')
puts la1.join(' ')
