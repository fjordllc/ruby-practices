#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'
require 'etc'

SEGMENT_LENGTH = 3

PERMISSION_MAP = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

def divide_into_segments(filenames)
  filenames.each_slice((filenames.length + 2) / SEGMENT_LENGTH).to_a
end

def transpose(filenames)
  max_size = filenames.map(&:size).max
  filenames.map! { |items| items.values_at(0...max_size) }
  filenames.transpose
end

def fetch_filenames(options)
  filenames = Dir.glob('*')
  filenames = Dir.entries('.') if options[:a]
  filenames.reverse! if options[:r]
  filenames
end

def file_type(filename)
  return 'd' if File.directory?(filename)
  return 'l' if File.symlink?(filename)
  return 'c' if File.chardev?(filename)
  return 'b' if File.blockdev?(filename)
  return 'p' if File.pipe?(filename)
  return 's' if File.socket?(filename)
  return '-' if File.file?(filename)
end

def format_permissions(mode)
  perm = mode.to_s(8)[-3..]
  perm.chars.map { |char| PERMISSION_MAP[char] }.join('')
end

def list_filenames(filenames)
  divided_filenames = divide_into_segments(filenames)
  longest_filename_length = divided_filenames.flatten.max_by(&:length).length
  transposed_filenames = transpose(divided_filenames)

  transposed_filenames.each do |column_filenames|
    column_filenames.each do |column_filename|
      print column_filename&.ljust(longest_filename_length + 1)
    end
    print("\n")
  end
end

def list_filenames_in_details(filenames)
  total_blocks = filenames.sum { |filename| File.stat(filename).blocks }
  puts "total #{total_blocks}"

  filenames.each do |filename|
    stat = File.stat(filename)
    type = file_type(filename)
    permissions = format_permissions(stat.mode)
    hard_link = stat.nlink
    owner = Etc.getpwuid(stat.uid).name
    group = Etc.getgrgid(stat.gid).name
    file_size = stat.size
    last_modified_time = stat.mtime.strftime('%b %d %H:%M')

    puts "#{type}#{permissions} #{hard_link} #{owner}  #{group}  #{file_size} #{last_modified_time} #{filename}"
  end
end

opt = OptionParser.new
options = {}
opt.on('-a') { |v| options[:a] = v }
opt.on('-r') { |v| options[:r] = v }
opt.on('-l') { |v| options[:l] = v }
opt.parse!(ARGV)

filenames = fetch_filenames(options)
if options[:l]
  list_filenames_in_details(filenames)
else
  list_filenames(filenames)
end
