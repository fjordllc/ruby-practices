argument = []
argument = ARGV
if argument.size <= 0
	argument.push(Dir.pwd)
end

#\""を取り除くのは別メソッドでいいかも？
#引数を何個でも受け取りたい
def gets_argument(argument)
	counter = 0
  argument.each do |v|
		counter += 1
		test = Dir.glob('*',base: v)
		maximum = test.map {|b|b.size}
		@s = maximum.max
		if argument.size > 1
			puts "#{v}:"	
		end
		make_jam(test)
		out_puts(@w)
		if counter == 1 && argument.size >= 2 
			puts "  "
			puts "  "
		end
	end
end
	
		#3列に多重配列は作成
def make_jam(test)
	if test.size % 3 == 1
		2.times do 
			test.push(nil)
		end
	elsif test.size % 3 == 2
		1.times do 
			test.push(nil)
		end
	end
	@h = test.size / 3
	@b = test.each_slice(@h).to_a
	@w = @b.transpose
end

#3列ごとに出力
def out_puts(w)
	count = 0
	@w.each do |e|
		e.each do |f|
			count += 1
			if count % 3 == 0 && f != nil
				puts f
			elsif count % 3 != 0 && f != nil
				print f.ljust(@s + 5)
			end
		end
	end
end
gets_argument(argument)
