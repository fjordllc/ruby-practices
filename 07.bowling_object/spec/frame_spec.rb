# frozen_string_literal: true

require './frame'

RSpec.describe Frame do
  describe "Frame#score" do
    context "1投目がストライクのとき" do
      let(:frame){ Frame.new('X') }
      it "scoreが10になること" do
        expect(frame.score).to eq(10)
      end
    end

    context "1投目が1、2投目が9のとき" do
      let(:frame){ Frame.new('1', '9') }
      it "scoreが10になること" do
        expect(frame.score).to eq(10)
      end
    end

    context "1投目が3、2投目が5のとき" do
      let(:frame){ Frame.new('3', '5') }
      it "scoreが8になること" do
        expect(frame.score).to eq(8)
      end
    end

    context "2投全て0のとき" do
      let(:frame){ Frame.new('0', '0') }
      it "scoreが0になること" do
        expect(frame.score).to eq(0)
      end
    end

    context "3投全て0のとき" do
      let(:frame){ Frame.new('0', '0', '0') }
      it "scoreが0になること" do
        expect(frame.score).to eq(0)
      end
    end

    context "1投目が2、2投目が8、3投目が5のとき" do
      let(:frame){ Frame.new('2', '8', '5') }
      it "scoreが15になること" do
        expect(frame.score).to eq(15)
      end
    end

    context "2投目までがストライクで、3投目が5のとき" do
      let(:frame){ Frame.new('X', 'X', '5') }
      it "scoreが25になること" do
        expect(frame.score).to eq(25)
      end
    end
  end

  describe "Frame#strike?" do
    context "ストライクのとき" do
      let(:frame){ Frame.new('X') }
      it "trueになること" do
        expect(frame.strike?).to eq(true)
      end
    end

    context "スペアのとき" do
      let(:frame){ Frame.new('1', '9') }
      it "falseになること" do
        expect(frame.strike?).to eq(false)
      end
    end
  end

  describe "Frame#spare?" do
    context "スペアのとき" do
      let(:frame){ Frame.new('3', '7') }
      it "trueになること" do
        expect(frame.spare?).to eq(true)
      end
    end

    context "ストライクのとき" do
      let(:frame){ Frame.new('2', '6') }
      it "falseになること" do
        expect(frame.spare?).to eq(false)
      end
    end
  end
end
