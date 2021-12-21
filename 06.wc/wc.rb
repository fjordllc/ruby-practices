# frozen_string_literal: true

# TODO: lsの最終版のファイルにも一部不備があったので直す
# TODO lsの余白が若干違うせいでバイト数が合わない問題がある
require 'optparse'

def standard_input
  $stdin.read
end

def format_file_summary(input)
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
    print file_summary[:line_count].to_s.rjust(8).to_s
    print file_summary[:word_count].to_s.rjust(8).to_s
    print "#{file_summary[:bytesize_count].to_s.rjust(8)}\n"
  end
end

def format_file_summaries(file_names)
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

def output_total_file_summaries(command_options, file_summaries)
  total_file_summary = {
    'total_line_count': 0,
    'total_word_count': 0,
    'total_bytesize_count': 0
  }
  file_summaries.each do |file_summary|
    total_file_summary[:total_line_count] += file_summary[:line_count]
    total_file_summary[:total_word_count] += file_summary[:word_count]
    total_file_summary[:total_bytesize_count] += file_summary[:bytesize_count]
  end
  print total_file_summary[:total_line_count].to_s.rjust(8).to_s
  unless command_options['l']
    print total_file_summary[:total_word_count].to_s.rjust(8).to_s
    print total_file_summary[:total_bytesize_count].to_s.rjust(8).to_s
  end
  print " total \n"
end

def output_file_summaries(command_options, file_summaries)
  file_summaries.each do |file_summary|
    print file_summary[:line_count].to_s.rjust(8).to_s
    unless command_options['l']
      print file_summary[:word_count].to_s.rjust(8).to_s
      print file_summary[:bytesize_count].to_s.rjust(8).to_s
    end
    print " #{file_summary[:file_name].to_s.rjust(8)}\n"
  end

  output_total_file_summaries(command_options, file_summaries) if file_summaries.length > 1
end

def main
  has_input_from_pipe = File.pipe?($stdin)
  command_options = ARGV.getopts('l')
  # 標準入力がある場合
  # 標準入力を取得する
  # \nを数える
  # 出力内容から\nを消す
  # 出力内容を半角スペースでsplitしてカウントする
  # バイト数はbitesizeとかで求める
  # いい感じに整形して出力する
  if has_input_from_pipe
    # 標準入力を取得する
    standard_input_string = standard_input
    file_summary = format_file_summary(standard_input_string)
    output_file_summary(command_options, file_summary)
  else
    # 標準入力がない場合
    # ファイル名を取得する
    file_names = ARGV
    # 引数に受け取ったファイルの中身を取得する
    # 文字列を解析して、改行の数、単語数、バイト数をファイルごとに取得する
    file_summaries = format_file_summaries(file_names)
    # いい感じに整形して出力する
    output_file_summaries(command_options, file_summaries)
    # total_file_summary(file_summaries) if file_summaries.length > 1
  end
end

main
