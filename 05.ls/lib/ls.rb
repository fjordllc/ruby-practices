# frozen_string_literal: true

argument = ARGV
argument.push(Dir.pwd) if argument.size <= 0

# 指定ディレクトリの中のファイル情報を取得
def get_argument(directory)
  Dir.glob('*', base: directory)
end

# ファイルの最大の文字数の値を取得
def get_maximum_size(directory)
  argument_of_size = get_argument(directory).map(&:size)
  argument_of_size.max
end

# 3の倍数にファイルの要素数を調整
def complete_array(directory)
  numbers_of_files = get_argument(directory).size
  add_nil_to_files_name = get_argument(directory)
  if numbers_of_files % 3 != 0
    (3 - numbers_of_files % 3).times do
      add_nil_to_files_name.push(nil)
    end
  end
  add_nil_to_files_name
end

# 実際の出力に合わせて転置
def one_third_file(directory)
  one_third_mom = complete_array(directory).size / 3
  one_third_file = complete_array(directory).each_slice(one_third_mom).to_a
  one_third_file.transpose
end

# ３列になるとように出力
def output(directory)
  counters = 0
  one_third_file(directory).each do |files|
    files.each do |file|
      counters += 1
      if (counters % 3).zero? && !file.nil?
        puts file
      elsif counters % 3 != 0 && !file.nil?
        print file.ljust(get_maximum_size(directory) + 5)
      end
    end
  end
end

# 3倍＋１のファイル数の時に合わせて出力（ファイル数が、9個以上の時）
def output_files_size_is_special_big(directory)
  count = 0
  counters = 0
  one_third_file(directory)[0...-2].each do |files|
    files.each do |file|
      counters += 1
      # 3つごと出力
      if (counters % 3).zero? && !file.nil?
        puts file
      # 一番文字数の多いファイル+5に幅を合わせる
      elsif counters % 3 != 0 && !file.nil?
        print file.ljust(get_maximum_size(directory) + 5)
      end
    end
  end
  one_third_file(directory)[-2..].each do |files|
    files.each do |file|
      count += 1
      if (count % 4).zero?
        puts file
      elsif !file.nil?
        print file.ljust(get_maximum_size(directory) + 5)
      end
    end
  end
end

# 3倍＋１のファイル数の時に合わせて出力（ファイル数が、9個未満の時）
def output_when_files_size_is_special(directory)
  count = 0
  one_third_file(directory)[-2..].each do |files|
    files.each do |file|
      count += 1
      if (count % 4).zero?
        puts file
      elsif !file.nil?
        print file.ljust(get_maximum_size(directory) + 5)
      end
    end
  end
end

# 引数を一つまたは渡さない時の出力
def branch_output_type_when_argument_is_single(argument)
  argument.each do |directory|
    numbers_of_files = get_argument(directory).size
    if (numbers_of_files % 3) == 1 && one_third_file(directory).size >= 3
      output_files_size_is_special_big(directory)
    elsif (numbers_of_files % 3) == 1
      output_when_files_size_is_special(directory)
    else
      output(directory)
    end
  end
end

# 引数を2個以上渡した時の出力(改行を入れるため)
def branch_output_type_when_argument_is_multi(argument)
  argument.each_with_index do |directory, idx|
    last_numbers_of_files = get_argument(argument[idx - 1]).size
    numbers_of_files = get_argument(directory).size
    if (last_numbers_of_files % 3).zero? && argument.size >= 2 && idx >= 1
      puts ' '
    elsif idx >= 1 && last_numbers_of_files % 3 != 0 && argument.size >= 2
      puts ' '
      puts ' '
    end
    puts "#{directory}:"
    if (numbers_of_files % 3) == 1 && one_third_file(directory).size >= 3
      output_files_size_is_special_big(directory)
    elsif (numbers_of_files % 3) == 1
      output_when_files_size_is_special(directory)
    else
      output(directory)
    end
  end
end

if argument.size > 1
  branch_output_type_when_argument_is_multi(argument)
else
  branch_output_type_when_argument_is_single(argument)
end
