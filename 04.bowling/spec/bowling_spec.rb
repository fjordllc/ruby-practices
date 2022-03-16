require_relative '../bowling.rb'

describe "parse_frames" do
  context '全てストライクだった場合' do
    let(:releases) { 'X,X,X,X,X,X,X,X,X,X,X,X' }
    example 'フレーム数は10' do
      expect(parse_frames(releases).size).to eq 10
    end
    example '投数は12' do
      expect(parse_frames(releases).flatten.size).to eq 12
    end
  end
  context '全てガーターだった場合' do
    let(:releases) { '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0' }
    example 'フレーム数は10' do
      expect(parse_frames(releases).size).to eq 10
    end
    example '投数は20' do
      expect(parse_frames(releases).flatten.size).to eq 20
    end
  end
end

describe "bowling" do
  context '全てガーターだった場合' do
    let(:releases) { '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0' }
    example do
      expect(bowling_score(releases)).to eq 0
    end
  end

  context '全てストライクでもスペアでもない場合' do
    let(:releases) { '1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2' }
    example do
      expect(bowling_score(releases)).to eq 30
    end
  end

  context 'スペアが含まれている場合' do
    let(:releases) { '0,10,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0' }
    example do
      expect(bowling_score(releases)).to eq 20
    end
  end

  context 'ストライクが含まれている場合' do
    let(:releases) { 'X,5,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0' }
    example do
      expect(bowling_score(releases)).to eq 24 # (10 + 5 + 2) + (5 + 2)
    end
  end

  context '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5' do
    let(:releases) { '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5' }
    example do
      expect(bowling_score(releases)).to eq 139
    end
  end

  context '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X' do
    let(:releases) { '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X' }
    example do
      expect(bowling_score(releases)).to eq 164
    end
  end

  context '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4' do
    let(:releases) { '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4' }
    example do
      expect(bowling_score(releases)).to eq 107
    end
  end

  context '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0' do
    let(:releases) { '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0' }
    example do
      expect(bowling_score(releases)).to eq 134
    end
  end

  context '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8' do
    let(:releases) { '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8' }
    example do
      expect(bowling_score(releases)).to eq 144
    end
  end

  context 'X,X,X,X,X,X,X,X,X,X,X,X' do
    let(:releases) { 'X,X,X,X,X,X,X,X,X,X,X,X' }
    example do
      expect(bowling_score(releases)).to eq 300
    end
  end
end
