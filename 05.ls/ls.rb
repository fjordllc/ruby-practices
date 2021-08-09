#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

def main
  opt = OptionParser.new
  options = { all: false, list: false, reverse: false }

  opt.on('-a') { |v| options[:all] = v }
  opt.on('-l') { |v| options[:list] = v }
  opt.on('-r') { |v| options[:reverse] = v }

  opt.parse! { ARGV }
  Ls.start_process(options)
end

class Ls
  FILE_TYPE = {
    'file' => '-',
    'directory' => 'd',
    'characterSpec  ial' => 'c',
    'blockSpeclal' => 'b',
    'fifo' => 'p',
    'link' => 'l',
    'socket' => 's'
  }.freeze

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

  def self.start_process(options)
    ls = Ls.new
    ls.make_file_list(options)
  end

  def make_file_list(options)
    sorted_files = create_file_list_array(options)
    options[:list] ? show_detail(sorted_files) : show_file_list(sorted_files)
  end

  private

  def create_file_list_array(options)
    files = if options[:all]
              Dir.glob('*', File::FNM_DOTMATCH)
            else
              Dir.glob('*')
            end
    options[:reverse] ? files.sort.reverse : files.sort
  end

  ON_LINE_ITEMS = 3

  def show_file_list(files)
    line_cnt = (files.size / ON_LINE_ITEMS.to_f).ceil
    lines = Array.new(line_cnt) { [] }
    index = 0

    files.each do |file|
      lines[index] << file
      index += 1
      index = 0 if index == line_cnt
    end

    longest_word_length = files.max_by(&:length).length
    lines.each do |line|
      puts line.map { |item| item.ljust(longest_word_length) }.join('   ')
    end
  end

  def show_detail(files)
    total_block_size, file_list = to_detailed_info(files)
    puts "total #{total_block_size}"
    file_list.each do |file|
      puts file
    end
  end

  def to_detailed_info(files)
    total_block_size = 0
    detailed = files.map do |file_name|
      total_block_size += File.stat(file_name).blocks
      filetype = FILE_TYPE[File.ftype(file_name)]
      stat = File::Stat.new(file_name)
      permissions = format_permissions(stat)
      hardlinks = stat.nlink.to_s.rjust(2)
      owner_name = Etc.getpwuid(stat.uid).name
      group_name = Etc.getgrgid(stat.gid).name
      file_size = stat.size.to_s.rjust(4)
      last_modified = stat.mtime.strftime('%m %d %R')[1..10]
      "#{filetype}#{permissions}  #{hardlinks} #{owner_name}  #{group_name}  #{file_size}  #{last_modified} #{file_name}"
    end
    [total_block_size, detailed]
  end

  def format_permissions(stat)
    permission_label = ''
    octal_mode = stat.mode.to_s(8)

    octal_mode.slice(-3, 3).scan(/./).each do |number|
      permission_label += PERMISSION_PATTERN[number]
    end
    permission_label
  end
end

main
