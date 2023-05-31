# frozen_string_literal: true

scores = ARGV
scores_change = [] # スコアを扱いやすい配列に変換
result = 0

# 配列の処理
scores.each do |score|
  if score != 'X'
    scores_change.push(score.to_i)
  elsif score == 'X'
    scores_change.push(10, 0)
  end
end
flames = scores_change.each_slice(2).to_a # 変換したスコアをフレーム毎に分割

if flames[9][0] == 10 # 10フレーム目の1投目がストライクの場合
  flames[9].delete_at(1)
  flames[9].push(*flames[10]) # 2投目と3投目を10フレーム目の配列に追加
  flames.delete_at(10)
  if flames[9][1] == 10 # 2投目もストライクの場合
    flames[9].delete_at(2)
    flames[9].push(flames[10][0]) # 3投目を10フレーム目の配列に追加
    flames.delete_at(10)
  end
elsif flames[9][0..1].sum == 10 # 2投目がスペアの場合
  flames[9].push(flames[10][0]) # 3投目を10フレーム目の配列に追加
  flames.delete_at(10)
end

# スコアの計算

result = flames.each_with_index.sum do |flame, i|
  next_flame = flames[i + 1]
  next_next_flame = flames[i + 2]
  if i == 9 # 10フレーム目の処理 
    flames[9][0..2].sum
  elsif flame[0] == 10 # 1~9フレーム目の処理 # ストライクの場合
    score = 10 + next_flame[0..1].sum
    score += next_next_flame[0] if next_flame[0] == 10 && i < 8 # 連続ストライクで次のフレーム2投目の値が存在しない（0）場合
    score
  elsif flame[0..1].sum == 10 # 1~9フレーム目の処理 # スペアの場合
    10 + next_flame[0]
  else # ストライク or スペア以外の場合
    flame[0..1].sum
  end
end

puts result

