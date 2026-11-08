# frozen_string_literal: true

class DisplayOptions
  attr_reader :options

  DEFAULT_OPTIONS = { default_column: 3, default_show_hidden: false }.freeze
  def initialize(column: DEFAULT_OPTIONS[:default_column], show_hidden: DEFAULT_OPTIONS[:default_show_hidden])
    @options = { column:, show_hidden: }
  end
end
