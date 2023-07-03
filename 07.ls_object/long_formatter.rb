# frozen_string_literal: true

require 'etc'

class LongFormatter
  attr_reader :file_name, :file_stat

  def initialize(file_name)
    @file_name = file_name
    @file_stat = File.stat(file_name)
  end

  def file_type
    ftype_key = File.ftype(file_name)
    types = { 'file' => '-', 'directory' => 'd', 'link' => 'l' }
    types[ftype_key]
  end

  def permissions
    permission_numbers = file_stat.mode.to_s(8).slice(-3, 3).chars
    permission_table = { '0' => '---', '1' => '--X', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }
    permission_numbers.map { |num| permission_table[num] }.join
  end

  def nlink
    file_stat.nlink.to_s.rjust(3)
  end

  def owner
    Etc.getpwuid(file_stat.uid).name
  end

  def group
    Etc.getgrgid(file_stat.gid).name
  end

  def size
    file_stat.size.to_s.rjust(6)
  end

  def mtime
    file_stat.mtime.strftime('%m %e %H:%M')
  end

  def format
    "#{file_type}#{permissions}#{nlink} #{owner}  #{group}#{size} #{mtime} #{file_name}"
  end
end
