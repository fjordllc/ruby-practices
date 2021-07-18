#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

# オプション設定
opt = OptionParser.new
options = {}
opt.on('-a'){|v| options[:all] = v}
opt.on('-l'){|v| options[:list] = v}
opt.on('-r'){|v| options[:reverse] = v}

# 引数リストARGVをパースして各オプションブロックを実行
opt.parse!{ARGV}

# オプションなし
def show_file_list_of_default
  items = Dir.glob("*").sort.map{|item| "#{item}".ljust(16)}

  
end

# -aの場合(すべてのファイル)
def show_file_list_of_all
  p "show_file_list_of_all"
end

# -lの場合(ファイル詳細情報付き)
def show_file_list_with_detail_info
  p "show_file_list_with_detail_info"
end

# -rの場合(ソート逆順)
def change_sort_reverse
  p "change_sort_reverse"
end

show_file_list_of_default
