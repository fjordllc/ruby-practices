# frozen_string_literal: true

argument = ARGV
argument.push(Dir.pwd) if argument.size <= 0

# \""を取り除くのは別メソッドでいいかも？
# 引数を何個でも受け取りたい
def gets_argument(argument)
  counter = 0
  argument.each do |p|
    counter += 1
    get_file = Dir.glob('*', base: p)
    argument_of_size = get_file.map(&:size)
    @maximum_size = argument_of_size.max
    puts "#{p}:" if argument.size > 1
    make_jam(get_file)
    out_puts(@final_sort_order)
    if counter == 1 && argument.size >= 2
      puts '  '
      puts '  '
    end
  end
end

# 3列に多重配列は作成
def make_jam(get_file)
  case get_file.size % 3
  when 1
    2.times do
      get_file.push(nil)
    end
  when 2
    get_file.push(nil)
  end
  @one_third_mom = get_file.size / 3
  @one_third_file = get_file.each_slice(@one_third_mom).to_a
  @final_sort_order = @one_third_file.transpose
end

# 3列ごとに出力
def out_puts(_final_sort_order)
  count = 0
  @final_sort_order.each do |e|
    e.each do |f|
      count += 1
      if (count % 3).zero? && !f.nil?
        puts f
      elsif count % 3 != 0 && !f.nil?
        print f.ljust(@maximum_size + 5)
      end
    end
  end
end
gets_argument(argument)
