#!/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'
require 'optparse'

options = ARGV.getopts('l')

# (lオプション)File::Statデータを保持したインスタンスを生成
class FileData
  attr_reader :blocks, :type, :mode, :nlink, :uid, :gid, :size, :mtime

  def initialize(file)
    @blocks = file.blocks # 割当てブロック数、一行目に表示
    @type = file_type(file)
    @mode = file_mode(file)
    @nlink = file_nlink(file)
    @uid = file_uid(file)
    @gid = file_gid(file)
    @size = file_size(file)
    @mtime = file_mtime(file)
  end

  # ファイルタイプ
  def file_type(file)
    { 'directory' => 'd',
      'file' => '-',
      'link' => 'l',
      'fifo' => 'p',
      'characterSpecial' => 'c',
      'blockSpecial' => 'b',
      'socket' => 's' }[file.ftype]
  end

  # パーミッション文字列を生成
  def file_mode(file)
    file_mode_ary = permission_converter_d_to_b(file)
    permissions = permission_converter_b_to_rwx(file_mode_ary)
    permissions = stickeybit(file, permissions)
    suid_sgid(file, permissions)
  end

  # 10桁表示のファイルモード(integer)を８進数に変換し、-3桁目から順番に２進数の配列に変換して格納
  def permission_converter_d_to_b(file)
    file_mode_ary = [] # パーミッション文字列を分割して格納する配列
    3.times do |i|
      file_mode_ary << file.mode.to_s(8)[i - 3].to_i.to_s(2).chars
    end
    file_mode_ary.flatten
  end

  # ２進数のパーミッション(配列)をrwx(文字列)に変換
  def permission_converter_b_to_rwx(file_mode_ary)
    permissions_full = %w[r w x r w x r w x]
    permissions = '' # 出力用の文字列を格納する変数
    9.times do |i|
      permissions += file_mode_ary[i] == '1' ? permissions_full[i] : '-'
    end
    permissions
  end

  # スティッキービットの設定
  def stickeybit(file, permissions)
    permissions +=
      if file.mode.to_s(8)[-4] == '1'
        permissions[8] == '-' ? 'T' : 't'
      else
        ' '
      end
    permissions
  end

  # SUID/SGIDの設定
  def suid_sgid(file, permissions)
    case file.mode.to_s(8)[-4]
    when '2'
      permissions[6] = permissions[6] == '-' ? 'S' : 's'
    when '4'
      permissions[3] = permissions[3] == '-' ? 'S' : 's'
    end
    permissions
  end

  # ハードリンク数
  def file_nlink(file)
    file.nlink.to_s
  end

  # オーナー名
  def file_uid(file)
    user = Etc.getpwuid(file.uid).name
    user.to_s
  end

  # グループ名
  def file_gid(file)
    group = Etc.getgrgid(file.gid).name
    group.to_s
  end

  # ファイルサイズ
  def file_size(file)
    file.size.to_s
  end

  # タイムスタンプ (タイムスタンプが半年(推定)以上前のものは時刻が年に変わる)
  def file_mtime(file)
    time = file.mtime
    Time.new - time < 60 * 60 * 24 * 180 ? time.strftime('%b %e %H:%M') : time.strftime('%b %d  %Y')
  end
end
# class FileData定義終了

# FileDataクラスを出力を設定したクラス
class PrintFileData
  def initialize(names_original)
    @names_original = names_original
    @files = @names_original.map { |filename| FileData.new(File.lstat(filename)) }
    @nlink_space = @files.map { |file| file.nlink.size }.max + 1
    @uid_space = @files.map { |file| file.uid.size }.max + 1
    @gid_space = @files.map { |file| file.gid.size }.max + 2
    @size_space = @files.map { |file| file.size.size }.max + 2
  end

  # 出力する行の文字列を生成
  def print_line(files, names_original)
    files.size.times do |i|
      printf("#{files[i].type}#{files[i].mode}%#{@nlink_space}s%#{@uid_space}s%#{@gid_space}s%#{@size_space}s",
             files[i].nlink, files[i].uid, files[i].gid, files[i].size)
      print " #{files[i].mtime} #{names_original[i]}\n"
    end
  end

  # 文字列を出力
  def print_ls_l
    puts "total #{@files.map(&:blocks).sum}" # 割り当てブロック数合計、コマンド1行目出力
    print_line(@files, @names_original) # 各行の文字列を出力、改行
  end
end
# class PrintFileData定義終了

# (オプションなし)出力用メソッド
def print_ls_no_option(names_original, display_columns)
  names_tabbed = tabbing_names(names_original) # タブ揃えされたされた文字列の配列
  display_lines = count_lines(names_tabbed, display_columns) # 表示行数
  names_vertical = [] # 空配列の中に行数分の空配列を追加（入れ子構造）
  display_lines.times { names_vertical << [] }
  names_tabbed.each_with_index do |file, i| # 空配列に順番に値を追加、を繰り返す。
    names_vertical[i % display_lines] << file
  end
  puts names_vertical.map(&:join).join("\n") # 出力
end

# (オプションなし)取得したファイル名にタブを追加して長さを揃える
def tabbing_names(names_original)
  tab_space = names_original.map(&:size).max / 8 + 1
  names_original.map do |w|
    w + "\t" * (tab_space - w.size / 8)
  end
end

# (オプションなし)取得した配列の要素数から表示行数を算出
def count_lines(names_tabbed, display_columns)
  (names_tabbed.size / display_columns).ceil
end

# 実行
names_original = Dir.glob('*')

if options['l'] # `-l`オプション指定の場合
  PrintFileData.new(names_original).print_ls_l
else # オプション指定がない場合
  display_columns = 3.0 # 表示列数。count_linesメソッドで.ceilメソッドを使うため、Floadクラスにて記述
  print_ls_no_option(names_original, display_columns)
end
