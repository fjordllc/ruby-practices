# frozen_string_literal: true

SPACE_NUMBER = 8

def run_wc(file_names, option)
  option = { lines: true, words: true, bytes: true } if option.empty? # wcコマンドが何もオプションを持たない場合、全てのオプションを指定したことにしている。
  file_names.size > 1 ? wc_for_multiple_files(file_names, option) : wc_for_single_file(file_names[0], option)
end

def wc_for_multiple_files(file_names, option)
  wc = []
  total_file_data = { lines: 0, words: 0, bytes: 0 }

  file_names.each do |file|
    file_data = build_file_data(File.new(file).read)
    total_file_data[:lines] += file_data[:lines]
    total_file_data[:words] += file_data[:words]
    total_file_data[:bytes] += file_data[:bytes]
    body = render_body(file_data, option)
    wc << [body, file].join(' ')
  end
  total = "#{render_body(total_file_data, option)} total"
  wc << total
  wc.join("\n")
end

def wc_for_single_file(file_name, option)
  file_data = build_file_data(File.new(file_name).read)
  body = render_body(file_data, option)
  [body, file_name].join(' ')
end

def build_file_data(file_content)
  {
    lines: file_content.split("\n").size,
    words: file_content.split(/\s+/).size,
    bytes: file_content.bytesize
  }
end

def render_body(file_data, options)
  body = []
  body << file_data[:lines].to_s.rjust(SPACE_NUMBER) if options[:lines]
  body << file_data[:words].to_s.rjust(SPACE_NUMBER) if options[:words]
  body << file_data[:bytes].to_s.rjust(SPACE_NUMBER) if options[:bytes]
  body.join
end
