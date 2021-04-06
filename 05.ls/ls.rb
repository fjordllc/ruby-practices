# frozen_string_literal: true

require 'etc'
require 'optparse'

# -lオプションをつけない場合は、横に最大X列を維持して表示する
CULUMN_MAX_NUM = 3

def main
  begin
    # オプションの取得 ex. {"a"=>true, "l"=>false, "r"=>false}
    options = ARGV.getopts('a', 'l', 'r')
  rescue OptionParser::InvalidOption => e
    puts e.message
    exit
  end

  path_list = ARGV
  path_list.push '.' if path_list.empty?

  # path_list で指定されたファイル/ディレクトリをループで回す
  path_list.each do |target|
    # target がディレクトリの場合。FileとDirの配列を作る。
    result = get_list_files(target, option_a: options['a'], option_r: options['r'])

    # target がファイルの場合。result が空配列なので、result にはファイル名を入れる
    result << target if result.empty?

    # 出力。target が複数ある場合は改行を入れる
    output_new_line(path_list.size)

    # 出力。l オプションがある場合は result の各要素を key にした hash を作って出力する
    if options['l']
      result_l = {}
      result.each { |file| result_l[file] = get_file_stat(target, file) }
      output_l(result_l)
    else
      output(result)
    end
  end
end

def get_list_files(path, option_a: false, option_r: false)
  # path が file だった場合、空配列が返る

  # a オプションがあれば（なければ）、 dotファイル追加（は含めない）
  list_file = option_a ? Dir.glob('*', File::FNM_DOTMATCH, base: path) : Dir.glob('*', base: path)
  list_file.sort!

  # r オプションがあれば、reverse する
  option_r ? list_file.reverse : list_file
end

def get_file_stat(path, file_name)
  # path と file が同じ場合はどちらか片方。
  # path と file が異なる場合は連結する。
  file_path = path == file_name ? file_name : "#{path}/#{file_name}"

  fs = File::Stat.new(file_path)

  type = convert_type(fs.ftype)
  mode = convert_permission(fs.mode.to_s(8).to_i % 1000)
  size = fs.size
  nlink = fs.nlink

  date_time = fs.mtime.localtime
  month = date_time.strftime('%b')
  day = date_time.day
  time = date_time.strftime('%H:%M')

  uid = Etc.getpwuid(fs.uid).name
  gid = Etc.getgrgid(fs.gid).name

  block = fs.blocks

  # 1~8番目は必須の要素。9番目以降は追加情報
  [type + mode, nlink, uid, gid, size, month, day, time, block]
end

def convert_type(type)
  {
    'file' => '-',
    'directory' => 'd',
    'characterSpecial' => 'c',
    'blockSpecial' => 'b',
    'fifo' => 'p',
    'link' => 'l',
    'socket' => 's'
  }[type]
end

def convert_permission(number)
  permissions = {
    '7' => 'rwx',
    '6' => 'rw-',
    '5' => 'r-x',
    '4' => 'r--',
    '3' => '-wx',
    '2' => '-w-',
    '1' => '--x',
    '0' => '---'
  }

  a = []
  number.to_s.chars.each { |char| a << permissions[char] }
  a.join
end

def output_new_line(num)
  puts "\n" if num > 1
end

def output(array)
  # 行数の決定
  arr_size_div = array.size.div(CULUMN_MAX_NUM)
  row_num = (array.size % CULUMN_MAX_NUM).zero? ? arr_size_div : arr_size_div + 1

  # 配列における、各要素の文字列長の最大値 max_str を作る。
  # ex. ["hoge.txt", "foo.txt", "README.md"] => 9
  max_str = 0
  array.each do |item|
    item_size = item.to_s.size
    max_str = item_size if max_str < item_size
  end

  # row_num行 CULUMN_MAX_NUM列の行列において、列方向に array の要素を順次代入していく
  output = Array.new(row_num) { [] }
  array.each_with_index do |item, index|
    output[index % row_num] << item
  end

  # format して出力
  output.each_index do |index|
    size = output[index].size
    format_str = "%-#{max_str}s " * size
    puts format(format_str, *output[index]) unless size.zero?
  end
end

def output_l(hash)
  # hash の中の配列のサイズ(すべて同一)を取得
  array_size = 0
  hash.each_value do |value|
    array_size = value.size
    break unless array_size.zero?
  end

  # hashの各value(配列)における、各要素の文字列長の
  # 最大値の配列 max_length_list を作る。
  # ex. {foo => ["foo.txt", "bar.txt"], bar => ["foo.rb", foo_bar.rb]} => [7, 10]
  max_length_list = Array.new(array_size) { 0 }

  hash.each_value do |array|
    array.each_with_index do |item, index|
      item_size = item.to_s.size
      max_length_list[index] = item_size if max_length_list[index] < item_size
    end
  end

  # total の出力
  # hash の中の配列の9番目(block)の合計
  total = 0
  hash.each_value { |array| total += array[8] }
  puts "total #{total}"

  # format して出力。ファイル情報の出力
  # max_length_list のうち、ファイル情報出力で利用するのは 1~8番目
  format_str = "%#{max_length_list.slice(0..7).join('s %')}s %s"
  hash.each do |key, value|
    puts format(format_str, *value.slice(0..7), key)
  end
end

main
