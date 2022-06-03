#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

# オプション
option = []
opt = OptionParser.new
opt.on('-a') { option << 'a' }
opt.on('-r') { option << 'r' }
opt.on('-l') { option << 'l' }
opt.parse!(ARGV)
dir_name = ARGV[0] || '.'

class String
  def mb_ljust(width, padding = ' ')
    extra_count = !nil? ? each_char.count { |c| c.bytesize > 1 } : 0
    ljust(width - extra_count, padding).to_s
  end
end

# -lオプション
def ocnvert_to_per(str)
  per_str = []
  "0o#{str}".oct.to_s(2).each_char.with_index do |c, i|
    per_str << case i
               when 0
                 c == '1' ? 'r' : '-'
               when 1
                 c == '1' ? 'w' : '-'
               when 2
                 c == '1' ? 'x' : '-'
               end
  end
  per_str.join
end

def l_opt(dir, dir_name)
  stat = File.stat("#{dir_name}/#{dir}")
  f_type = stat.ftype[0] == 'f' ? '-' : stat.ftype[0] # ファイルタイプ
  permission = format('%06d', stat.mode.to_s(8)) # パーミッション
  hard_rink = stat.nlink.to_s # ハードリンクの数
  owner = Etc.getpwuid(stat.uid).name # オーナー名
  group = Etc.getgrgid(stat.gid).name # グループ名
  bytesize = format('%2d', stat.size) # バイトサイズ
  at_update = "#{format('%2d', stat.mtime.month)} #{format('%2d', stat.mtime.day)} #{format('%02d', stat.mtime.hour)}:#{format('%02d', stat.mtime.min)}" # 更新時刻

  per_special = ocnvert_to_per(permission[2])
  per_owner = ocnvert_to_per(permission[3])
  per_group = ocnvert_to_per(permission[4])
  per_other = ocnvert_to_per(permission[5])

  view_per = "#{f_type}#{per_owner}#{per_group}#{per_other}"
  "#{view_per.ljust(8)}#{hard_rink.rjust(4)} #{owner.rjust(7)} #{group.rjust(6)} #{bytesize.rjust(5)} #{at_update}"
end

# デフォルトの出力
def def_ls(files)
  count = (files.size / 3.0).ceil(0)
  count.times do |i|
    3.times do |j|
      result = files[i + j * count]
      next if result.nil?

      print result.mb_ljust(15)
    end
    puts ''
  end
end

# lsコマンド
def ls_cmd(dir_name, option)
  dotmatch = option.include?('a') ? File::FNM_DOTMATCH : 0

  unless Dir.exist?(dir_name)
    puts "#{dir_name}: No such file or directory"
    return
  end

  files = Dir.glob('*', dotmatch, base: dir_name, sort: true)
  files_sort = option.include?('r') ? files.sort.reverse : files

  if option.include?('l')
    files_sort.each do |f|
      puts "#{l_opt(f, dir_name)} #{f}"
    end
    return
  end

  def_ls(files_sort)
end

# 出力
ls_cmd(dir_name, option)
