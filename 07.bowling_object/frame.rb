# frozen_string_literal: true

class Frame
  attr_reader :first_shot, :second_shot, :third_shot, :number

  MAX_SCORE = 10

  def initialize(number, marks)
    @number = number
    @first_shot = Shot.new(marks[0])
    @second_shot = Shot.new(marks[1]) if marks[1]
    @third_shot = Shot.new(marks[2]) if marks[2]
  end

  def score(next_frame = nil, after_next_frame = nil)
    score = total_score
    # 10フレーム目は何も加算がないので終了
    return score if number == 10
    # ストライク・スペア以外は加算がないので終了
    return score unless strike? || spare?

    # ストライクでもスペアでも次フレーム1投目は必ず加算
    score += next_frame.first_shot.score
    return score if spare?

    # 9フレーム目は次々フレームが登場することはないので処理をして終了
    return score += next_frame.second_shot.score if number == 9

    # 残っているのは1〜8フレーム目かつストライクの場合のみ
    # 次の投球もストライクだったら、次々フレームの1投目を加算して終了
    return score += after_next_frame.first_shot.score if next_frame.strike?

    # そうでなければシンプルに自フレーム2投目を加算
    score + next_frame.second_shot.score
  end

  def strike?
    first_shot.score == MAX_SCORE
  end

  def total_score
    score = first_shot.score
    score += second_shot.score if second_shot
    score += third_shot.score if third_shot
    score
  end

  private

  def spare?
    # ストライクと10フレーム目は対象外
    return false if strike? || number == 10

    total_score == MAX_SCORE
  end
end
