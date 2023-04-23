#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
# require_relative 'my-ls'

class TestFileNameReciever < Minitest::Test
  def test_get_file_names_no_argument
    get_file_names('')
  end
end
