# frozen_string_literal: true

require 'English'
require 'optparse'
require 'etc'

NUM_COLUMNS = 3 # 列幅の最大幅
BEFORE_CONVERT_FILETYPE_REGEXP = /(?<filetype>\d{1,2})(?<stickybit>\d)(?<user_permission>\d)(?<group_permission>\d)(?<other_permission>\d)/
BEFORE_CONVERT_USER_PERMISSION_REGEXP = /(?<filetype>.)(?<stickybit>\d)(?<user_permission>\d)(?<group_permission>\d)(?<other_permission>\d)/
BEFORE_CONVERT_GROUP_PERMISSION_REGEXP = /(?<filetype>.)(?<stickybit>\d)(?<user_permission>.{3})(?<group_permission>\d)(?<other_permission>\d)/
BEFORE_CONVERT_OTHER_PERMISSION_REGEXP = /(?<filetype>.)(?<stickybit>\d)(?<user_permission>.{3})(?<group_permission>.{3})(?<other_permission>\d)/
BEFORE_CONVERT_STICKYBIT_REGEXP = /(?<filetype>.)(?<stickybit>\d)(?<user_permission>.{3})(?<group_permission>.{3})(?<other_permission>.{3})/
PERMISSION_MATCER = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze # permissionの8進数表現とrwx表記の対応表
FILETYPE_MATCHER = {
  '1' => 'p',
  '2' => 'c',
  '4' => 'd',
  '6' => 'b',
  '10' => '-',
  '12' => 'l'
}.freeze # filetypeの8進数表現とpcdbl表記の対応表

def main
  options = parse_options
  taken_items = take_items(options)
  sliced_items = slice_items(options, taken_items)
  transposed_items = transpose_items(sliced_items)
  display_items(transposed_items)
end

def parse_options
  options = { take_hidden_files: false, reverse: false, view_details: false }

  OptionParser.new do |opt|
    opt.on('-a') do
      options[:take_hidden_files] = true
    end

    opt.on('-r') do
      options[:reverse] = true
    end

    opt.on('-l') do
      options[:view_details] = true
    end
  end.parse!

  options
end

def take_items(options)
  entries = if options[:take_hidden_files]
              Dir.foreach('.').to_a
            else
              Dir.glob('*')
            end
  sorted_entries = entries.sort
  inflicted_reverse_options_entries = options[:reverse] ? sorted_entries.reverse : sorted_entries
  options[:view_details] ? take_file_details(inflicted_reverse_options_entries, options) : inflicted_reverse_options_entries
end

def take_file_details(inflicted_reverse_options_entries, options)
  file_stats = take_file_stat(inflicted_reverse_options_entries)
  file_modes = convert_filemode_stickybit(file_stats)
  file_hardlinks = take_file_hardlink(file_stats)
  owner_names = take_owner_name(file_stats)
  group_names = take_group_name(file_stats)
  file_sizes = take_file_size(inflicted_reverse_options_entries)
  file_times = convert_timestamps_to_strftime(inflicted_reverse_options_entries)
  file_names = take_file_name(inflicted_reverse_options_entries)
  file_block(file_stats, options)
  [file_modes, file_hardlinks, owner_names, group_names, file_sizes, file_times, file_names]
end

def file_block(file_stats, options)
  file_block = file_stats.map(&:blocks).sum
  puts file_block if options[:view_details] == true
end

def take_file_stat(inflicted_reverse_options_entries)
  inflicted_reverse_options_entries.map do |entry|
    File.stat(entry)
  end
end

def take_filemode_number(file_stats)
  file_stats.map do |file_stat|
    file_stat.mode.to_s(8) # 8進数に変換
  end
end

def convert_filemode_filetype(file_stats)
  take_filemode_number(file_stats).map do |filemode|
    filemode.gsub(BEFORE_CONVERT_FILETYPE_REGEXP) do |match|
      matched_filetype = $LAST_MATCH_INFO[:filetype]
      replaced_filetype = FILETYPE_MATCHER[matched_filetype]
      match.sub(matched_filetype, replaced_filetype)
    end
  end
end

def convert_filemode_permission_user(file_stats)
  convert_filemode_filetype(file_stats).map do |filemode|
    filemode.gsub(BEFORE_CONVERT_USER_PERMISSION_REGEXP) do |match|
      matched_permission_user = $LAST_MATCH_INFO[:user_permission]
      replaced_permission_user = PERMISSION_MATCER[matched_permission_user]
      match.sub(matched_permission_user, replaced_permission_user)
    end
  end
end

def convert_filemode_permission_group(file_stats)
  convert_filemode_permission_user(file_stats).map do |filemode|
    filemode.gsub(BEFORE_CONVERT_GROUP_PERMISSION_REGEXP) do |match|
      matched_permission_group = $LAST_MATCH_INFO[:group_permission]
      replaced_permission_group = PERMISSION_MATCER[matched_permission_group]
      match.sub(matched_permission_group, replaced_permission_group)
    end
  end
end

def convert_filemode_permission_other(file_stats)
  convert_filemode_permission_group(file_stats).map do |filemode|
    filemode.gsub(/\d\z/, PERMISSION_MATCER)
  end
end

def convert_filemode_stickybit(file_stats)
  convert_filemode_permission_other(file_stats).map do |filemode|
    filemode.gsub(BEFORE_CONVERT_STICKYBIT_REGEXP) do |_match|
      matched_filetype = $LAST_MATCH_INFO[:filetype]
      matched_stickybit = $LAST_MATCH_INFO[:stickybit]
      matched_permission_other = $LAST_MATCH_INFO[:other_permission]
      matched_permission_user = $LAST_MATCH_INFO[:user_permission]
      matched_permission_group = $LAST_MATCH_INFO[:group_permission]
      case matched_stickybit
      when '1'
        matched_permission_other[-1] = matched_permission_other.include?('x') ? 't' : 'T'
      when '2'
        matched_permission_group[-1] = matched_permission_group.include?('x') ? 's' : 'S'
      when '4'
        matched_permission_user[-1] = matched_permission_user.include?('x') ? 's' : 'S'
      end
      matched_filetype + matched_permission_user + matched_permission_group + matched_permission_other
    end
  end
end

def take_file_hardlink(file_stats)
  file_stats.map(&:nlink)
end

def take_owner_name(file_stats)
  file_stats.map do |file_stat|
    Etc.getpwuid(file_stat.uid).name
  end
end

def take_group_name(file_stats)
  file_stats.map do |file_stat|
    Etc.getgrgid(file_stat.gid).name
  end
end

def take_file_size(inflicted_reverse_options_entries)
  inflicted_reverse_options_entries.map do |entry|
    File.size(entry)
  end
end

def take_file_timestamp(inflicted_reverse_options_entries)
  inflicted_reverse_options_entries.map do |entry|
    File.mtime(entry)
  end
end

def convert_timestamps_to_strftime(inflicted_reverse_options_entries)
  timestamps = take_file_timestamp(inflicted_reverse_options_entries)
  timestamps.map do |timestamp|
    timestamp.strftime('%m %d %H:%M')
  end
end

def take_file_name(inflicted_reverse_options_entries)
  inflicted_reverse_options_entries.map do |entry|
    File.basename(entry)
  end
end

def slice_items(options, taken_items)
  slice_number = if (taken_items.size % NUM_COLUMNS).zero?
                   taken_items.size / NUM_COLUMNS.ceil # NUM_COLUMNSの倍数の時だけ、NUM_COLUMNSで割り込む
                 else
                   taken_items.size / NUM_COLUMNS.ceil + 1 # 最大NUM_COLUMNS列に収める
                 end
  if options[:view_details] == true
    taken_items # view_detailsがtrueの場合はすでにsliceされている
  else
    taken_items.each_slice(slice_number).to_a
  end
end

def transpose_items(sliced_items)
  max_size = sliced_items.map(&:size).max
  sliced_items.map do |item| # サブ配列の要素数を揃える
    (max_size - item.size).times { item << nil }
    item
  end.transpose
end

def display_items(transposed_items)
  transposed_items.each do |items|
    items.compact.each do |item|
      word_count = item.to_s.length
      print item.to_s.ljust(word_count + 2)
    end
    puts
  end
end

main
