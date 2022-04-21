#!/usr/bin/env ruby

lists_first_throws  = []
lists_second_throws = []
bonuses             = []
i                   = 0

(1..10).each do |current_frame|
  if ARGV[0].split(",")[i] == "X"
    lists_first_throws.push(10)
    lists_second_throws.push(0)
    bonus1 =  ARGV[0].split(",")[i + 1] == "X" ? 10 : ARGV[0].split(",")[i + 1].to_i
    bonus2 =  ARGV[0].split(",")[i + 2] == "X" ? 10 : ARGV[0].split(",")[i + 2].to_i
    bonuses.push(bonus1 + bonus2)
    i += 1
  else
    lists_first_throws.push(ARGV[0].split(",")[i].to_i)
    lists_second_throws.push(ARGV[0].split(",")[i + 1].to_i)
    if ARGV[0].split(",")[i].to_i + ARGV[0].split(",")[i + 1].to_i == 10
      bonus =  ARGV[0].split(",")[i + 2] == "X" ? 10 : ARGV[0].split(",")[i + 2].to_i
      bonuses.push(bonus)
    else
      bonuses.push(0)
    end
    i += 2
  end
end

puts lists_first_throws.sum + lists_second_throws.sum + bonuses.sum
