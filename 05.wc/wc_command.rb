# frozen_string_literal: true

class WcCommand
  def initialize(text:)
    @text = text
  end

  def line_count
    @text.count('\n') + 1
  end

  def word_count
    @text.split(' ').size
  end
end
