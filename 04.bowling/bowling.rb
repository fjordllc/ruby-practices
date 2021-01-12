# frozen_string_literal: true

score = ARGV[0]
scores = score.chars

frames = []
frame = []

scores.each do |s|
  frame << if s == "X" # もし引数にXがあったら10点にする
    10
  else
    s.to_i # Xではないものを文字列から数字に変換
  end

  if frame.count == 1 && frame == [10] # 1投目で10本倒れたとき
    frames << frame # framesにframeを代入
    frame = []
  end

  if frame.count == 2 # 2球投げたら
    frames << frame # framesにframeを代入
    frame = []
  end
end

point = 0
frames.each_with_index do |f, i|
  point += if i <= 7 # 1~8フレームの処理
      if frames[i][0] == 10 && frames[i + 1][0] == 10 && frames[i + 2][0] == 10 # 3連続ストライクの場合
        30 # 3ストライク分のポイント
      elsif frames[i][0] == 10 && frames[i + 1][0] == 10 # 2連続ストライクの場合
        20 + frames[i + 2][0] # 2ストライク分のポイント + 次の次のフレームの1投目
      elsif frames[i][0] == 10 # 連続しないストライクの場合
        10 + frames[i + 1][0] + frames[i + 1][1] # 10 + 次のフレームの1投目 + 次のフレームの2投目
      elsif f.sum == 10 && frames[0] != 10 # スペアの場合
        10 + frames[i + 1][0]
      else # その他の場合
        f.sum
      end
    elsif i == 8 # 9フレームの処理
      if frames[i][0] == 10 && frames[i + 1][0] == 10 && frames[i + 1][1] == 10 # 3連続ストライクの場合
        30 # 3ストライク分のポイント
      elsif frames[i][0] == 10 && frames[i + 1][0] == 10 # 2連続ストライクの場合
        20 + frames[i + 1][1] # 2ストライク分のポイント + 次の次のフレームの1投目
      elsif frames[i][0] == 10 # 連続しないストライクの場合
        10 + frames[i + 1][0] + frames[i + 1][1] # 10 + 次のフレームの1投目 + 次のフレームの2投目
      elsif f.sum == 10 && frames[0] != 10 # スペアの場合
        10 + frames[i + 1][0]
      else # その他の場合
        f.sum
      end
    else # 10フレーム目の処理
      f.sum # 配列の中を足すだけ
    end
end

# １０フレームの配列処理
if frames[9] == [10] && frames[10] == [10] && frames[11] == [10] # 3連続ストライクの場合
  frames[9].concat frames[10] + frames[11] # フレームの結合
  frames.delete_at(10) # 結合以降のフレームの削除
  frames.delete_at(10)
elsif frames[9] == [10] && frames[10] == [10] # 2連続ストライクの場合
  frames[9].concat frames[10] # フレームの結合
  frames[9] << scores[-1].to_i # 12フレームの追加
  frames.delete_at(10) # 結合以降のフレームの削除
elsif frames[9] == [10] # 連続ストライクしないストライク
  frames[9].concat frames[10] # フレームの結合
  frames.delete_at(10) # 結合以降のフレームの削除
elsif frames[9] != [10] && frames[9].sum == 10 # 10フレームの1投+2投がスペア、3投目を追加
  frames[9] << scores[-1].to_i # 11フレームの追加
  frames.delete_at(10) # 結合以降のフレームの削除
elsif frames[9] != [10] && frames[9].sum == 10 && frames[10] == [10] # 10フレームの1投+2投がスペア、3投目がストライクの場合
  frames[9] << scores[-1].to_i  # 11フレームの追加
  frames.delete_at(10)
end
p frames
puts point
