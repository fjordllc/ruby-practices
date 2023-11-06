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

  file_names = ARGV.empty? ? fetch_file_names : ARGV
  puts run_wc(file_names, params)
end

def fetch_file_names
  file_names = []
  ARGF.each do |line|
    # lsのlオプションの有無に関わらずファイル名のみを取得出来るように加工する
    file_names << line.chomp.split.last if line.include? '.txt'
  end
  file_names
end

main
