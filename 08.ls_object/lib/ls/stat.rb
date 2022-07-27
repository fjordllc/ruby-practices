# frozen_string_literal: true

require 'etc'

module Ls
  class Stat
    attr_reader :blocks

    def initialize(path)
      @stat = File.stat(path)
      @body = {
        type: format_type(@stat),
        permission: format_permission(@stat),
        nlink: @stat.nlink,
        user: Etc.getpwuid(@stat.uid).name,
        group: Etc.getgrgid(@stat.gid).name,
        size: @stat.size,
        mtime: @stat.mtime.strftime('%_m %_d %R'),
        basename: File.basename(path)
      }
      @blocks = @stat.blocks
    end

    def body
      format([
        '%<type>s%<permission>s',
        '%<nlink>2i',
        '%<user>-2s',
        '%<group>-2s',
        '%<size>4s',
        '%<mtime>4s',
        "%<basename>s\n"
      ].join(' '), @body)
    end

    private

    def format_type(stat)
      stat.directory? ? 'd' : '-'
    end

    def format_permission(stat)
      format('0%o', stat.mode)[-3, 3].chars.map { permission(_1) }.join
    end

    def permission(mode)
      {
        '7' => 'rwx',
        '6' => 'rw-',
        '5' => 'r-x',
        '4' => 'r--',
        '3' => '-wx',
        '2' => '-w-',
        '1' => '--x',
        '0' => '---'
      }[mode]
    end
  end
end
