# frozen_string_literal: true

require 'optparse'

def wc_command
  l_option = ARGV.getopts('l')['l']
  if ARGV.length.positive?
    file_summaries = ARGV.map do |file_name|
      text = File.read(file_name)
      calc_file_summary(text, file_name)
    end
    file_summaries.each { |file_summary| output_file_summary(file_summary, l_option) }
    return if file_summaries.size <= 1

    total_file_summary = calc_total_file_summary(file_summaries)
    output_file_summary(total_file_summary, l_option)
  else
    file_summary = calc_file_summary($stdin.read)
    output_file_summary(file_summary, l_option)
  end
end

def calc_file_summary(text, file_name = nil)
  file_summary = {}
  file_summary[:line_count] = text.count("\n")
  file_summary[:word_count] = text.split(' ').size
  file_summary[:bytesize_count] = text.bytesize
  file_summary[:file_name] = file_name
  file_summary
end

def output_file_summary(file_summary, l_option)
  print format_value(file_summary[:line_count])
  unless l_option
    print format_value(file_summary[:word_count])
    print format_value(file_summary[:bytesize_count])
  end

  print " #{file_summary[:file_name]}" if file_summary[:file_name]
  print "\n"
end

def format_value(value)
  value.to_s.rjust(8)
end

def calc_total_file_summary(file_summaries)
  total_file_summary = {
    line_count: 0,
    word_count: 0,
    bytesize_count: 0
  }
  file_summaries.each do |file_summary|
    total_file_summary[:line_count] += file_summary[:line_count]
    total_file_summary[:word_count] += file_summary[:word_count]
    total_file_summary[:bytesize_count] += file_summary[:bytesize_count]
  end
  total_file_summary[:file_name] = 'total'
  total_file_summary
end

wc_command
