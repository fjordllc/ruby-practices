# frozen_string_literal: true

# add_bonus method
def add_bonus(pins, index, frame = -1)
  bonus = 0
  # spare bonus
  bonus += pins[index + 2] if pins[index..index + 1].sum == 10
  # strike bonus
  bonus += pins[(index + 1)..(index + 2)].sum if pins[index] == 10
  bonus
end

# get input
pins = ARGV[0].split(',')
# convert X to 10s
pins.map!{|pin| pin == "X" ? 10 : pin} 
pins.map!(&:to_i)

score = 0
index = 0
10.times.sum do |frame|
  # 10th frame
  if frame == 9
    score += pins[index..].sum
  # 1-9th frame
  else
    # get frame-th frame  
    frame_pins = []
    frame_pins[0] = pins[index]
    frame_pins[1] = pins[index + 1] if pins[index] != 10
    
    # nomal point
    score += frame_pins.sum
    # add bonus
    score += add_bonus(pins, index, frame)

    # increment   
    index += 1 if pins[index] != 10
    index += 1
  end
end
puts score
