# frozen_string_literal: true

require 'optparse'
require 'etc'

ROW = 3
SPACE = 3
FILE_TYPE = { 'fifo' => 'p', 'characterSpecial' => 'c', 'directory' => 'd', 'blockSpecial' => 'b', 'file' => '-', 'link' => 'l', 'socket' => 's' }.freeze
PERMISSION = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }.freeze
STICKY_PERMISSION =  { '0' => '--T', '1' => '--t', '2' => '-wT', '3' => '-wt', '4' => 'r-T', '5' => 'r-t', '6' => 'rwT', '7' => 'rwt' }.freeze
SGID_SUID_PERMISSION = { '0' => '--S', '1' => '--s', '2' => '-wS', '3' => '-ws', '4' => 'r-S', '5' => 'r-s', '6' => 'rwS', '7' => 'rws' }.freeze

class LSCommand
  def initialize
    opt = OptionParser.new
    @options = {}
    opt.on('-a') { |v| @options[:a] = v }
    opt.on('-r') { |v| @options[:r] = v }
    opt.on('-l') { |v| @options[:l] = v }
    opt.parse!(ARGV)

    @path = ARGV if ARGV[1]
    @path = ARGV[0] if ARGV[0] && ARGV[1].nil?
    @path ||= Dir.pwd
  end

  def output
    case @path
    when String
      select_display(file_information(@path))
    when Array
      @path.each do |path|
        puts "#{path}:"
        select_display(file_information(path))
      end
    end
  end

  def file_information(path)
    file_informations = []
    Dir.chdir(path) do
      # file_names = @options[:a] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
      # file_names = @options[:r] ? Dir.glob('*').reverse : Dir.glob('*')
      file_informations = if @options[:l]
                            l_opsion_file_information(path)
                          else
                            Dir.glob('*')
                          end
    end
  end

  def l_opsion_file_information(path)
    file_informations = []
    Dir.glob('*').each do |filename|
      file_info = File.lstat(filename)
      user_permission = file_info.mode.to_s(8)[-4] == '4' ? SGID_SUID_PERMISSION[file_info.mode.to_s(8)[-3]] : PERMISSION[file_info.mode.to_s(8)[-3]]
      group_permission = file_info.mode.to_s(8)[-4] == '2' ? SGID_SUID_PERMISSION[file_info.mode.to_s(8)[-2]] : PERMISSION[file_info.mode.to_s(8)[-2]]
      other_permission = file_info.mode.to_s(8)[-4] == '1' ? STICKY_PERMISSION[file_info.mode.to_s(8)[-1]] : PERMISSION[file_info.mode.to_s(8)[-1]]
      link_to_file = " -> #{File.readlink("#{path}#{filename}")}" if file_info.symlink?
      file_informations << {
        blocks: file_info.blocks, file_type: FILE_TYPE[file_info.ftype],
        user_permission: user_permission, group_permission: group_permission,
        other_permission: other_permission, nlink: file_info.nlink,
        user_name: Etc.getpwuid(file_info.uid).name, group_name: Etc.getgrgid(file_info.gid).name,
        size: file_info.size, date: file_info.mtime.strftime('%_m %e %H:%M'),
        file_name: filename, link: link_to_file
      }
    end
    file_informations
  end

  def select_display(file_informations)
    case file_informations[1]
    when String
      default_display(file_informations)
    when Hash
      l_option_display(file_informations)
    end
  end

  def default_display(file_names)
    width = file_names.max_by(&:size).size + SPACE
    line = file_names.size / ROW
    line += 1 if (file_names.size % ROW).positive?
    line.times do |time|
      file_names.select.with_index { |_name, i| i % line == time }.each { |name| print format("%-#{width}s", name) }
      print "\n"
    end
    print "\n"
  end

  def l_option_display(file_informations)
    max_username_size = file_informations.max_by { |x| x[:user_name].size }[:user_name].size + 1
    max_groupname_size = file_informations.max_by { |x| x[:group_name].size }[:group_name].size + 2
    puts "total #{file_informations.sum { |x| x[:blocks] }}"
    file_informations.each do |x|
      print x[:file_type]
      print x[:user_permission]
      print x[:group_permission]
      print x[:other_permission]
      print format('%3d', x[:nlink])
      print format("%#{max_username_size}s", x[:user_name])
      print format("%#{max_groupname_size}s", x[:group_name])
      print format('%6d', x[:size])
      print " #{x[:date]}"
      print " #{x[:file_name]}"
      print x[:link]
      print "\n"
    end
  end
end

ls = LSCommand.new
ls.output
