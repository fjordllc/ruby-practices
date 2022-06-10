# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/column'

class ColumnTest < Minitest::Test
  def setup
    @column = Column.new
    `touch test1.txt`
    @file = Dir.glob('test1.txt')[0]
  end

  def test_add
    refute @column.files.include?(@file)
    @column.add(@file)
    assert_equal 9, @column.max_name_size
    assert @column.files.include?(@file)
  end

  def test_show
    refute @column.show(0)
    @column.add(@file)
    @column.show(0)
    assert_equal 'test1.txt', @column.show(0)
  end
end
