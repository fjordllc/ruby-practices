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
scores_flame = scores_change.each_slice(2).to_a # 変換したスコアをフレーム毎に分割

if scores_flame[9][0] == 10 # 10フレーム目の1投目がストライクの場合
  scores_flame[9].delete_at(1)
  scores_flame[9].push(*scores_flame[10]) # 2投目と3投目を10フレーム目の配列に追加
  scores_flame.delete_at(10)
  if scores_flame[9][1] == 10 # 2投目もストライクの場合
    scores_flame[9].delete_at(2)
    scores_flame[9].push(scores_flame[10][0]) # 3投目を10フレーム目の配列に追加
    scores_flame.delete_at(10)
  end
elsif scores_flame[9][0..1].sum == 10 # 2投目がスペアの場合
  scores_flame[9].push(scores_flame[10][0]) # 3投目を10フレーム目の配列に追加
  scores_flame.delete_at(10)
end

# スコアの計算
result = scores_flame.each_with_index.sum do |score, i|
  if scores_flame[9][0] == 10 # 10フレーム目の処理 
    scores_flame[9][0..2].sum
  elsif score[0] == 10  # 1~9フレーム目の処理 # ストライクの場合
    if scores_flame[i + 1][0] == 10 && i < 8 # 連続ストライクで次のフレーム2投目の値が存在しない（0）場合は、次の次のフレームの1投目の値を加算
      add_score = scores_flame[i + 2][0]
    end
    10 + scores_flame[i + 1][0..1].sum + add_score.to_i  # 次の1,2投目とIFの追加スコアを加算
  elsif score[0..1].sum == 10 # スペアの場合
    10 + scores_flame[i + 1][0]
  else # ストライク or スペア以外の場合
    score[0] + score[1]
  end
end

puts result
