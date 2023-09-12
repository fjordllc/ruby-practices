# frozen_string_literal: true

require 'optparse'
require 'etc'

def parse_options
  options = {}
  opt = OptionParser.new
  # opt.on('-a') { |v| options[:a] = v } -aオプションは実装しなくていいとのことなのでコメントアウト
  # opt.on('-r') { |v| options[:r] = v } -rオプションは実装しなくていいとのことなのでコメントアウト
  opt.on('-l') { |v| options[:l] = v }
  opt.parse!(ARGV)
  options
end

save_option = parse_options # 戻り値を複数の箇所で使用するために別の変数に保存する必要がある

def file_entries(_save_option)
  # flags = save_option[:a] ? File::FNM_DOTMATCH : 0 -aオプションは実装しなくていいとのことなのでコメントアウト
  # Dir.glob('*', flags)
  # if save_option[:r] -rオプションは実装しなくていいとのことなのでコメントアウト
  #   Dir.glob('*', 0).reverse
  # else
  #   Dir.glob('*', 0)
  # end
  Dir.glob('*', 0)
end

def align_left(string, entries)
  max_length = entries.flatten.map { |entry| entry.to_s.size + 5 }.max
  string.to_s.ljust(max_length) # 引数1を左揃え（取得した名称の最大文字数に+5した数値で揃える）
end

def align_right(item, number)
  item.to_s.rjust(number)
end

def permission_convert(permission_number)
  result = permission_number.length == 5 ? 'd' : '-'
  permission_three_digits = [permission_number[-3], permission_number[-2], permission_number[-1]]
  permission_three_digits.each do |permission|
    result += 'rwx' if permission.include?('7')
    result += 'rw-' if permission.include?('6')
    result += 'r-x' if permission.include?('5')
    result += 'r--' if permission.include?('4')
    result += '-wx' if permission.include?('3')
    result += '-w-' if permission.include?('2')
    result += '-ーx' if permission.include?('1')
    result += '---' if permission.include?('0')
  end
  result
end

file_entries_result = file_entries(save_option)

if save_option[:l]
  total_file_block = 0
  ownership_user_name = []
  ownership_group_name = []
  hard_link = []
  last_update_month = []
  last_update_day = []
  last_update_hour = []
  last_update_min = []
  permission = []
  file_size = []

  file_entries_result.each_with_index do |file, number|
    total_file_block += File.stat(file).blocks
    puts "total #{total_file_block}" if number == file_entries_result.length - 1
  end
  file_entries_result.each_with_index do |file, number|
    ownership_user_name << Etc.getpwuid(File.stat(file).uid).name
    ownership_group_name << Etc.getgrgid(File.stat(file).gid).name
    hard_link << File.stat(file).nlink
    last_update_month << File.stat(file).mtime.month
    last_update_day << File.stat(file).mtime.day
    last_update_hour << File.stat(file).mtime.hour
    last_update_min << File.stat(file).mtime.min
    permission << File.stat(file).mode.to_s(8)
    file_size << File.stat(file).size
    max_file_size = file_entries_result.map do |result_file|
      File.stat(result_file).size
    end.max.to_s.length

    next if file_entries_result.empty?

    puts "#{permission_convert(permission[number])} #{hard_link[number]} #{ownership_user_name[number]} #{ownership_group_name[number]} #{align_right(
      file_size[number], max_file_size
    )} #{last_update_month[number]} #{last_update_day[number]} #{last_update_hour[number]}:#{last_update_min[number]} #{file}"
  end
else
  entries = file_entries_result.each_slice((file_entries_result.size.to_f / 3).ceil).to_a
  entries_max_size = entries.map(&:size).max

  new_entries = entries.map do |entry|
    entry.concat([nil] * (entries_max_size - entry.size)) if entries_max_size > entry.size
    entry
  end

  new_entries.transpose.each do |entry|
    puts entry.map { |item| align_left(item, entries) }.join
  end
end
