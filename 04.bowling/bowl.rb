# frozen_string_literal: true

# xを点数に変換する式
def scoreinterpretter(score)
  if score.include?('X') || score.include?('x')
    score = 10
  else score.to_i
  end
end

# 点数計算用の式
def scorecalculator(scores)
  framescores = Array.new(10, 0)
  scores.each.with_index do |ls, i|
    framescores[i] += ls.sum
    if i <= 8
      if ls.size == 2 && ls.sum == 10
        framescores[i] += scores[i + 1][0]
      elsif ls.size == 1
        framescores[i] += if scores[i + 1].size == 1
                            (scores[i + 1][0] + scores[i + 2][0])
                          else
                            (scores[i + 1][0] + scores[i + 1][1])
                          end
      end
    end
  end
  print scores
  puts ''
  framescores.sum
end

# スコアの整形
def scoremaker(lines)
  scores = Array.new(10, [0])
  ls = []
  framecounter = 1
  throwcounter = 1

  lines.each do |lscore|
    score = scoreinterpretter(lscore)
    if score == 10 && throwcounter == 1 && framecounter <= 10
      ls = [score]
      scores[framecounter - 1] = ls
      framecounter += 1
      ls = []
      next
    end

    if throwcounter == 1 && framecounter <= 10
      ls.push(score)
      throwcounter += 1
      next
    end
    if throwcounter == 2 && framecounter <= 10
      ls.push(score)
      scores[framecounter - 1] = ls
      throwcounter = 1
      framecounter += 1
      ls = []
      next
    end
    if framecounter == 11 && (scores[9].sum == 10 || scores[9][0] == 10)
      scores[9].push(score)
    end
  end
  scores
end

# エラーチェック用
def errorchecker(organizedscores)
  organizedscores.each.with_index do |organizedscore, i|
    if organizedscore.size == 2 && i != 9 && organizedscore[1] == 10
      puts 'ストライクなのに二投目です'
      return false
    end
    if organizedscore.sum > 10 && i != 9
      puts '得点が10を超えています'
      return false
    end
  end
  if organizedscores.include?([0])
    puts '正確なスコアが記入されていません'
    return false
  end
  if organizedscores[9].size >= 4
    puts '最終フレームで4投以上しています'
    return false
  end
  true
end

line = ARGV.join.to_s.strip.split(',')
madescore = scoremaker(line)
puts scorecalculator(madescore) if errorchecker(madescore)
