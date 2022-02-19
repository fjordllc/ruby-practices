#!/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'
require 'optparse'

options = ARGV.getopts('l')

# File::Statデータを保持したインスタンスを生成
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

  # 10桁表示のファイルモードを８進数に変換し、-3桁目から順番に２進数の配列に変換して格納
  def permission_converter_d_to_b(file)
    file_mode_ary = [] # パーミッション文字列を分割して格納する配列
    3.times do |i|
      file_mode_ary << file.mode.to_s(8)[i - 3].to_i.to_s(2).chars
    end
    file_mode_ary.flatten
  end

  # ２進数のパーミッションをrwxに変換
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
    # binding.break
    if file.mode.to_s(8)[-4] == '1'
      permissions += 't' if permissions[8] == 'x'
      permissions += 'T' if permissions[8] == '-'
    else
      permissions += ' '
    end
    permissions
  end

  # SUID/SGIDの設定
  def suid_sgid(file, permissions)
    case file.mode.to_s(8)[-4]
    when '2'
      permissions[6] = 't' if permissions[6] == 'x'
      permissions[6] = 'T' if permissions[6] == '-'
    when '4'
      permissions[3] = 's' if permissions[3] == 'x'
      permissions[3] = 'S' if permissions[3] == '-'
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
# class FileData定義ここまで

names_original = Dir.glob('*')

if options['l'] # `-l`オプション指定の場合
  files = []
  names_original.each do |filename|
    filedata = File.lstat(filename)
    files << FileData.new(filedata) # ファイルデータ(File:Statクラス)ごとにインスタンスを生成し配列に追加
  end

  # 揃えが必要な文字列のスペース算出
  nlink_space = Array.new(files.size) { |i| files[i].nlink.size }.max + 1
  uid_space = Array.new(files.size) { |i| files[i].uid.size }.max + 1
  gid_space = Array.new(files.size) { |i| files[i].gid.size }.max + 2
  size_space = Array.new(files.size) { |i| files[i].size.size }.max + 2

  # 割り当てブロック数合計、コマンド1行目出力
  puts "total #{files.map(&:blocks).sum}"

  # 各行の文字列を出力、改行
  files.size.times do |i|
    print files[i].type
    print files[i].mode
    printf("%#{nlink_space}s", files[i].nlink)
    printf("%#{uid_space}s", files[i].uid)
    printf("%#{gid_space}s", files[i].gid)
    printf("%#{size_space}s", files[i].size)
    print " #{files[i].mtime}"
    print " #{names_original[i]}\n"
  end
else # `-l`オプション指定がない場合
  display_columns = 3.0 # 表示列数。count_linesメソッドで.ceilメソッドを使うため、Floadクラスにて記述
  # メインのメソッド
  def print_ls(names_original, display_columns)
    names_tabbed = tabbing_names(names_original) # タブ揃えされたされた文字列の配列
    display_lines = count_lines(names_tabbed, display_columns) # 表示行数
    names_vertical = [] # 空配列の中に行数分の空配列を追加（入れ子構造）
    display_lines.times do
      names_vertical << []
    end
    names_tabbed.each_with_index do |file, i| # 空配列に順番に値を追加、を繰り返す。
      names_vertical[i % display_lines] << file.to_s
    end
    puts names_vertical.map(&:join).join("\n") # 出力
  end

  # 取得したファイル名にタブを追加して長さを揃える
  def tabbing_names(names_original)
    tab_space = names_original.map(&:size).max / 8 + 1
    names_original.map do |w|
      w + "\t" * (tab_space - w.size / 8)
    end
  end

  # 取得した配列の要素数から表示行数を算出
  def count_lines(names_tabbed, display_columns)
    (names_tabbed.size / display_columns).ceil
  end

  print_ls(names_original, display_columns)
end
