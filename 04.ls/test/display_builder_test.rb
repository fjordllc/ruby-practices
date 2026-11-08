# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/display_builder'

class DisplayBuilderTest < Minitest::Test
  
    def test_build_display_arranges_columns_in_order
      builder = DisplayBuilder.new
      options = {  column: 3, show_hidden: false}
      y = ["Gemfile", "Gemfile.lock", "Procfile", "README.md", "babel.config.js", "bin", "config", "config.ru", "log", "package.json", "postcss.config.js"]
    assert_equal [["Gemfile", "babel.config.js", "log"], ["Gemfile.lock", "bin", "package.json"], ["Procfile", "config", "postcss.config.js"], ["README.md", "config.ru"]], builder.build_display(y, column: options[:column])
    end

    def test_build_display_hide_hiddenfile
      builder = DisplayBuilder.new
      options = {  column: 3, show_hidden: false}
      y = ["Gemfile", "Gemfile.lock", "Procfile", "README.md", "babel.config.js", "bin", "config", "config.ru", "log", "package.json", ".postcss.config.js"]
      assert_equal [["Gemfile", "babel.config.js", "log"], ["Gemfile.lock", "bin", "package.json"], ["Procfile", "config"], ["README.md", "config.ru"]], builder.build_display(y,column: options[:column],show_hidden: options[:show_hidden])
    end
end
