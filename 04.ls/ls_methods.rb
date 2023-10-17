# frozen_string_literal: true

require 'etc'
COLUMN_NUMBER = 3
SPACE_NUMBER = 3

FILE_MAP = {
  '010' => 'p',
  '020' => 'c',
  '040' => 'd',
  '060' => 'b',
  '100' => '-',
  '120' => '|',
  '140' => 's'
}

PERMISSION_MAP = {
  '7' => 'rwx',
  '6' => 'rw-',
  '5' => 'r-x',
  '4' => 'r--',
  '3' => '-wx',
  '2' => '-w-',
  '1' => '--x',
  '0' => '---'
}

def get_files(path)
  Dir.entries(path).sort
end

def transform_by_option(contents, option, path)
  filtered_contents = contents.reject { |content| content.start_with?('.') }

  return transform_by_l(filtered_contents, path) if option[:l]

  filtered_contents
end

def show(contents)
  maximum_length = contents.max_by(&:length).length + SPACE_NUMBER # 本家lsコマンドに寄せたスペース幅に調整
  height = contents.length.ceildiv(COLUMN_NUMBER)

  (0...height).each do |h_num|
    COLUMN_NUMBER.times do |w_num|
      contents_index = h_num + (height * w_num)
      print contents[contents_index].ljust(maximum_length) if !contents[contents_index].nil?
    end
    puts # ターミナル上で見栄えが悪いので改行。
  end
end

def transform_by_l(contents, path)
  new_contents = []
  max_size_length = 0

  contents.each do |content|
    fs = File::Stat.new("#{path}/#{content}")
    size_length = fs.size.to_s.length
    max_size_length = size_length if size_length > max_size_length
    octal_mode = fs.mode.to_s(8).rjust(6, '0')
    mode = "#{FILE_MAP[octal_mode[0..2]]}#{PERMISSION_MAP[octal_mode[3]]}#{PERMISSION_MAP[octal_mode[4]]}#{PERMISSION_MAP[octal_mode[5]]}"
    time = "#{fs.mtime.month.to_s.rjust(2)} #{fs.mtime.mday.to_s.rjust(2)} #{fs.mtime.hour.to_s.rjust(2, '0')}:#{fs.mtime.min.to_s.rjust(2, '0')}"
    new_contents << [mode, fs.nlink.to_s.rjust(2), Etc.getpwuid(fs.uid).name, Etc.getgrgid(fs.gid).name, fs.size.to_s, time, content]
  end

  # 各行のファイルサイズを最大文字列長に合わせて整形
  formatted_new_contents = []
  new_contents.each do |content|
    content[4] = content[4].rjust(max_size_length + 1)
    formatted_new_contents << content.join(' ')
  end
  formatted_new_contents
end
