#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

class Ls
  # ファイルタイプリスト
  FILE_TYPE = {
    'file' => '-',
    'directory' => 'd',
    'characterSpec  ial' => 'c',
    'blockSpeclal' => 'b',
    'fifo' => 'p',
    'link' => 'l',
    'socket' => 's'
  }.freeze

  # 権限表記対応リスト
  PERMISSION_PATTERN = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }.freeze

  # ファイル一覧作成
  def create_file_list_array(options)
    files = if options[:all] == true
              Dir.glob('*', File::FNM_DOTMATCH).sort
            else
              Dir.glob('*').sort
            end

    # ソート順反転処理（-r オプション）
    options[:reverse] == true ? files.reverse! : files

    # ファイル情報取得処理（-l オプション）
    options[:list] == true ? change_array_to_add_detail_info(files) : files
  end

  # パーミッション変換処理（8進数表記の権限を文字列表記に変換）
  def change_permissions_visible_format(permissions)
    owner_permission_number = permissions.slice(-3, 1)
    group_permission_number = permissions.slice(-2, 1)
    others_permission_number = permissions.slice(-1, 1)

    owner_permission_labels = PERMISSION_PATTERN[owner_permission_number]
    group_permission_labels = PERMISSION_PATTERN[group_permission_number]
    others_permission_labels = PERMISSION_PATTERN[others_permission_number]

    permission_labels = owner_permission_labels + group_permission_labels + others_permission_labels
  end

  # ファイル情報取得処理（-l オプションあり）
  def change_array_to_add_detail_info(files)
    files_with_detail_info = []
    files.each do |file|
      filetype = FILE_TYPE[File.ftype(file)]
      item = File::Stat.new(file)
      # modeの返り値を8進数文字列に変換後、6桁に揃えて表記変換処理を実行
      permissions = change_permissions_visible_format(item.mode.to_s(8).rjust(6, '0'))
      hardlinks = item.nlink.to_s.rjust(2)
      owner_name = Etc.getpwuid(item.uid).name
      group_name = Etc.getgrgid(item.gid).name
      file_size = item.size.to_s.rjust(4)
      last_modified = item.mtime.strftime('%m %d %R')
      file_name = file
      item_line = "#{filetype}#{permissions}  #{hardlinks} #{owner_name}  #{group_name}  #{file_size} #{last_modified} #{file_name}"
      files_with_detail_info << item_line
    end
    files_with_detail_info
  end

  # 結果表示処理
  def show_file_list(files, options)

    if options[:list] == true
      files.each do |file|
        puts file
      end
    else
      # 一行の列数を指定
      on_line_items = 3

      line_cnt = (files.size % on_line_items).zero? ? files.size / on_line_items : files.size / on_line_items + 1
      lines = Array.new(line_cnt){ [] }

      index = 0
      longest_word_length = 0
      files.each do |file|
        longest_word_length = file.length if file.length > longest_word_length

        lines[index] << file
        index += 1
        index = 0 if index == line_cnt
      end

      lines.each do |line|
        puts line.map{ |item| item.ljust(longest_word_length) }.join('   ')
      end
    end
  end
end

# main ------------------------------------------------------------------------
# オプション引数取得
opt = OptionParser.new
options = {:all => false, :list => false, :reverse => false}

# 単一指定
opt.on('-a') { |v| options[:all] = v }
opt.on('-l') { |v| options[:list] = v }
opt.on('-r') { |v| options[:reverse] = v}

# 混合指定
# [note] 指定外のオプションが指定された場合の終了処理が必要
ARGV.each do |arg|
  if options[:all] == false
    options[:all] = arg.include? 'a'
  end

  if options[:list] == false
    options[:list] = arg.include? 'l'
  end

  if options[:reverse] == false
    options[:reverse] = arg.include? 'r'
  end
end

# 引数リストをparseにｓて各オプションのブロックを実行
opt.parse! { ARGV }

# start
ls = Ls.new
files = ls.create_file_list_array(options)
ls.show_file_list(files,options)
