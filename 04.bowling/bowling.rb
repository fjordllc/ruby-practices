# frozen_string_literal: true
SPARE = 1
STRIKE = 2

# add_bonus method
def add_bonus(pins, i, frame = -1)
  # what kind of bonus?
  bonus_flag = 0
  if pins[i] == 10
    bonus_flag = STRIKE
  elsif pins[i..i+1].sum == 10
    bonus_flag = SPARE
  end

  bonus = 0
  # spare bonus
  bonus += pins[i + 2] if bonus_flag == SPARE
  # strike bonus
  bonus += pins[(i + 1)..(i + 2)].sum if bonus_flag == STRIKE
  bonus
end

# get input
pins = ARGV[0].split(',')
# convert X to 10
pins.size.times {|n| pins[n] = 10 if pins[n] == "X"} 
pins.map!{|x| x.to_i}

score = 0
i = 0
10.times do |frame|
  # 10th frame
  if frame == 9
    score += pins[i..i+2].sum
  # 1-9th frame
  else
    # get frame-th frame  
    frame_pins = []
    frame_pins[0] = pins[i]
    frame_pins[1] = pins[i + 1] if pins[i] != 10
    
    # nomal point
    score += frame_pins.sum
    # add bonus
    score += add_bonus(pins, i, frame)

    # increment   
    i += 1 if pins[i] != 10
    i += 1
  end
end

puts score
