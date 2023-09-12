#!/usr/bin/env ruby

# コマンドライン引数を受け取り、配列に格納
param_score_csv = []
$*.each do |argv|
  param_score_csv = argv.split(",")
end
# 点数を数値に変換
param_score_csv = param_score_csv.map{|n| n.to_i}
puts("each score: #{param_score_csv}")

# ボーリング計算
total_score = 0
param_score_csv.each {|score| total_score += score}

# 出力
puts("total score:#{total_score}")