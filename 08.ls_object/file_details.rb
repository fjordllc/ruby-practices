# frozen_string_literal: true

require 'etc'

class FileDetails
  FILE_TYPE = {
    'fifo' => 'p',
    'characterSpecial' => 'c',
    'directory' => 'd',
    'blockSpecial' => 'b',
    'file' => '-',
    'link' => 'l',
    'socket' => 's'
  }.freeze

  PERMISSION = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }.freeze

  def initialize(file_name)
    @file_name = file_name
    @file_stat = File.stat(file_name)
  end

  def number_of_blocks
    @file_stat.blocks
  end

  def file_type_and_permission
    file_type = @file_stat.ftype.gsub(/fifo|characterSpecial|directory|blockSpecial|file|link|socket/, FILE_TYPE)
    permission = @file_stat.mode.to_s(8).slice(-3, 3).gsub(/[01234567]/, PERMISSION)
    file_type + permission
  end

  def number_of_hard_links
    @file_stat.nlink
  end

  def owner_name
    Etc.getpwuid(@file_stat.uid).name
  end

  def group_name
    Etc.getgrgid(@file_stat.gid).name
  end

  def file_size
    @file_stat.size
  end

  def final_update_time
    @file_stat.mtime.strftime('%-m %d %H:%M')
  end

  def file_name
    File.symlink?(@file_name) ? "#{@file_name} -> #{File.readlink(@file_name)}" : @file_name
  end
end
