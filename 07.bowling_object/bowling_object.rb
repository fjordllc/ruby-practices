# frozen_string_literal: true

score = ARGV[0]
shot = []
score.chars.each do |s|
  if s == 'X'
    shot << 10
    shot << 0
  else
    shot << s.to_i
  end
end

flames = []
shot.each_slice(2) do |s|
  flames << s
end

if flames.size == 11
  last_flame = flames.pop(2)
  flames << last_flame[0] + last_flame[1]
  flames.last.delete_if { |l| l == 0 }
end

if flames.size == 12
  last_flame = flames.pop(3)
  flames << last_flame[0] + last_flame[1] + last_flame[2]
  flames.last.delete_if { |l| l == 0 }
end

point = 0
flames.each_with_index do |x, idx|
  if x.size == 3 # 10フレーム目
    point += x.sum
  elsif x[0] == 10 # strike
    idx += 1
    strike = flames[idx]
    point += 10 + strike[0] + strike[1]
  elsif x.sum == 10 # spare
    idx += 1
    spare = flames[idx]
    point += 10 + spare[0]
  else
    point += x.sum
  end
end
puts point
