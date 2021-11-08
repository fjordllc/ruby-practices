puts(@final_sort_order)
		#引数が2個以上与えられた時、一つ目の出力と二つ目の出力の間に空行
    if idx >= 0 && argument.size >= 2
      puts '  '
      puts '  '
    end
  end
end

def make_jam(files_name)
	#3つに分割する際に、３で割り切れない時はnilで帳尻合わせ
  (3 - files_name.size % 3).times do 
	files_name.push(nil)
  end
	#3行に出力するためにファイル数を３つに均等に分割
  @one_third_mom = files_name.size / 3
  @one_third_file = files_name.each_slice(@one_third_mom).to_a
  @final_sort_order = @one_third_file.transpose
end

def outputs(_final_sort_order)
  count = 0
  @final_sort_order.each do |e|
    e.each do |f|
      count += 1
			#3つごと出力
      if (count % 3).zero? && !f.nil?
        puts f
			#一番文字数の多いファイル+5に幅を合わせる
      elsif count % 3 != 0 && !f.nil?
        print f.ljust(@maximum_size + 5)
      end
    end
  end
end

gets_argument(argument)
