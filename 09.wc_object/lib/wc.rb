#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

module WC
  # Class for a single file
  class File
    @options = {}

    class << self
      attr_accessor :options

      def build_text(files)
        return files.to_s unless files.instance_of?(Array)
        return files[0].to_s if files.size == 1

        total = make_total(files)
        max_b, max_r, max_w = compute_max_digits(total)

        [*files, total].inject('') do |text, file|
          text + "#{file.to_s(max_r, max_w, max_b)}\n"
        end
      end

      def make_total(files)
        total = File.new
        total.byte_size = files.map(&:byte_size).sum
        total.rows = files.map(&:rows).sum
        total.word_count = files.map(&:word_count).sum
        total.name = 'total'
        total
      end

      def compute_max_digits(total)
        max_b = [7, total.byte_size.to_s.length].max
        max_r = [7, total.rows.to_s.length].max
        max_w = [7, total.word_count.to_s.length].max
        [max_b, max_r, max_w]
      end
    end

    attr_accessor :byte_size, :rows, :word_count, :name

    def initialize(text = '', name = nil)
      text = text.gsub(/\r\n?/, "\n")
      @byte_size = text.bytesize
      @rows = text.scan(/\n/).size
      @word_count = text.split(/[\s　]+/).size
      @name = name
    end

    def to_s(max_r = 7, max_w = 7, max_b = 7)
      if WC::File.options['l']
        " #{rows.to_s.rjust(max_r)} #{name}"
      else
        " #{rows.to_s.rjust(max_r)} #{word_count.to_s.rjust(max_w)} #{byte_size.to_s.rjust(max_b)} #{name}"
      end
    end
  end
end

WC::File.options = ARGV.getopts('l')

if ARGV[0]
  filelist = ARGV.map { |f| WC::File.new(File.read(f), f) }
  puts WC::File.build_text(filelist)
else
  file = WC::File.new($stdin.readlines.join, nil)
  puts WC::File.build_text(file)
end
