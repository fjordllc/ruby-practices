# frozen_string_literal: true

# !/usr/bin/env ruby

require 'optparse'
require './file_data'

module Ls
  class Main
    def run(opt)
      file_data = Ls::FileData.new(opt)
      file_data.format_option(opt)
    end
  end
end

opt = ARGV.getopts('arl')
main = Ls::Main.new
main.run(opt)
