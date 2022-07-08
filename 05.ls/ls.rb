# frozen_string_literal: true
require "etc"
require 'optparse'

class LS
  def initialize
    opt = OptionParser.new
    @option = {}

    opt.on('-a') { |v| @option[:a] = v }
    opt.on('-r') { |v| @option[:r] = v }
    opt.on('-l') { |v| @option[:l] = v }
    opt.parse!(ARGV)
  end

  def exec
    files = Dir.glob('*', @option[:a] ? File::FNM_DOTMATCH : 0)
    files.reverse! if @option[:r]
    files.map{ |file| print_file_detail(file) } if @option[:l]
    files
  end

  def print_files
    files = exec
    # # カラムを変更する変数
    # columns = 3
    # number_of_rows = (files.length % columns).zero? ? files.length / columns : files.length / columns + 1
    # tab_files = files.each_slice(number_of_rows).to_a
    # number_of_rows.times do |i|
    #   lines = tab_files.map { |file| file[i]&.slice(0, 15)&.ljust(20) unless file[i].nil? }.compact
    #   puts lines.join('')
    # end
  end

  def get_permission_code permission
    permission_code= ['---','--x','-w-','-wx','r--','r-x','rw-','rwx']
    return permission_code[permission]
  end

  def handling_type_of_file file
    case file
    when '10'
      permission_str = 'p' 
    when '20'
      permission_str = 'c'
    when '40'
      permission_str = 'd'
    when '60'
      permission_str = 'b'
    when '100'
      permission_str = '-'
    when '120'
      permission_str = 'l'
    when '140'
      permission_str = 's'
    end
  end

  def print_file_permissions file
    file_stat = File.lstat(file).mode.to_s(8)
    permission_number = file_stat[-3..-1]
    type_of_file = handling_type_of_file(file_stat.tr(permission_number, ''))
    permission_code = permission_number.chars.map{ |c|
      get_permission_code(c.to_i)
    }.join('')
    full_permission = type_of_file + permission_code
  end

  def print_file_detail file
    str = "%s  %s  %s  %s  %s  %s  %s"
    file_detail = [print_file_permissions(file),
    File.lstat(file).nlink.to_s, user_name(File.lstat(file).uid),
    group_name(File.lstat(file).gid),
    File.lstat(file).size.to_s,
    format_created_time(File.lstat(file).mtime),
    file]
    p str % file_detail
  end

  def user_name(uid)
    Etc.getpwuid(uid).name
  end

  def group_name(gid)
    Etc.getgrgid(gid).name
  end

  def format_created_time created_time
    created_time.strftime('%m月 %d %H:%M').to_s
  end
end

LS.new.print_files
