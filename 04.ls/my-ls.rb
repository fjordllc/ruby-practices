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

def divide_into_segments(entities)
  entities.each_slice((entities.length + 2) / SEGMENT_LENGTH).to_a
end

def transpose(entities)
  max_size = entities.map(&:size).max
  entities.map! { |items| items.values_at(0...max_size) }
  entities.transpose
end

def get_under_entities(options)
  entities = Dir.glob('*')
  entities = Dir.entries('.') if options[:a]
  entities.reverse! if options[:r]
  entities
end

def get_entity_type(entity)
  return 'd' if File.directory?(entity)
  return 'l' if File.symlink?(entity)
  return 'c' if File.chardev?(entity)
  return 'b' if File.blockdev?(entity)
  return 'p' if File.pipe?(entity)
  return 's' if File.socket?(entity)
  return '-' if File.file?(entity)
end

def format_permissions(mode)
  perm = mode.to_s(8)[-3..]
  perm.chars.map { |char| PERMISSION_MAP[char] }.join('')
end

def list_entities(entities)
  divided_entities = divide_into_segments(entities)
  longest_entity_length = divided_entities.flatten.max_by(&:length).length
  transposed_entities = transpose(divided_entities)

  transposed_entities.each do |column_entitites|
    column_entitites.each do |column_entitiy|
      print column_entitiy&.ljust(longest_entity_length + 1)
    end
    print("\n")
  end
end

def list_entities_in_details(entities)
  total_blocks = entities.sum { |entity| File.stat(entity).blocks }
  puts "total #{total_blocks}"

  entities.each do |entity|
    stat = File.stat(entity)
    type = get_entity_type(entity)
    permissions = format_permissions(stat.mode)
    hard_link = stat.nlink
    owner = Etc.getpwuid(stat.uid).name
    group = Etc.getgrgid(stat.gid).name
    file_size = stat.size
    last_modified_time = stat.mtime.strftime('%b %d %H:%M')

    puts "#{type}#{permissions} #{hard_link} #{owner}  #{group}  #{file_size} #{last_modified_time} #{entity}"
  end
end

opt = OptionParser.new
options = {}
opt.on('-a') { |v| options[:a] = v }
opt.on('-r') { |v| options[:r] = v }
opt.on('-l') { |v| options[:l] = v }
opt.parse!(ARGV)

entities = get_under_entities(options)
if options[:l]
  list_entities_in_details(entities)
else
  list_entities(entities)
end
