#!/usr/bin/env ruby
# 定数
STRIKE_SCORE = 10
MAX_FLAME = 10

#---------------------------
# フレーム分割処理
#---------------------------
def split_score_by_flame(scores)
  flame_count = 1
  # 返却用ハッシュ
  flame_to_scores = {}
  # スコア退避用
  store_score =[]
  # 2投目か判断
  is_second_throw = false

  # 分割処理
  scores.each do |score|
    # 最終フレーム用
    if(flame_count == MAX_FLAME)
      store_score.push(score)
    # フレーム最終投
    elsif(score==STRIKE_SCORE || is_second_throw)
      store_score.push(score)
      flame_to_scores[flame_count] = store_score
      flame_count += 1
      # クリア
      store_score = []
      is_second_throw = false
    else
      store_score.push(score)
      is_second_throw = true
    end
  end
  flame_to_scores[MAX_FLAME] = store_score
  flame_to_scores
end


#---------------------------
# メイン処理
#---------------------------
# コマンドライン引数を受け取り、配列に格納
param_score_csv = []
$*.each do |argv|
  param_score_csv = argv.split(",")
end
# 点数を数値に変換
param_score_csv = param_score_csv.map{|n| n.to_i}
puts("each score: #{param_score_csv}")

# フレームごとに分割
flame_to_scores = split_score_by_flame(param_score_csv)
puts(flame_to_scores)

# ボーリング計算
total_score = 0
param_score_csv.each {|score| total_score += score}

# 出力
puts("total score:#{total_score}")