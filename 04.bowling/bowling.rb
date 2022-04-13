# frozen_string_literal: true

# xto10 method
def xto10(pin)
  if pin == 'X'
    10.to_i
  else
    pin.to_i
  end
end

# add_bonus method
def add_bonus(bonus, pins, index)
  score = 0
  # add spare-strike bonus
  score += xto10(pins[index]) if [1, 2].include?(bonus)
  # add strike bonus
  score += xto10(pins[index + 1]) if bonus == 2
  score.to_i
end

def update_bonus(pins, index)
  return 1 if pins[index].to_i + pins[index + 1].to_i == 10
end

# MAIN
pins = ARGV[0].split(',')
score = 0
bonus = 0
frame = 0
flg = true
i = 0
while flg
  # 10th frame process
  if frame == 9
    # nomal point
    frame_pins = []
    frame_pins[0] = xto10(pins[i])
    frame_pins[1] = xto10(pins[i + 1])
    frame_pins[2] = xto10(pins[i + 2])
    score += frame_pins.sum
    # add bonus
    score += add_bonus(bonus, pins, i)
    break
  # 0-8th frame process
  else
    # 数値なら加算
    if pins[i] =~ /^[0-9]+$/
      # nomal point
      frame_pins = []
      frame_pins[0] = xto10(pins[i])
      frame_pins[1] = xto10(pins[i + 1])
      score += frame_pins.sum
      # add bonus
      score += add_bonus(bonus, pins, i)
      # UPDATE VARIABLE
      bonus = 0
      # spare bonus flag
      bonus = update_bonus(pins, i)
      i += 2
      # NOT数値　→ 文字X ストライク処理
    else
      score += 10
      # add bonus
      score += add_bonus(bonus, pins, i)
      # UPDATE VARIABLE
      bonus = 2
      i += 1
    end
    frame += 1
  end
end
puts score
