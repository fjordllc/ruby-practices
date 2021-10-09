# frozen_string_literal: true

require 'date'
require 'etc'

class FileAnalyser
  MODE_TABLE = {
    '0' => '---',
    '1' => '-x-',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }.freeze

  def initialize(files)
    @files = files
  end

  def analyse
    @files.map do |file|
      stat = File.lstat(file)
      build_data(file, stat)
    end
  end

  private

  def build_data(file, stat)
    {
      type_and_mode: "#{fetch_file_type(stat)}#{to_symbolic_notation(stat.mode)}",
      nlink: stat.nlink.to_s,
      user: Etc.getpwuid(stat.uid).name,
      group: Etc.getgrgid(stat.gid).name,
      size: stat.size.to_s,
      mtime: to_long_format_date(stat.mtime),
      name: stat.symlink? ? "#{file} -> #{File.readlink(file)}" : file,
      blocks: stat.blocks
    }
  end

  def fetch_file_type(stat)
    if stat.directory?
      'd'
    elsif stat.symlink?
      'l'
    else
      '-'
    end
  end

  def to_symbolic_notation(mode)
    octal = mode.to_s(8)[-3, 3]

    octal.each_char.map do |str|
      MODE_TABLE[str]
    end.join
  end

  # Convert the last modified time to a string conforming to mac's ls
  def to_long_format_date(time)
    now_date = Date.today
    last_update_date = time.to_date
    diff_month = now_date.year * 12 + now_date.month - last_update_date.year * 12 - last_update_date.month

    year_or_time = diff_month >= 6 ? " #{time.strftime('%-Y')}" : time.strftime('%R')
    time.strftime("%-m %e #{year_or_time}")
  end
end
