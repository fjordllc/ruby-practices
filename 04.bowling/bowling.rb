# frozen_string_literal: true

FLAG = -1

# X は 10 に変換。それ以外は integer にして返す
def convert_point_to_int(point)
  return 10 if point == 'X'

  point.to_i
end

# 与えられた現在のスコアから、各フレームを最初から確認
# FLAG (= -1)があれば、最初の FLAG を point に置換する
def convert_flag_to_point(score, point)
  score.each do |frame|
    frame[frame.index(FLAG), 1] = point and next if frame.include?(FLAG)
  end
end

# コマンドラインから結果読み取り
points = ARGV.first.split(',')

# スコア初期化。すべてストライクの場合を考慮すると、拡張して最大は 12 フレーム
score = Array.new(12).map { [] }
frame_index = 0

points.each do |point|
  point = convert_point_to_int(point)

  # 現在のフレームにポイントを入れる
  score[frame_index].push(point)

  frame = score[frame_index]

  # strike / spare の場合
  # フレームの残りには FLAG 2つ / 1つ 立てる
  if frame.sum == 10
    convert_flag_to_point(score, point)
    case frame.size
    when 1 # strike
      frame.push(FLAG, FLAG)
    when 2 # spare
      frame.push(FLAG)
    end
  end

  # strike / spare 以外の場合
  # ex1. 1投目で 10 未満
  # ex2. 2投目で spare が取れなかった場合
  convert_flag_to_point(score, point) if frame.size <= 2

  # strike / spare / spareでない2投目 のいづれかの場合。
  # 次のフレームへ
  frame_index += 1 if frame.size >= 2
end

# 例外処理: 11, 12 フレーム目はないので、0 でpadding
score[10] = [0]
score[11] = [0]

# 全要素の合計
puts score.flatten.sum
