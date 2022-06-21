# frozen_string_literal: true

require 'optparse'

class LS
  def initialize
    opt = OptionParser.new
    @option = {}

    opt.on('-a') { |v| @option[:a] = v }
    opt.parse!(ARGV)
  end

  def read_files
    files = if @option.empty?
              Dir.glob('*')
            else
              Dir.glob('*', File::FNM_DOTMATCH)
            end
    files.sort
  end

  def print_files
    files = read_files
    # カラムを変更する変数
    columns = 3
    number_row = files.length % columns ? files.length / columns + 1 : files.length
    tab_files = files.each_slice(number_row).to_a
    (0..(number_row - 1)).each do |i|
      lines = tab_files.map { |file| file[i]&.slice(0, 15)&.ljust(20) unless file[i].nil? }.compact
      puts lines.join('')
    end
  end
end

LS.new.print_files
