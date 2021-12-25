# frozen_string_literal: true

require 'optparse'

def standard_input
  $stdin.read
end

def calc_file_summary(input)
  file_summary = {}
  file_summary[:line_count] = input.count("\n")
  file_summary[:word_count] = input.tr("\n", ' ').split(' ').size
  file_summary[:bytesize_count] = input.bytesize
  file_summary
end

def output_file_summary(command_options, file_summary)
  if command_options['l']
    print "#{file_summary[:line_count].to_s.rjust(8)}\n"
  else
    print file_summary[:line_count].to_s.rjust(8)
    print file_summary[:word_count].to_s.rjust(8)
    print "#{file_summary[:bytesize_count].to_s.rjust(8)}\n"
  end
end

def calc_file_summaries(file_names)
  file_summaries = []
  file_names.each do |file_name|
    file_summary = {}
    File.open(file_name) do |file|
      file_contents = file.read
      file_summary[:line_count] = file_contents.count("\n")
      file_summary[:word_count] = file_contents.split(' ').size
      file_summary[:bytesize_count] = file_contents.bytesize
      file_summary[:file_name] = file_name
    end
    file_summaries << file_summary
  end
  file_summaries
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
  print total_file_summary[:total_line_count].to_s.rjust(8)
  unless command_options['l']
    print total_file_summary[:total_word_count].to_s.rjust(8)
    print total_file_summary[:total_bytesize_count].to_s.rjust(8)
  end
  print " total\n"
end

def output_file_summaries(command_options, file_summaries)
  file_summaries.each do |file_summary|
    print file_summary[:line_count].to_s.rjust(8)
    unless command_options['l']
      print file_summary[:word_count].to_s.rjust(8)
      print file_summary[:bytesize_count].to_s.rjust(8)
    end
    print " #{file_summary[:file_name].to_s.rjust(8)}\n"
  end

  return unless file_summaries.size > 1

  total_file_summary = calc_total_file_summary(file_summaries)
  output_total_file_summary(command_options, total_file_summary)
end

def output_text_summary(standard_input_string)
  print standard_input_string.count("\n").to_s.rjust(8)
  print standard_input_string.split(' ').size.to_s.rjust(8)
  print "#{standard_input_string.bytesize.to_s.rjust(8)}\n"
end

def wc_command
  has_input_from_pipe = File.pipe?($stdin)
  command_options = ARGV.getopts('l')
  if has_input_from_pipe
    standard_input_string = standard_input
    file_summary = calc_file_summary(standard_input_string)
    output_file_summary(command_options, file_summary)
  else
    file_names = ARGV
    if file_names.length.positive?
      file_summaries = calc_file_summaries(file_names)
      output_file_summaries(command_options, file_summaries)
    else
      standard_input_string = standard_input
      output_text_summary(standard_input_string)
    end
  end
end

wc_command
