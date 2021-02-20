# frozen_string_literal: true

module Bowling
  class Rolls
    def initialize(rolls, frames, index)
      @rolls = rolls # 投球結果の配列。ストライク時は[10, nil]
      @frames = frames # ゲームのフレーム全体の配列への参照
      @index = index # 自分が何フレーム目かのインデックス(0-9)
    end

    def score
      final_frame? ? sum : score_nonfinal
    end

    # 何投目かは1-3で指定する
    def roll(num) = rolls[num - 1]

    def sum = rolls.sum

    # 次フレーム以降の投球をcount数取得する。次フレームがストライクだった場合、
    # 2投目はnilなのでさらにその次のフレームの1投目を取得する
    def bonus_point(roll_count:)
      next_frame(1).take(roll_count).sum { |roll| roll || next_frame(2).roll(1) }
    end

    protected

    def take(count)
      rolls.take(count)
    end

    private

    attr_reader :rolls, :frames, :index

    def next_frame(count)
      frames[index + count]
    end

    def score_nonfinal
      score_if(:strike) || score_if(:spare) || open_frame
    end

    alias open_frame sum

    def final_frame?
      Game.final_frame?(index)
    end

    def score_if(sym)
      Score.point_if(sym, self)
    end
  end
end
