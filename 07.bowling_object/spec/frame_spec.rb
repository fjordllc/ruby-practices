# frozen_string_literal: true

require './frame'

RSpec.describe Frame do
  describe "Frame#score" do
    context "1投目がストライクのとき" do
      it "scoreが10になること" do
        @frame = Frame.new('X')
        expect(@frame.score).to eq(10)
      end
    end

    context "1投目が1、2投目が9のとき" do
      it "scoreが10になること" do
        @frame = Frame.new('1', '9')
        expect(@frame.score).to eq(10)
      end
    end

    context "1投目が3、2投目が5のとき" do
      it "scoreが8になること" do
        @frame = Frame.new('3', '5')
        expect(@frame.score).to eq(8)
      end
    end

    context "2投全て0のとき" do
      it "scoreが0になること" do
        @frame = Frame.new('0', '0')
        expect(@frame.score).to eq(0)
      end
    end

    context "3投全て0のとき" do
      it "scoreが0になること" do
        @frame = Frame.new('0', '0', '0')
        expect(@frame.score).to eq(0)
      end
    end

    context "1投目が2、2投目が8、3投目が5のとき" do
      it "scoreが15になること" do
        @frame = Frame.new('2', '8', '5')
        expect(@frame.score).to eq(15)
      end
    end

    context "2投目までがストライクで、3投目が5のとき" do
      it "scoreが25になること" do
        @frame = Frame.new('X', 'X', '5')
        expect(@frame.score).to eq(25)
      end
    end
  end

  describe "Frame#strike?" do
    context "ストライクのとき" do
      it "trueになること" do
        @frame = Frame.new('X')
        expect(@frame.strike?).to eq(true)
      end
    end

    context "スペアのとき" do
      it "falseになること" do
        @frame = Frame.new('1', '9')
        expect(@frame.strike?).to eq(false)
      end
    end
  end

  describe "Frame#spare?" do
    context "スペアのとき" do
      it "trueになること" do
        @frame = Frame.new('3', '7')
        expect(@frame.spare?).to eq(true)
      end
    end

    context "ストライクのとき" do
      it "falseになること" do
        @frame = Frame.new('2', '6')
        expect(@frame.spare?).to eq(false)
      end
    end
  end
end
