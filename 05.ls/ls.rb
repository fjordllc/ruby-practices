#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

MAXIMUM_WIDTH = 3.0

FILE_TYPE_LABELS =
  {
    'directory' => 'd',
    'file' => '-',
    'link' => 'l'
  }.freeze

PERMISSION_LABELS =
  {
    0 => '---',
    1 => '--x',
    2 => '-w-',
    3 => '-wx',
    4 => 'r--',
    5 => 'r-x',
    6 => 'rw-',
    7 => 'rwx'
  }.freeze

class Ls
  def main
    get_options = ARGV.getopts('arl')

    if get_options['a']
      @elements = Dir.glob('*', File::FNM_DOTMATCH).sort

      list_of_elements
      show_ls
    elsif get_options['r']
      @elements = Dir.glob('*').sort.reverse

      list_of_elements
      show_ls
    elsif get_options['l']
      @elements = Dir.glob('*').sort

      show_total_blocks
      show_file_details
    else
      @elements = Dir.glob('*').sort

      list_of_elements
      show_ls
    end
  end

  def list_of_elements
    total_element = @elements.size

    columns = (total_element / MAXIMUM_WIDTH).ceil

    lists = []

    @elements.each_slice(columns) do |element|
      lists << element

      # 最大要素数を取得して、その要素数に合わせる
      max_size = lists.map(&:size).max
      lists.map! { |it| it.values_at(0...max_size) }
    end
    lists
  end

  def show_ls
    # rowとcolumnの入れ替え
    sort_of_lists = list_of_elements.transpose
    # 配列の最大文字数を取得し、その文字数+余白分で等間隔表示する
    max_word_count = sort_of_lists.flatten.max_by { |x| x.to_s.length }
    spacing_between_elements = max_word_count.length + 15
    sort_of_lists.each do |sort_of_list|
      sort_of_list.each do |s|
        print s.to_s.ljust(spacing_between_elements)
      end
      print "\n"
    end
  end

  def show_total_blocks
    blocks = []
    @elements.each do |element|
      @stat = File.stat(element)
      blocks << @stat.blocks
    end
    print 'total '
    print blocks.sum
    print "\n"
  end

  def show_file_details
    @elements.each do |element|
      @stat = File.stat(element)
      @element_mode = @stat.mode.to_s(8)

      print FILE_TYPE_LABELS[@stat.ftype]

      permission_number = @element_mode.to_i.digits.take(3).reverse
      element_permission =
        PERMISSION_LABELS[permission_number[0]] +
        PERMISSION_LABELS[permission_number[1]] +
        PERMISSION_LABELS[permission_number[2]]
      print "#{element_permission} "

      print "#{@stat.nlink} "

      print "#{Etc.getpwuid(@stat.uid).name}  "
      print "#{Etc.getgrgid(@stat.gid).name}  "

      print "#{@stat.size}  "
      print "#{File.mtime(element).strftime('%m %e %H:%M')}  "
      print element

      print "\n"
    end
  end
end
ls = Ls.new
ls.main
