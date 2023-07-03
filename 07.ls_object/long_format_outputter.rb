# frozen_string_literal: true

require_relative 'long_formatter'

class LongFormatOutputter
  attr_reader :file_names

  def initialize(file_names)
    @file_names = file_names
  end

  def output
    puts "total #{file_names.map { |file_name| File.stat(file_name).blocks }.sum}"
    file_names.each do |file_name|
      puts LongFormatter.new(file_name).format
    end
  end
end
