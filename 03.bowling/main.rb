#!/usr/bin/env ruby
# 定数
STRIKE_SCORE = 10
FIRST_FLAME = 1
LAST_FLAME = 10

#---------------------------
# フレーム分割処理
#---------------------------
def split_score_by_flame(scores)
  flame_count = FIRST_FLAME
  # 返却用ハッシュ
  flame_to_scores = {}
  # スコア退避用
  store_score =[]
  # 2投目か判断
  is_second_throw = false

  # 分割処理
  scores.each do |score|
    # 最終フレーム用
    if(flame_count == LAST_FLAME)
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
  flame_to_scores[LAST_FLAME] = store_score
  flame_to_scores
end

#---------------------------
# ボーリング計算処理
#---------------------------
def calc_score(flame_to_scores)
  #　返却用
  flame_to_total = {}
  is_strike = false
  is_spare = false
  # 以下ループ
  FIRST_FLAME.upto(LAST_FLAME) do |flame_count|
    # 投目カウント
    ball_count = 0
    # 点数群を受け取る
    scores = flame_to_scores[flame_count]
    scores.each do |score|
      # -------------
      # 前フレームへの処理
      # -------------
      # 前フレームがストライクの場合
      if is_strike && ball_count < 2
        flame_to_total[flame_count-1] += score
      end
      # 前フレームがスペアの場合
      if is_spare && ball_count < 1
        flame_to_total[flame_count-1] += score
      end
      
      # -------------
      # 今フレームへの処理
      # -------------
      # 点数を合計
      if flame_to_total[flame_count].nil?
        flame_to_total[flame_count] = score
      else
        flame_to_total[flame_count] += score
      end
      ball_count += 1
    end
    # フレームごとの後処理
    if flame_to_total[flame_count] == STRIKE_SCORE && ball_count==1
      is_strike = true
      is_spare = false
    elsif flame_to_total[flame_count] == STRIKE_SCORE
      is_strike = false
      is_spare = true 
    else
      is_strike = false
      is_spare = false
    end
    # クリア
    ball_count = 0
  end
  # 返却
  flame_to_total
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
p("each score : #{param_score_csv}")

# フレームごとに分割
flame_to_scores = split_score_by_flame(param_score_csv)
p("flame score: #{flame_to_scores}")

# ボーリング計算
total_score = 0
flame_to_total = calc_score(flame_to_scores)

# 出力
puts("total score : #{flame_to_total}")
