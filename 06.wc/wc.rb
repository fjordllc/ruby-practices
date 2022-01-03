# frozen_string_literal: true

require 'optparse'

def wc_command
  has_input_from_pipe = File.pipe?($stdin)
  command_options = ARGV.getopts('l')
  if has_input_from_pipe
    file_summary = calc_file_summary($stdin.read)
    output_file_summary(command_options, file_summary)
  else
    file_names = ARGV
    if file_names.length.positive?
      file_summaries = file_names.map do |file_name|
        text = File.read(file_name)
        calc_file_summary(text, file_name)
      end
      output_file_summaries(command_options, file_summaries)
    else
      standard_input_string = $stdin.read
      # TODO: calcとoutputどちらも使った形に書き直す（output側を整理した後）
      output_text_summary(command_options, standard_input_string)
    end
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

def output_file_summary(command_options, file_summary)
  if command_options['l']
    puts format_value(file_summary[:line_count])
  else
    print format_value(file_summary[:line_count])
    print format_value(file_summary[:word_count])
    puts format_value(file_summary[:bytesize_count])
  end
end

def format_value(value)
  value.to_s.rjust(8)
end

def output_file_summaries(command_options, file_summaries)
  file_summaries.each do |file_summary|
    print format_value(file_summary[:line_count])
    unless command_options['l']
      print format_value(file_summary[:word_count])
      print format_value(file_summary[:bytesize_count])
    end
    puts " #{format_value(file_summary[:file_name])}"
  end

  return unless file_summaries.size > 1

  total_file_summary = calc_total_file_summary(file_summaries)
  output_total_file_summary(command_options, total_file_summary)
end

def calc_total_file_summary(file_summaries)
  total_file_summary = {
    total_line_count: 0,
    total_word_count: 0,
    total_bytesize_count: 0
  }
  file_summaries.each do |file_summary|
    total_file_summary[:total_line_count] += file_summary[:line_count]
    total_file_summary[:total_word_count] += file_summary[:word_count]
    total_file_summary[:total_bytesize_count] += file_summary[:bytesize_count]
  end
  total_file_summary
end

def output_total_file_summary(command_options, total_file_summary)
  print format_value(total_file_summary[:total_line_count])
  unless command_options['l']
    print format_value(total_file_summary[:total_word_count])
    print format_value(total_file_summary[:total_bytesize_count])
  end
  print " total\n"
end

def output_text_summary(command_options, standard_input_string)
  if command_options['l']
    puts format_value(standard_input_string.count("\n"))
  else
    print format_value(standard_input_string.count("\n"))
    print format_value(standard_input_string.split(' ').size)
    puts format_value(standard_input_string.bytesize)
  end
end

wc_command
