# frozen_string_literal: true

require 'etc'
require 'kconv'
require './stmode'

# modification of class File::Stat
class MyStat < File::Stat
  include StMode

  attr_accessor :path

  def initialize(path)
    super(path)
    @path = path
  end

  def my_print
    str = format('%<mode>-11s %<nlink>3d %<uid>-7s %<gid>-7s %<size>10d %<mon>2d %<day>2d %<hour>2d:%<min>2d',
                 mode: strmode(mode), nlink: nlink, uid: Etc.getpwuid(uid).name, gid: Etc.getgrgid(gid).name,
                 size: size, mon: mtime.mon, day: mtime.mday, hour: mtime.hour, min: mtime.min)
    str.concat format(' %-15s'.toeuc.force_encoding('binary'), File.basename(path).toeuc.force_encoding('binary'))
      .toutf8
    puts str
  end
end
