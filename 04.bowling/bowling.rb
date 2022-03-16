KEY_STRIKE = "X"

def bowling_score(releases_chars = "")
  score = 0
  frames = parse_frames(releases_chars)
  frames.each.with_index do |frame, index|
    if frame.sum < 10
      score += frame.sum
    else # スペア、ストライク、最終フレーム
      score += frames[index, frames.size].flatten.take(3).sum
    end
  end
  score
end

def parse_frames(releases_chars = "")
  frames = releases_chars.split(/,/).each_with_object([]) {|item, memo|
    if item == KEY_STRIKE
      memo.push(10, nil)
    else
      memo.push(item.to_i)
    end
  }.group_by.with_index{|item, index|
    index / 2
  }.map {|key, releases|
    releases.compact
  }
  frames[0,9] << frames[9,3].flatten
end


