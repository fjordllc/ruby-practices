# frozen_string_literal: true

require 'etc'

def get_files(path)
  Dir.entries(path).sort
end

def convert_with_option!(contents, option, path)
  unless option[:a]
    contents.reject! { |content| content.start_with?('.') } # hidden fileをcontentsから除外する。
  end

  return contents unless option[:l]

  convert_with_l_option!(contents, path)
end

def show_ls(contents)
  maximum_length = contents.max_by(&:length).length + 3
  height = contents.length.ceildiv(3)
  # 行のナンバリング
  (0...height).each do |h_num|
    # 列のナンバリング　今回は最大３列までなので最大３つまで表示したら次の行に折り返す。
    3.times do |w_num|
      contents_index = h_num + (height * w_num)
      print contents[contents_index].ljust(maximum_length) if !contents[contents_index].nil?
    end
    puts # ターミナル上で見栄えが悪いので改行。
  end
end

def convert_with_l_option!(contents, path)
  new_contents = []
  max_size_length = 0

  contents.each do |content|
    fs = File::Stat.new("#{path}/#{content}")
    size_length = fs.size.to_s.length
    max_size_length = size_length if size_length > max_size_length
    mode = convert_to_mode_symbol(fs.mode.to_s(8).rjust(6, '0'))
    new_contents << "#{mode} #{Etc.getpwuid(fs.uid).name} #{Etc.getgrgid(fs.gid).name} #{fs.size} #{fs.mtime} #{content}"
  end

  # 各行のファイルサイズを最大文字列長に合わせて整形
  new_contents.map! do |line|
    parts = line.split
    parts[3] = parts[3].rjust(max_size_length + 1)
    parts.join(' ')
  end
  new_contents
end

def convert_to_mode_symbol(octal_mode)
  file_map = {
    '010' => 'p',
    '020' => 'c',
    '040' => 'd',
    '060' => 'b',
    '100' => '-',
    '120' => '|',
    '140' => 's'
  }

  permission_map = {
    '7' => 'rwx',
    '6' => 'rw-',
    '5' => 'r-x',
    '4' => 'r--',
    '3' => '-wx',
    '2' => '-w-',
    '1' => '--x',
    '0' => '---'
  }
  "#{file_map[octal_mode[0..2]]}#{permission_map[octal_mode[3]]}#{permission_map[octal_mode[4]]}#{permission_map[octal_mode[5]]}@"
end
