# frozen_string_literal: true

require 'optparse'

class LS
  def initialize
    opt = OptionParser.new
    @option = {}

    opt.on('-a') { |v| @option[:a] = v }
    opt.on('-r') { |v| @option[:r] = v }
    opt.parse!(ARGV)
  end

  def exec
    files = Dir.glob('*', @option[:a] ? File::FNM_DOTMATCH : 0)
    files.reverse! if @option[:r]
    files
  end

  def print_files
    files = exec
    # カラムを変更する変数
    columns = 3
    number_of_rows = (files.length % columns).zero? ? files.length / columns : files.length / columns + 1
    tab_files = files.each_slice(number_of_rows).to_a
    number_of_rows.times do |i|
      lines = tab_files.map { |file| file[i]&.slice(0, 15)&.ljust(20) unless file[i].nil? }.compact
      puts lines.join('')
    end
  end
end

LS.new.print_files
