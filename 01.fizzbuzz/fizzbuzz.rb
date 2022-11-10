#!/usr/bin/env ruby

ReminderZero = 0

def fizzbuzz(start_num = 1 ,end_num = 20,fizz_num = 3,buzz_num = 5)
  (start_num..end_num).each do |x|
    if x % fizz_num == ReminderZero && x % buzz_num == ReminderZero
      puts "FizzBuzz"
    elsif x % fizz_num == ReminderZero
      puts "Fizz"
    elsif x % buzz_num == ReminderZero
      puts "Buzz"
    else
      puts x
    end
  end
end

fizzbuzz
