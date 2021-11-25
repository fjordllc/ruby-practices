# frozen_string_literal: true

argument = ARGV
argument.push(Dir.pwd) if argument.size <= 0

# ファイルの最大の文字数の値を取得
def get_maximum_size(filesname)
  argument_of_size = filesname.map(&:size)
  argument_of_size.max
end

# 3の倍数にファイルの要素数を調整
def complete_array(filesname)
  add_nil_to_array_of_files = filesname
  if add_nil_to_array_of_files.size % 3 != 0
    (3 - add_nil_to_array_of_files.size % 3).times do
      add_nil_to_array_of_files.push(nil)
    end
  end
  add_nil_to_array_of_files
end

# 実際の出力に合わせて転置
def one_third_file(filesname)
  one_third_mom = complete_array(filesname).size / 3
  one_third_file = complete_array(filesname).each_slice(one_third_mom).to_a
  one_third_file.transpose
end

# ３列になるとように出力
def output(filesname,maxsize_filesname)
  counters = 0
  one_third_file(filesname).each do |files|
    files.each do |file|
      counters += 1
      if (counters % 3).zero? && !file.nil?
        puts file
      elsif counters % 3 != 0 && !file.nil?
        print file.ljust(maxsize_filesname + 5) #+5は定数化する
      end
    end
  end
end

# 3倍＋１のファイル数の時に合わせて出力（転置後の配列の個数が3個以上の時）
def output_files_size_is_special_big(filesname,maxsize_filesname)
  count = 0
  counters = 0
  one_third_file(filesname)[0...-2].each do |files|
    files.each do |file|
      counters += 1
      # 3つごと出力
      if (counters % 3).zero? && !file.nil?
        puts file
      # 一番文字数の多いファイル+5に幅を合わせる
      elsif counters % 3 != 0 && !file.nil?
        print file.ljust(maxsize_filesname + 5)
      end
    end
  end
  one_third_file(filesname)[-2..].each do |files|
    files.each do |file|
      count += 1
      if (count % 4).zero?
        puts file
      elsif !file.nil?
        print file.ljust(maxsize_filesname + 5)
      end
    end
  end
end

# 3倍＋１のファイル数の時に合わせて出力（転置後の配列の個数が2つの時）
def output_when_files_size_is_special(filesname,maxsize_filesname)
    binding.irb
  count = 0
  one_third_file(filesname)[-2..].each do |files|
    files.each do |file|
      count += 1
      if (count % 4).zero?
        puts file
      elsif !file.nil?
        print file.ljust(maxsize_filesname + 5)
      end
    end
  end
end

def print_directory_name(directory)
  puts "#{directory}"
end

# 引数を2個以上渡した時の出力(改行を入れるため)
def branch_output_type_when_argument_is_multi(directory, multiple_argument,filesname)
  print_directory_name(directory)if multiple_argument
  numbers_of_files = filesname.size
  maxsize_filesname = get_maximum_size(filesname)
  if (numbers_of_files % 3) == 1 && one_third_file(filesname).size >= 3
    output_files_size_is_special_big(filesname,maxsize_filesname)
  elsif (numbers_of_files % 3) == 1
    output_when_files_size_is_special(filesname,maxsize_filesname)
  else
    output(filesname,maxsize_filesname)
  end
end

directories = argument
directories.each do |directory|
  filesname = Dir.glob('*', base: directory)
	branch_output_type_when_argument_is_multi(directory, directories.size > 1,filesname)
end