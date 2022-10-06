# frozen_string_literal: true

# add_bonus method
def add_bonus(pins, index)
  bonus = 0
  # spare,strike bonus
  bonus += pins[index + 2] if pins[index..index + 1].sum == 10
  # strike bonus
  if pins[index] == 10
    bonus += pins[index + 3]
    bonus += pins[index + 4] if pins[(index + 2)..(index + 3)] == [10, 0]
  end
  bonus
end

# get  input
pins = ARGV[0].split(',')
# convert X to [10,0]
pins.map! { |pin| pin == 'X' ? [10, 0] : pin.to_i }
p pins

index = 0
score = 10.times.sum do |frame|
  # 10th frame
  if frame == 9
    # add score
    pins[index..].sum
  # 1-9th frame
  else
    # get frame-th frame
    frame_pins = pins[index..index + 1]

    # nomal point + bonus
    frame_score = frame_pins.sum + add_bonus(pins, index)

    # increment
    index += 2
    frame_score
  end
end
puts score
