#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

# オプション設定
opt = OptionParser.new
options = {}
opt.on('-a') { |v| options[:all] = v }
opt.on('-l') { |v| options[:list] = v }
opt.on('-r') { |v| options[:reverse] = v }

# 引数リストARGVをパースして各オプションブロックを実行
opt.parse! { ARGV }

def show_file_list(options)
  # -a オプション有無による処理分岐
  items = if options.key?(:all)
            Dir.glob('*', File::FNM_DOTMATCH).sort.map { |item| item.to_s.ljust(16) }
          else
            Dir.glob('*').sort.map { |item| item.to_s.ljust(16) }
          end

  # -r オプションによる逆順ソート処理
  if options.key?(:reverse)
    items.reverse!
  end


  # １行内の出力件数
  line_size = 3

  # 出力する行数を取得（出力件数で割って余りが出た場合は１行追加）
  line_cnt = (items.size % line_size).zero? ? items.size / line_size : items.size / line_size + 1
  items_line_array = Array.new(line_cnt) { [] }

  cnt = 0
  items.each do |item|
    items_line_array[cnt] << item
    cnt += 1

    cnt = 0 if cnt == items_line_array.size
  end

  items_line_array.each { |line| puts line.join('') }
end


# # -lの場合(ファイル詳細情報付き)
def show_file_list_with_detail_info
  p "show_file_list_with_detail_info"
end


show_file_list(options)
