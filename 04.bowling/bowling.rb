#!/usr/bin/env ruby

scores0 = ARGV[0]
scores1 = scores0.gsub(/X/,"10")
scores_array=scores1.split(",")

#1-9
n = 0
scores_array2 = []
while n < 9
  n += 1
  if scores_array[0] != "10"
    scores_array2 << [scores_array[0].to_i,scores_array[1].to_i]
    scores_array.slice!(0,2)
  else
    scores_array2 << [10,0]
    scores_array.slice!(0,1)
  end
end

#10
if scores_array[0] == "10"
  scores_array2 << [10,scores_array[1].to_i,scores_array[2].to_i]
elsif scores_array[0].to_i + scores_array[1].to_i == 10
  scores_array2 << [scores_array[0].to_i , scores_array[1].to_i , scores_array[2].to_i]
else
  scores_array2 << [scores_array[0].to_i , scores_array[1].to_i ,0]
end

n = 0
total = 0
while n < 9 do
if scores_array2[n][0] == 10 && scores_array2[n+1][0] == 10
  if n != 8
    total += 20 + scores_array2[n+2][0]
  else
    total += 20 + scores_array2[n+1][1]
  end
elsif
  if scores_array2[n][0] == 10
    total += 10 + scores_array2[n+1][0] + scores_array2[n+1][1]
  elsif scores_array2[n][0] + scores_array2[n][1] == 10
    total += 10 + scores_array2[n+1][0]
  else
    total += scores_array2[n][0] + scores_array2[n][1]
  end
end
    n += 1
end
total += scores_array2[9][0] + scores_array2[9][1] + scores_array2[9][2]

p total
