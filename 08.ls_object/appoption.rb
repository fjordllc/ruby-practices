# frozen_string_literal: true

class AppOption
  require 'optparse'

  def initialize
    @options = {}
    OptionParser.new do |o|
      o.on('-a') { |v| @options[:a] = v }
      o.on('-l') { |v| @options[:l] = v }
      o.on('-r') { |v| @options[:r] = v }
      o.parse!(ARGV)
    end
  end

  def has?(name)
    @options.include?(name)
  end

  def get(name)
    @options[name]
  end

  def getextras
    ARGV
  end
end
