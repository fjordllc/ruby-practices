# frozen_string_literal: true

require 'optparse'
require 'etc'

module LS
  class File
    attr_reader :files

    def initialize
      @files = Dir.glob('*').sort
    end

    def all(files)
      Dir.glob('.*').sort + files
    end

    def reverse(files)
      files.reverse
    end

    def data(files)
      fdata = []
      files.each do |fname|
        fstat = ::File::Stat.new(fname)
        fdata.push [
          permission_convert(fstat),
          fstat.nlink.to_s.rjust(nlink_length(files)),
          Etc.getpwuid(fstat.uid).name,
          Etc.getgrgid(fstat.gid).name.rjust(6),
          fstat.size.to_s.rjust(5),
          fstat.mtime.strftime('%_m %e %H:%M'),
          fname
        ]
      end
      fdata
    end

    private

    def nlink_length(files)
      max_length = []
      files.each do |fname|
        fstat = ::File::Stat.new(fname)
        max_length << fstat.nlink
      end
      max_length.max_by { |num| num.to_s.length }.to_s.length
    end

    def permission_convert(fstat)
      type = fstat.ftype == 'file' ? '-' : fstat.ftype[0]
      rwx = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx',
              '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }
      mode = fstat.mode.to_s(8)[-3, 3].gsub(/\d/, rwx)
      "#{type}#{mode} "
    end
  end

  class Command < File
    attr_reader :options, :files

    def initialize
      super
      @options = {}
      opt = OptionParser.new
      opt.on('-a', '--all') { |v| @options[:a] = v }
      opt.on('-l', '--long') { |v| @options[:l] = v }
      opt.on('-r', '--reverse') { |v| @options[:r] = v }
      opt.parse(ARGV)
    end

    def select_option
      if options[:a] == true
        @files = all(files)
      else
        @files
      end

      @files = reverse(files) if options[:r] == true

      if options[:l] == true
        LS::VerticalFormatter.new.single_column(@files)
      else
        LS::HorizontalFormatter.new.multi_column(@files)
      end
    end
  end

  class HorizontalFormatter
    def multi_column(files)
      result = []
      files.map { |fname| result << fname.to_s.ljust(24, ' ') }
      format = result.each_slice(length(files)).to_a
      push_nil(format).transpose.each { |a| puts a.join('') }
    end

    private

    def length(files)
      (files.length % 4).zero? ? files.length / 4 : files.length / 4 + 1
    end

    def push_nil(format)
      max = format.max_by(&:length).length
      format.each { |a| a[max - 1] = nil if a.length < max }
    end
  end

  class VerticalFormatter
    def total(files)
      total = 0
      files.each do |fname|
        fstat = ::File::Stat.new(fname)
        total += fstat.blocks
      end
      puts "total #{total}"
    end

    def single_column(files)
      total(files)
      fdata = LS::Command.new.data(files)
      fdata.map { |a| puts a.each_slice(7).to_a.join(' ') }
    end
  end
end

LS::Command.new.select_option
