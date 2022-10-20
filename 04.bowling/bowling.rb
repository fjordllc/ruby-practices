#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

def convert_strikes_to_ten(scores)
  shots = []
  scores.each do |s|
    if s == 'X'
      shots << 10
      shots << 0
    else
      shots << s.to_i
    end
  end
  shots # 戻り値
end

shots = convert_strikes_to_ten(scores)

# shotsを２投ずつか、ストライクが出ている場合は１投ずつで区切る
def divide_pithces(shots)
  # ２投ずつで区切る
  divided_scores = []
  shots.each_slice(2) do |s|
    divided_scores << s
  end
  # ストライクが出たフレームは１投で区切るようにpopを使う
  divided_scores.each do |array|
    array.pop if array[0] == 10
  end
  divided_scores # 戻り値
end

divided_scores = divide_pithces(shots)

# divided_scoresにindexをつけて、何フレーム目かを分かりやすくする
def divided_scores_w_idx(divided_scores)
  divided_scores_w_idx = []
  divided_scores.each_with_index do |s, f|
    divided_scores_w_idx << [s, f]
  end
  divided_scores_w_idx # 戻り値
end

scores_w_idx = divided_scores_w_idx(divided_scores)

# スコアの計算をする
def calculate_scores(scores_w_idx)
  sum_score = 0
  (0..scores_w_idx.size - 1).each do |n|
    current_score = scores_w_idx[n][0]
    next_score = scores_w_idx[n + 1][0] if scores_w_idx[n][1] + 1 < 10

    if scores_w_idx[n][1] + 1 >= 10 # １０フレーム目の計算
      sum_score += current_score.sum
    elsif current_score[0] == 10 # ストライク
      if next_score[0] == 10 # 連続ストライク
        sum_score += 10 + next_score[0] + scores_w_idx[n + 2][0][0]
      else
        sum_score += 10 + next_score.sum
      end
    elsif current_score.sum == 10 # スペア
      sum_score += 10 + next_score[0]
    else
      sum_score += current_score.sum
    end
  end
  sum_score # 戻り値
end

p calculate_scores(scores_w_idx)
