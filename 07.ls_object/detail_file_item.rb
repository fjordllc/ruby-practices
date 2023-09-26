# frozen_string_literal: true

require './file_item'
require 'etc'

class FileDetailItem < FileItem
  attr_reader :stat, :type, :permissions, :hard_link, :owner, :group, :size, :last_modified_time

  PERMISSION_MAP = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }.freeze

  def initialize(filename)
    super(filename)
    @stat = File.stat(filename)
    @type = file_type(filename)
    @permissions = format_permissions(stat.mode)
    @hard_link = stat.nlink
    @owner = Etc.getpwuid(stat.uid).name
    @group = Etc.getgrgid(stat.gid).name
    @size = stat.size
    @last_modified_time = stat.mtime.strftime('%b %d %H:%M')
  end

  private

  def file_type(filename)
    return 'd' if File.directory?(filename)
    return 'l' if File.symlink?(filename)
    return 'c' if File.chardev?(filename)
    return 'b' if File.blockdev?(filename)
    return 'p' if File.pipe?(filename)
    return 's' if File.socket?(filename)
    return '-' if File.file?(filename)
  end

  def format_permissions(mode)
    perm = mode.to_s(8)[-3..]
    perm.chars.map { |char| PERMISSION_MAP[char] }.join('')
  end
end
