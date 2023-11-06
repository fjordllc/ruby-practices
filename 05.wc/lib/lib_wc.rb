# frozen_string_literal: true

SPACE_NUMBER = 8

def run_wc(file_paths, option)
  option = { lines: true, words: true, bytes: true } if option.empty?
  file_paths.size > 1 ? wc_for_multiple_files(file_paths, option) : wc_for_single_file(file_paths[0], option)
end

def wc_for_multiple_files(file_paths, option)
  wc = []
  total_data = { lines: 0, words: 0, bytes: 0 }

  file_paths.each do |file_path|
    data = build_data(File.new(file_path).read)
    total_data[:lines] += data[:lines]
    total_data[:words] += data[:words]
    total_data[:bytes] += data[:bytes]
    body = render_body(data, option)
    wc << [body, file_path].join(' ')
  end
  total_body = "#{render_body(total_data, option)} total"
  wc << total_body
  wc.join("\n")
end

def wc_for_single_file(file_path, option)
  data = build_data(File.new(file_path).read)
  body = render_body(data, option)
  [body, file_path].join(' ')
end

def build_data(file_content)
  {
    lines: file_content.split("\n").size,
    words: file_content.split(/\s+/).size,
    bytes: file_content.bytesize
  }
end

def render_body(data, options)
  body = []
  body << data[:lines].to_s.rjust(SPACE_NUMBER) if options[:lines]
  body << data[:words].to_s.rjust(SPACE_NUMBER) if options[:words]
  body << data[:bytes].to_s.rjust(SPACE_NUMBER) if options[:bytes]
  body.join
end
