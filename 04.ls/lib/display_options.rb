# frozen_string_literal: true

class DisplayOptions
  attr_reader :options

  DEFAULT_OPTIONS = { default_column: 3, default_show_hidden: false, default_dir_reverse: false }.freeze
  def initialize(column: DEFAULT_OPTIONS[:default_column], show_hidden: DEFAULT_OPTIONS[:default_show_hidden],
                 dir_reverse: DEFAULT_OPTIONS[:default_dir_reverse])
    @options = { column:, show_hidden:, dir_reverse: }
  end
end
