require_relative 'shot'
require_relative 'frame'
require_relative 'game'
require_relative 'divide'

# 入力を受け取り、フレームを分割する
base_frames = Divide.new(ARGV[0].split(',')).divide_by_frame
frames = base_frames.
p frames
# 新しいGameクラスのインスタンスを作る
game = Game.new(frames)
# フレームごとの値を計算して出力する
p game.total_score
