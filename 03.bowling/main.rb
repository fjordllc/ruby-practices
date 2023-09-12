#!/usr/bin/env ruby

# コマンドライン引数を受け取り、配列に格納
param_score_csv = []
$*.each do |argv|
  param_score_csv = argv.split(",")
end
puts param_score_csv

# ボーリング計算


# 出力