#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/lib_wc'
require 'optparse'
require 'pathname'

def main
  params = {}
  opt = OptionParser.new

  opt.on('-c') { |v| params[:bytes] = v }
  opt.on('-l') { |v| params[:lines] = v }
  opt.on('-w') { |v| params[:words] = v }
  opt.parse!(ARGV)

  file_paths = ARGV.empty? ? fetch_file_paths : ARGV
  # if ARGV.empty?

  # else
  #   file_paths = ARGV # パイプを使ったときにどのようにfile_pathsにファイルの配列を渡すか
  # end
  puts run_wc(file_paths, params)
end

def fetch_file_paths
  file_names = []
  ARGF.each do |line|
    file_names << line.chomp.split.last if line.include? '.txt'
  end
  file_names
end

main
