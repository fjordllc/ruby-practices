# frozen_string_literal: true

def main
  param = {}
  param[:options] = []
  param[:files] = []

  ARGV.each do |option|
    case option
    when /^-[a-zA-Z]+/
      param[:options] << option
    else
      param[:files] << option
    end
  end

  wc = WC.new(**param)
  wc.format_output
end

class WC
  def initialize(param)
    @strings = obtain_target_strings(param[:files])
    @lines = []
    @word_count = []
    @bytesizes = obtain_bytesizes(param[:files])

    @strings.each do |string|
      @lines << string.length
      @word_count << string.map do |line|
        line.split(/[\s　]+/).length
      end.sum
    end
  end

  def total_lines
    @lines.each(&:sum)
  end

  def total_word_count
    @word_count.each(&:sum)
  end

  def total_filesize
    @filesizes.each(&:sum)
  end

  def calc_total_filesizes(files)
    files.each do |file|
      @filesizes << File.size(file)
    end
    @filesizes.sum
  end

  def format_output
    @strings.map do |i|
      
    end
    p @lines
    p @word_count
    p @bytesizes
  end

  private

  def obtain_target_strings(files)
    target_string = []
    if files.empty?
      target_string << $stdin.readlines
    else
      files.each do |file|
        target_string << File.new(file).readlines
      end
    end
    target_string
  end

  def obtain_bytesizes(files)
    bytesizes = []
    if files.empty?
      @strings.each do |string|
        bytesizes << string.join.bytesize
      end
    else
      files.each do |file|
        bytesizes << File.size(file)
      end
    end
    bytesizes
  end
end

main
