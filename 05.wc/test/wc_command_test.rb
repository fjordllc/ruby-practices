# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../wc_command'
alias context describe

describe 'WcCommand' do
  describe 'line_count' do
    context 'when it is 3lines text' do
      it 'return 3' do
        three_lines_text = <<~'TEXT'
          こんにちは\n
          お元気ですか\n
          ではさようなら
        TEXT
        wc = WcCommand.new(text: three_lines_text)
        assert_equal 3, wc.line_count
      end
    end
    context 'when it is 1line text' do
      it 'return 1' do
        wc = WcCommand.new(text: 'こんにちは')
        assert_equal 1, wc.line_count
      end
    end
  end

  describe 'word_count' do
    context 'when it is 4words text' do
      it 'return 4' do
        wc = WcCommand.new(text: 'This is a pen.')
        assert_equal 4, wc.word_count
      end
    end
    context 'when it is 1words text' do
      it 'return 1' do
        wc = WcCommand.new(text: 'Hello.')
        assert_equal 1, wc.word_count
      end
    end
  end
end
