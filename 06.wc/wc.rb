#!/usr/bin/env ruby
# frozen_string_literal: true
class Command
  def wc_default(files) #オプションなしの出力
    file_extraction(files).each do |file|
        puts "      #{file[:n_lines]}      #{file[:words]}     #{file[:byte_size]} #{file[:file_name]}"
    end
  end

  def l_opt(files)
    file_extraction(files).each do |file|
      puts "      #{file[:n_lines]} #{file[:file_name]}"
    end
  end

  def didnot_get_file(l: nil)
    content = $stdin.read
    file = {
    n_lines: content.count("\n"), #行数
    words: content.split(' ').length, #単語数
    byte_size: content.bytesize, #バイトサイズ
    }
    if l
      puts "      #{file[:n_lines]}"
    else
      puts "       #{file[:n_lines]}      #{file[:words]}     #{file[:byte_size]}"
    end
  end

  private

  def file_extraction(files)
    files_wc = files.map.with_index do |file, i|
    content = File.read(file)
    {
    n_lines: content.count("\n"), #行数
    words: content.split(' ').length, #単語数
    byte_size: content.bytesize, #バイトサイズ
    file_name: files[i]
    }
    end
  end

end

if $PROGRAM_NAME == __FILE__
  require 'optparse'
  opt = OptionParser.new

  params = {}

  opt.on('-l') { |v| params[:l] = v }

  opt.parse!(ARGV)
  files = ARGV

  command_receiver = Command.new
  if params[:l] && !ARGV.empty?
    command_receiver.l_opt(files)
  elsif ARGV.empty?
    command_receiver.didnot_get_file(**params)
  else
    command_receiver.wc_default(files)
  end
end
