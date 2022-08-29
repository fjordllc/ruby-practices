#!/usr/bin/env ruby

score = ARGV[0]
scoreList = score.split(',')
shots = []
scoreList.each do |i|
    if i=='X'
        shots << 10
    else
        shots << i.to_i
    end
end
flameList = []
shots.each_slice() |i| do
