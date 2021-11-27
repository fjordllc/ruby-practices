# frozen_string_literal: true

require 'optparse'
require 'etc'

def l_option?
  option = ARGV.getopts('l')
  option['l']
end

def calc_file_count_per_column(files, column_count)
  (files.size / column_count).ceil
end

def build_display_column
  column_count = 3.0
  current_directory_files = Dir.glob('*')

  p current_directory_files

  file_count_per_column = calc_file_count_per_column(current_directory_files, column_count)
  divided_files = current_directory_files.each_slice(file_count_per_column).to_a

  adjusted_file_list = []
  divided_files.each do |column|
    max_str_count = column.max_by(&:size).size
    adjusted_file_list << column.map { |v| v.ljust(max_str_count + 2) }
  end

  last_column = adjusted_file_list.last
  (file_count_per_column - last_column.size).times { last_column << '' }

  adjusted_file_list.transpose
end

def display_files
  build_display_column.each do |list|
    list.each do |value|
      suffix = "\n"
      if value == list.last
        print "#{value}#{suffix}"
      else
        print value
      end
    end
  end
end

# 以下、-lオプションの対応
def build_display_files
  current_directory_files = Dir.glob('*')
  all_file_mode = []
  all_file_nlink = []
  all_file_uid = []
  all_file_gid = []
  all_file_size = []
  all_file_mtime = []
  all_file_name = []

  current_directory_files.each do |file|
    stat = File.lstat(file)
    file_mode = stat.mode.to_s(8)
    file_mode = file_mode[0] == "1" ? file_mode : "0#{file_mode}"
    all_file_mode << "#{translate_mode(file_mode)}"
    all_file_nlink << "#{stat.nlink}"
    all_file_uid << "#{translate_uid(stat.uid)}"
    all_file_gid << "#{translate_gid(stat.gid)}"
    all_file_size << "#{stat.size}"
    all_file_mtime << "#{translate_date(stat.mtime)}"
    all_file_name << "#{file}"
  end

  divided_file_details = [
    all_file_mode,
    all_file_nlink,
    all_file_uid,
    all_file_gid,
    all_file_size,
    all_file_mtime,
    all_file_name
  ]

  adjusted_file_details = []
  divided_file_details.each.with_index do |data_list, index|
    max_str_count = data_list.max_by(&:size).size
    # ファイルサイズや日付などを右詰にしグループ名などを左詰するための処理
    if index == 0 || index == 2 || index == 3 || index == divided_file_details.length - 1
      adjusted_file_details << data_list.map { |v| v.ljust(max_str_count) }
    else
      adjusted_file_details << data_list.map { |v| v.rjust(max_str_count) }
    end
  end
  adjusted_file_details.transpose
end

def display_l_option_files
  build_display_files.each do |list|
    list.each do |value|
      suffix = "\n"
      if value == list.last
        print "#{value}#{suffix}"
      else
        print "#{value}  "
      end
    end
  end
end

def translate_uid(uid)
  Etc.getpwuid(uid).name
end

def translate_gid(gid)
  Etc.getgrgid(gid).name
end

def translate_date(date)
  if date.year == Time.now.year
    "#{date.day} #{date.month} #{date.hour.to_s.rjust(2, "0")}:#{date.min.to_s.rjust(2, "0")}"
  else
    "#{date.day} #{date.month} #{date.year}"
  end
end

def translate_mode(mode)
  file_type_hash = {
    '01' => 'p',
    '02' => 'c',
    '04' => 'd',
    '06' => 'b',
    '10' => '-',
    '12' => 'l',
    '14' => 's',
  }

  file_access_right_hash = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx',
  }

  file_type = file_type_hash[mode.slice(0,2)]
  file_access_right_user = file_access_right_hash[mode.slice(3)]
  file_access_right_group = file_access_right_hash[mode.slice(4)]
  file_access_right_other = file_access_right_hash[mode.slice(5)]
  "#{file_type}#{file_access_right_user}#{file_access_right_group}#{file_access_right_other}"
end

if l_option?
  display_l_option_files
else
  display_files
end
