#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

class LS
  # ファイルタイプ略語対応
  FILE_TYPE = {
    'file' => '-' ,
    'directory' => 'd',
    'characterSpecial' => 'c',
    'blockSpeclal' => 'b',
    'fifo' => 'p',
    'link' => 'l',
    'socket' => 's',
  }

  # 初期化処理
  def initialize(options)
  end

  # ファイル一覧作成
  def create_file_list_array(options)
    files = if options[:all] == true
              Dir.glob('*', File::FNM_DOTMATCH).sort
            else
              Dir.glob('*').sort
            end

    # ソート順反転処理（-r オプション）
    options[:reverse] == true ? files.reverse! : files
  end


  # ファイル情報取得処理（-l オプションあり）


  # 結果表示処理
  def show_file_list(files)

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
ls = LS.new(options)
files = ls.create_file_list_array(options)
ls.show_file_list(files)
