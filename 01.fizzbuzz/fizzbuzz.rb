#! /usr/bin/env ruby

(1..20).each do |x|
	unless x%3==0||x%5==0
		puts x
	end
	if x%3==0&&x%5==0
		puts "FizzBuzz"
	end
	if x%3==0
		puts "Fizz" unless x%5==0
	end
	if x%5==0
			puts "Buzz" unless x%3==0
	end
end
