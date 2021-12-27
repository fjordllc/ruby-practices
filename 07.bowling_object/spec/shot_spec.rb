# frozen_string_literal: true

require './shot'

RSpec.describe Shot do
  describe "Shot#score" do
    context "0のとき" do
      let(:shot){ Shot.new('0') }
      it "scoreが0になること" do
        expect(shot.score).to eq(0)
      end
    end

    context "ストライクのとき" do
      let(:shot){ Shot.new('X') }
      it "scoreが10になること" do
        expect(shot.score).to eq(10)
      end
    end

    context "5のとき" do
      let(:shot){ Shot.new('5') }
      it "scoreが5になること" do
        expect(shot.score).to eq(5)
      end
    end
  end
end
