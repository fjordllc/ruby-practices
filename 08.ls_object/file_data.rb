# frozen_string_literal: true

require 'etc'

module Ls
  class FileData
    OCT_TO_RWX = {
      '0' => '---',
      '1' => '--x',
      '2' => '-w-',
      '3' => '-wx',
      '4' => 'r--',
      '5' => 'r-x',
      '6' => 'rw-',
      '7' => 'rwx'
    }.freeze

    def initialize(file)
      @file = file
    end

    def ftype
      stat = File::Stat.new(@file)
      case stat.ftype
      when 'directory'
        print 'd'
      when 'link'
        print 'l'
      when 'file'
        print '-'
      end
    end

    def permission
      permission = File.lstat(@file).mode.to_s(8)[-3..]
      change_permission_style(permission).join
    end

    def change_permission_style(permission)
      permission.each_char.map do |digit|
        OCT_TO_RWX.fetch(digit)
      end
    end

    def nlink
      File.lstat(@file).nlink
    end

    def user_name
      Etc.getpwuid(File.lstat(@file).uid).name
    end

    def group_name
      Etc.getgrgid(File.lstat(@file).gid).name
    end

    def size
      File.lstat(@file).size
    end

    def mtime
      File.lstat(@file).mtime.strftime('%a %e %H:%M').to_s
    end

    def name
      @file.to_s
    end
  end
end
