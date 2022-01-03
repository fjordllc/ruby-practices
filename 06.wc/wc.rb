# frozen_string_literal: true

require 'optparse'

def wc_command
  has_input_from_pipe = File.pipe?($stdin)
  l_option = ARGV.getopts('l')['l']
  if has_input_from_pipe
    input_file_summary = calc_file_summary($stdin.read)
    output_file_summary(input_file_summary, l_option)
  elsif ARGV.length.positive?
    file_summaries = ARGV.map do |file_name|
      text = File.read(file_name)
      calc_file_summary(text, file_name)
    end
    file_summaries.map { |file_summary| output_file_summary(file_summary, l_option) }
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
  if l_option
    print format_value(file_summary[:line_count])
  else
    print format_value(file_summary[:line_count])
    print format_value(file_summary[:word_count])
    print format_value(file_summary[:bytesize_count])
  end

  if file_summary[:file_name]
    print " #{format_value(file_summary[:file_name])}"
  elsif file_summary[:file_count] && file_summary[:file_count] > 1
    print ' total'
  end
  print "\n"
end

def format_value(value)
  value.to_s.rjust(8)
end

def calc_total_file_summary(file_summaries)
  total_file_summary = {
    line_count: 0,
    word_count: 0,
    bytesize_count: 0,
    file_count: 0
  }
  file_summaries.each do |file_summary|
    total_file_summary[:line_count] += file_summary[:line_count]
    total_file_summary[:word_count] += file_summary[:word_count]
    total_file_summary[:bytesize_count] += file_summary[:bytesize_count]
    total_file_summary[:file_count] += 1
  end
  total_file_summary
end

wc_command
