# frozen_string_literal: true
require 'etc'
require 'optparse'
ROW_NUM = 3
ROW_MAX_WIDTH = 24

require_relative 'file'
require_relative 'stat'
require_relative 'display'

def main
  params = ARGV.getopts('alr')
  all_files = get_all_files(params).map { |file| File.new(file) }
  stats = all_files.map{|file| Stat.new(file.instance_variable_get(:@file))} if params['l']
 
  if params['l']
    display = Display.new(stats)
  else
    display = Display.new(all_files)
  end
  display.l_option
end

def get_all_files(params)
  files = params['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
  files = files.reverse if params['r']
  files
end

main