# frozen_string_literal: true

# !/usr/bin/env ruby

require 'optparse'
require './file_list'

module Ls
  class Main
    def run(opt)
      file_list = Ls::FileList.new(opt)
      file_list.format_option(opt)
    end
  end
end

opt = ARGV.getopts('arl')
main = Ls::Main.new
main.run(opt)
