#!/usr/bin/env ruby

score_list = ARGV[0].split(',')
shots = []
score_list.each do |i|
  if i == 'X'
    shots << 10
    shots << 0
  else
    shots << i.to_i
  end
end
frame_list = []
shots.each_slice(2) do |shot|
  frame_list << if shot[0] == 10
                  [shot[0]]
                else
                  shot
                end
end
frame_list_modified = []
if frame_list.count > 10
  frame_sep_after_list = frame_list.slice(9..)
  frame_sep_after_list.flatten!
  frame_list_modified = frame_list.slice(0..8)
  frame_list_modified << frame_sep_after_list
else
  frame_list_modified = frame_list
end
frame_count = 0
strike_cont = 0 # 0 (ストライクなし) or 1 (単独ストライク) or 2 (連続ストライク)
spare_count = 0 # 0 (スペアなし) or 1 (スペアあり)
score = 0
frame_list_modified.each do |frame|
  frame_count += 1
  if frame_count == 10 # Last Frame
    score += if strike_cont.zero?
               frame.sum + frame[0] * spare_count
             else
               frame.sum + frame[0] * strike_cont + frame[1]
             end
  elsif frame[0] == 10 # Strike
    score += 10 + 10 * strike_cont + 10 * spare_count
    strike_cont = strike_cont.zero? ? 1 : 2
    spare_count = 0
  else
    score += if strike_cont.zero?
               frame.sum + frame[0] * spare_count
             else
               frame.sum + frame[0] * strike_cont + frame[1]
             end
    strike_cont = 0
    spare_count = frame.sum == 10 ? 1 : 0
  end
end

p score

