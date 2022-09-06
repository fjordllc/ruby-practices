#!/usr/bin/env ruby

score = ARGV[0]
score_list = score.split(',')
shots = []
score_list.each do |i|
  if i=='X'
    shots << 10
    shots << 0
  else
    shots << i.to_i
  end
end
flame_list = []
shots.each_slice(2) do |shot|
  flame_list << shot
end
flame_list_modified = []
if flame_list.count > 10
  flame_sep_after_list = flame_list.slice(9..)
  flame_sep_after_list.flatten!.delete(0)
  flame_list_modified = flame_list.slice(0..8)
  flame_list_modified << flame_sep_after_list
else
  flame_list_modified = flame_list
end
flame_count = 0
strike_cont = 0 # 0 (ストライクなし) or 1 (単独ストライク) or 2 (連続ストライク)
spare_cont = 0 # 0 (スペアなし) or 1 (スペアあり)
score = 0
flame_list_modified.each do |flame| 
  flame_count += 1
  if flame_count == 10 # Last Frame
    if strike_cont == 0
        score += flame.sum + flame[0] * spare_cont
    else
        score += flame.sum + flame[0] * strike_cont + flame[1]
    end
  elsif flame[0] == 10 # Strike
    score += 10 + 10 * strike_cont + 10 * spare_cont
    if strike_cont == 0
        strike_cont = 1
    else
        strike_cont = 2
    end
    spare_cont = 0
  else
    if strike_cont == 0
        score += flame.sum + flame[0] * spare_cont
    else
        score += flame.sum + flame[0] * strike_cont + flame[1] 
    end
    strike_cont = 0
    if flame.sum == 10 # spare
      spare_cont = 1
    else
      spare_cont = 0
    end
  end
end

p score