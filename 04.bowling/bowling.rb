# frozen_string_literal: true

KEY_STRIKE = 'X'

def bowling_score(releases_chars = '')
  score = 0
  frames = parse_frames(releases_chars)
  frames.each.with_index do |frame, index|
    score += if frame.sum < 10
               frame.sum
             else # スペア、ストライク、最終フレーム
               frames[index, frames.size].flatten.take(3).sum
             end
  end
  score
end

def parse_frames(releases_chars = '')
  frames = Array.new(10) { [] }
  frame_index = 0
  releases = releases_chars.split(/,/)
  releases.each do |release|
    if frame_index < 9
      if release == KEY_STRIKE
        frames[frame_index].push(10)
        frame_index += 1 # ストライクの場合、フレームを進める
      else
        frames[frame_index].push(release.to_i)
        frame_index += 1 if frames[frame_index].size == 2
      end
    elsif release == KEY_STRIKE
      # 最終フレームは最後まで点数を追加する
      frames[frame_index].push(10)
    else
      frames[frame_index].push(release.to_i)
    end
  end
  frames
end
