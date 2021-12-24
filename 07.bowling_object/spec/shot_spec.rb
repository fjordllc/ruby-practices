# frozen_string_literal: true

require './shot'

RSpec.describe Shot do
  describe "Shot#score" do
    context "0のとき" do
      it "scoreが0になること" do
        @shot = Shot.new('0')
        expect(@shot.score).to eq(0)
      end
    end

    context "ストライクのとき" do
      it "scoreが10になること" do
        @shot = Shot.new('X')
        expect(@shot.score).to eq(10)
      end
    end

    context "5のとき" do
      it "scoreが5になること" do
        @shot = Shot.new('5')
        expect(@shot.score).to eq(5)
      end
    end
  end
end
