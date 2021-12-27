# frozen_string_literal: true

require './game'

RSpec.describe Game do
  describe "Game#score" do
    context "2連続ストライクがあるとき" do
      let(:game){ Game.new('6,3,9,1,0,3,8,2,7,3,X,3,1,8,2,X,X,4,5') }
      it "scoreが140になること" do
        expect(game.score).to eq(140)
      end
    end

    context "3連続ストライクがあるとき" do
      let(:game){ Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4') }
      it "scoreが107になること" do
        expect(game.score).to eq(107)
      end
    end

    context "2連続ストライクがあるとき" do
      let(:game){ Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0') }
      it "scoreが134になること" do
        expect(game.score).to eq(134)
      end
    end

    context "10フレーム目に3連続ストライクがあるとき" do
      let(:game){ Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X') }
      it "scoreが164になること" do
        expect(game.score).to eq(164)
      end
    end

    context "10フレーム目の1投目だけストライクのとき" do
      let(:game){ Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8') }
      it "scoreが144になること" do
        expect(game.score).to eq(144)
      end
    end

    context "全てストライクのとき" do
      let(:game){ Game.new('X,X,X,X,X,X,X,X,X,X,X,X') }
      it "scoreが300になること" do
        expect(game.score).to eq(300)
      end
    end

    context "全て0のとき" do
      let(:game){ Game.new('0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0') }
      it "scoreが0になること" do
        expect(game.score).to eq(0)
      end
    end

    context "9フレーム目までが全てストライクで、10フレーム目が0のとき" do
      let(:game){ Game.new('X,X,X,X,X,X,X,X,X,0,0,0') }
      it "scoreが240になること" do
        expect(game.score).to eq(240)
      end
    end

    context "9フレーム目までが全てストライクで、10フレーム目が0のとき" do
      let(:game){ Game.new('X,X,X,X,X,X,X,X,X,0,0,0') }
      it "scoreが240になること" do
        expect(game.score).to eq(240)
      end
    end
  end
end
