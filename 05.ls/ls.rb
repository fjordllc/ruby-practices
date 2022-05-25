# frozen_string_literal: true

# !/usr/bin/envruby

MAX_CLUMN = 3
require 'optparse'
require 'etc'

params = ARGV.getopts('l')
dirs = Dir.glob('*')

if params['l']
  file_type = { 'fifo' => 'p',
                'characterSpecial' => 'c',
                'directory' => 'd',
                'blockSpecial' => 'b',
                'file' => '-',
                'link' => 'l',
                'socket' => 's' }

  access_permission = { 0 => '---',
                        1 => '--x',
                        2 => '-w-',
                        3 => '-wx',
                        4 => 'r--',
                        5 => 'r-x',
                        6 => 'rw-',
                        7 => 'rwx' }

  total_blocks = 0
  dirs.each do |dir|
    fs = File.stat(dir)
    total_blocks += fs.blocks
  end
  puts "total #{total_blocks}"

  dirs.each do |dir|
    fs = File::Stat.new(dir)
    link = fs.nlink.to_s
    user_id = Process.uid
    user_name = Etc.getpwuid(user_id).name
    group_id = Process.gid
    group_name = Etc.getgrgid(group_id).name
    byte = fs.size.to_s
    files = fs.mode.digits(8).take(3).reverse
    print (file_type[fs.ftype]).to_s +
          access_permission[files[0]] +
          access_permission[files[1]] +
          access_permission[files[2]]
    puts "#{link.rjust(2)} #{user_name} #{group_name} #{byte.rjust(4)}  #{fs.mtime.strftime('%_m %e %H:%M')} #{dir}"
  end
else
  MAXIMUM_FILE = dirs.length.to_f
  row = (MAXIMUM_FILE / MAX_CLUMN).ceil
  if (MAX_CLUMN % MAXIMUM_FILE) != 0
    ((MAX_CLUMN * row) - MAXIMUM_FILE).to_i.times do
      dirs.push(nil)
    end
  end

  def show_directories(dirs, row)
    file_list = dirs.each_slice(row).to_a
    longest_name = dirs.compact.max_by(&:size)
    padding = 15
    files = file_list.transpose
    files.each do |list|
      list.each do |file|
        print file.to_s.ljust(longest_name.length + padding)
      end
      print "\n"
    end
  end
  show_directories(dirs, row)
end
