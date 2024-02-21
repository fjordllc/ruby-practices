# frozen_string_literal: true
require 'etc'

def format_mode(mode)
  types = { '10': '-', '04': 'd', '12': 'l', '02': 'c', '06': 'b', '01': 'p', '14': 's' }
  perms = { '0': '---', '1': '--x', '2': '-w-', '3': '-wx', '4': 'r--', '5': 'r-x', '6': 'rw-', '7': 'rwx' }
  type_code = mode[0..1]
  type = types[type_code.to_sym] || '-'
  usr, grp, oth = mode[3..5].chars.map { |c| perms[c.to_sym] }
  "#{type}#{usr}#{grp}#{oth}"
end

def format_file_stat(file)
  stat = File::Stat.new(file)
  mode = format_mode(stat.mode.to_s(8))
  link_count = stat.nlink
  owner_name = Etc.getpwuid(stat.uid).name
  group_name = Etc.getgrgid(stat.gid).name
  size = stat.size
  mtime = stat.mtime.strftime('%-m %e %H:%M')
  "#{mode} #{link_count} #{owner_name} #{group_name.rjust(5)} #{size.to_s.rjust(4)} #{mtime} #{file}"
end

def list_directory
  file_names = Dir.glob('*')
  file_names.each do |file|
    puts format_file_stat(file)
  end
end

list_directory
