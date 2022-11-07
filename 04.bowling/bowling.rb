# frozen_string_literal: true

THROW_NUM = ARGV[0].split(',')
current_num = 0
total_score = []

def tenframe(total_score, framecount, current_num)
  total_score[framecount] = if THROW_NUM[current_num] == 'X'
                              if THROW_NUM[current_num + 1] == 'X' && THROW_NUM[current_num + 2] == 'X'
                                30
                              elsif THROW_NUM[current_num + 1] == 'X'
                                20 + THROW_NUM[current_num + 2].to_i
                              else
                                10 + THROW_NUM[current_num + 1].to_i + THROW_NUM[current_num + 2].to_i
                              end
                            elsif THROW_NUM[current_num].to_i + THROW_NUM[current_num + 1].to_i == 10
                              10 + THROW_NUM[current_num + 2].to_i
                            else
                              THROW_NUM[current_num].to_i + THROW_NUM[current_num + 1].to_i
                            end
end

10.times do |framecount|
  if framecount < 9
    if THROW_NUM[current_num] == 'X'
      total_score[framecount] = if THROW_NUM[current_num + 1] == 'X' && THROW_NUM[current_num + 2] == 'X'
                                  30
                                elsif THROW_NUM[current_num + 1] == 'X'
                                  20 + THROW_NUM[current_num + 2].to_i
                                else
                                  10 + THROW_NUM[current_num + 1].to_i + THROW_NUM[current_num + 2].to_i
                                end
      current_num += 1
    else
      total_score[framecount] = THROW_NUM[current_num].to_i + THROW_NUM[current_num + 1].to_i
      current_num += 2
    end

    if total_score[framecount] == 10
      total_score[framecount] += if THROW_NUM[current_num] == 'X'
                                   10
                                 else
                                   THROW_NUM[current_num].to_i
                                 end
    end
  else
    tenframe(total_score, framecount, current_num)
  end
end

puts total_score.inject(:+)
