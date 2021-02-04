# frozen_string_literal: true

require 'date'

class FileData
  attr_reader :target, :file, :fs, :type, :mode, :nlink, :uid, :gid, :size, :updated_at, :blocks

  def initialize(target, file)
    @target = target
    @file = file
    @fs = File.lstat("#{target}/#{file}")
    @type = fs.ftype
    @mode = fs.mode
    @nlink = fs.nlink.to_s
    @uid = Etc.getpwuid(fs.uid).name
    @gid = Etc.getgrgid(fs.gid).name
    @size = fs.size.to_s
    @updated_at = fs.mtime
    @blocks = fs.blocks
  end

  def date
    if updated_at.strftime('%Y-%m-%d') <= Date.today.prev_month(6).strftime('%Y-%m-%d')
      updated_at.strftime('%_m %_d  %Y')
    else
      updated_at.strftime('%_m %_d %H:%M')
    end
  end

  def filetype_permission
    filetype + permission
  end

  def filetype
    filetype_converting_code = {
      'file' => '-',
      'directory' => 'd',
      'link' => 'l'
    }
    filetype_converting_code[type]
  end

  def permission
    permission_converting_code = {
      0 => '---',
      1 => '--x',
      2 => '-w-',
      3 => '-wx',
      4 => 'r--',
      5 => 'r-x',
      6 => 'rw-',
      7 => 'rwx'
    }

    owner, group, user = mode.to_s(8)[-3, 3].chars.map(&:to_i)
    permission_converting_code[owner] + permission_converting_code[group] + permission_converting_code[user]
  end

  def name_or_symlink
    if type == 'link'
      "#{file} -> #{File.readlink("#{target}/#{file}")}"
    else
      file
    end
  end
end
