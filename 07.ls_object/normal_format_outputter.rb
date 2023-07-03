# frozen_string_literal: true

require_relative 'normal_formatter'

class NormalFormatOutputter
  attr_reader :file_names

  def initialize(file_names)
    @file_names = file_names
  end

  def output
    NormalFormatter.new(file_names).regular_format.each do |name|
      name.compact.each { |a| print a.ljust(30) }
      puts "\n"
    end
  end
end
