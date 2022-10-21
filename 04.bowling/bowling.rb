# frozen_string_literal: true

# add_bonus method
def add_bonus(pins, frame)
  bonus = 0

  # NEXT ball bonus (spare, strike)
  bonus += pins[frame + 1][0] if pins[frame].sum == 10

  # NEXT-NEXT bonus (strike)
  if pins[frame] == [10, 0]
    bonus += pins[frame + 1][1]
    bonus += pins[frame + 2][0] if pins[frame + 1] == [10, 0]
  end
  bonus
end

# get  input
pins_data = ARGV[0].split(',')
# convert X to [10,0]
pins_data.map! { |pin| pin == 'X' ? [10, 0] : pin.to_i }.flatten!
# frameでデータをパーケージする
pins = (pins_data).each_slice(2).to_a

score = 10.times.sum do |frame|
  # 10th frame
  if frame == 9
    pins[frame..].flatten.sum

  # 1-9th frame
  else
    # nomal point + bonus
    pins[frame].sum + add_bonus(pins, frame)
  end
end
puts score
