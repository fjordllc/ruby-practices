#!/usr/bin/env ruby
# frozen_string_literal: true
require 'etc'

dir_and_file_names = Dir.glob('*')
# ファイルの情報を取得するためのFile::Statクラスのインスタンス生成
file_number = dir_and_file_names.length
puts "total #{file_number}"

FORMAT = "%2s%-6s %2s %8s %8s %7s %7s %-16s \n"
a = Time.now
file_number.times do |n|
  ls_l_stat = File::Stat.new(dir_and_file_names[n])
  ft = ls_l_stat.ftype
    case ft
      when 'file'
        ft.replace '-'
      when 'directory'
        ft.replace 'd'
      when 'link'
        ft.replace 'l'
    end

  m = ls_l_stat.mode.to_s(8) # 8進数に変換
  convert_pamissions = {'0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx','4' => 'r--',
                        '5' => '---', '6' => 'rw-', '7' => 'rwx'}
  converted_pamission = convert_pamissions[m[-3]] + convert_pamissions[m[-2]]
                              + convert_pamissions[m[-1]]

  nl = ls_l_stat.nlink
  u_name = Etc.getpwuid(ls_l_stat.uid).name
  g_name = Etc.getgrgid(ls_l_stat.gid).name
  s = ls_l_stat.size
  mt = if (a.month + 1) > ls_l_stat.mtime.month && (a.month - 1) < ls_l_stat.mtime.month
         ls_l_stat.mtime.strftime('%_m %_d %H:%M')
       else
         ls_l_stat.mtime.strftime('%_m %_d %_5Y')
       end
  file_name = dir_and_file_names[n]
  f = File.basename(file_name)
  printf FORMAT, ft, converted_pamission, nl, u_name, g_name, s, mt, f
end

# ファイルタイプを表すメソッド

# パーミションを表すメソッド
