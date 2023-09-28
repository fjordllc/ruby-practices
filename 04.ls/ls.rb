#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'ls_methods'

def main
  # lsロジックに渡す引数をargsに整理する
  args = { 'option' => nil, 'path' => '.' }
  # 引数を処理
  ARGV.each do |arg|
    if arg.start_with?('-')
      # - 付きの引数の場合
      args['option'] = arg[1..-1] # - を取り除いた文字列を代入
    else
      # 通常の引数の場合
      args['path'] = arg
    end
  end

  contents = get_files_and_directories(args['path'])
  ls_with_options(contents, args['option'])
end

main
