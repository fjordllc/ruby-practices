#!/Users/iwamurahiroshi/.rbenv/shims/ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

scores_translated_to_integer = []
scores.each do |s|
  if s == 'X'
    scores_translated_to_integer.push(10)
    scores_translated_to_integer.push(0) if scores_translated_to_integer.size < 18
  else
    scores_translated_to_integer.push(s.to_i)
  end
end

scores_each_frame = []
scores_translated_to_integer.each_slice(2) do |s|
  if scores_each_frame.size == 10
    scores_each_frame[9].concat(s)
  else
    scores_each_frame.push(s)
  end
end

total = 0
scores_each_frame.each.with_index(1) do |s, i|
  total +=
    if i <= 9 && s[0] == 10
      if scores_each_frame[i][0] == 10 && i <= 8
        s.sum + scores_each_frame[i][0] + scores_each_frame[i + 1][0]
      else
        s.sum + scores_each_frame[i][0] + scores_each_frame[i][1]
      end
    elsif i <= 9 && (s[0] + s[1] == 10)
      s.sum + scores_each_frame[i][0]
    else
      s.sum
    end
end

puts total
