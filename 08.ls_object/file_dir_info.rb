# frozen_string_literal: true

require_relative './mystat'
require 'pathname'

class FileDirInfo
  attr_accessor :file_dir_info

  def initialize(option)
    @file_dir_info = []
    @option = option
    file_dir(option.getextras, option.has?(:a))
    if option.has?(:r)
      reverse_sort
    else
      sort
    end
  end

  def my_print
    if @option.has?(:l)
      @file_dir_info.each do |fd|
        puts "#{fd[1]} :" unless fd[0] == :first
        fd[2].each(&:my_print)
      end
    else
      @file_dir_info.each do |fd|
        puts "#{fd[1]} :" unless fd[0] == :first
        datas = []
        div = if (fd[2].size % 3).zero?
                fd[2].size / 3
              else
                fd[2].size / 3 + 1
              end
        data_child = Array.new(div)
        fd[2].each.with_index do |d, i|
          data_child[i % div] = File.basename(d.path)
          if ((i + 1) % div).zero?
            datas << data_child
            data_child = Array.new(div)
          end
        end
        datas << data_child

        datas = datas.transpose

        datas.each do |dataset|
          dataset.each do |item|
            printf('%<display>-30s ', display: item) unless item.nil?
          end
          puts
        end
      end
    end
  end

  private

  def sort
    @file_dir_info.sort! do |a, b|
      (a[0] <=> b[0]).nonzero? || (a[1] <=> b[1])
    end
    @file_dir_info.each do |x|
      x[2].sort! do |a, b|
        File.basename(a.path) <=> File.basename(b.path)
      end
    end
  end

  def reverse_sort
    @file_dir_info.sort! do |a, b|
      (a[0] <=> b[0]).nonzero? || (b[1] <=> a[1])
    end

    @file_dir_info.each do |x|
      x[2].sort! do |a, b|
        File.basename(b.path) <=> File.basename(a.path)
      end
    end
  end

  def dir_stat(pathname, opt)
    stat = []
    arr = []
    arr << pathname.join('*')
    if opt
      Pathname.glob(arr, File::FNM_DOTMATCH) do |p|
        stat << MyStat.new(p)
      end
    else
      Pathname.glob(arr) do |p|
        stat << MyStat.new(p)
      end
    end
    stat
  end

  def file_dir(argv, opt)
    if argv.empty? == false
      argv.each do |arg|
        pathname = Pathname.pwd
        pathname.glob(arg) do |p|
          stat = []
          if p.directory?
            stat = dir_stat(p, opt)
            @file_dir_info << [:other, arg, stat]
          else
            stat << MyStat.new(p)
            args << [:first, nil, stat]
          end
        end
      end
    else
      stat = dir_stat(Pathname('./'), opt)
      @file_dir_info << [:first, nil, stat]
    end
  end
end
