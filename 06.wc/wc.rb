# frozen_string_literal: true

require 'optparse'

class WordCountInString
  def initialize(string)
    @string = string
  end

  def bytes
    @string.bytesize
  end

  def lines
    @string.count("\n")
  end

  def words
    replace_str = ' '
    str = @string.gsub(/\t|\n| /, replace_str)
    str.concat(replace_str) if str.match?(/[^ ]\z/)
    str.squeeze!(replace_str)
    str.eql?(replace_str) ? 0 : str.count(replace_str)
  end

  alias c bytes
  alias l lines
  alias w words
end

def output(word_count_list, file_name)
  format_str = '% 8s' * word_count_list.size
  puts format("#{format_str} %s", *word_count_list, file_name)
end

default_options = { 'l' => true, 'w' => true, 'c' => true }
options = ARGV.getopts('lwc')
options.replace(default_options) unless options.values.any?

file_names = ARGV.empty? ? [''] : ARGV

all_word_count_list = []

file_names.each do |file_name|
  word_count_list = []
  if File.directory?(file_name)
    puts "#{file_name} Is a directory"
    all_word_count_list << Array.new(options.count { |_, v| v }, 0)
    next
  end

  string = file_name.empty? ? $stdin.readlines.join : File.open(file_name).read
  word_count = WordCountInString.new(string)

  options.each do |option, value|
    word_count_list << word_count.send(option) if value
  end

  output(word_count_list, file_name)
  all_word_count_list << word_count_list
end

total_count = all_word_count_list.transpose.map { |array| array.inject(:+) }
output(total_count, 'total') if file_names.size > 1
