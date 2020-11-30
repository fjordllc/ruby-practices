# frozen_string_literal: true

# !/usr/bin/env ruby

require 'optparse'
require './file_data'

module Ls
  class Main
    def initialize(argv)
      @option = argv[0]
      @file = Ls::FileData.new
      select_option
    end

    def select_option
      case @option
      when '-a'
        @file.ls_a_option
      when '-r'
        @file.ls_r_option
      when '-l'
        @file.ls_l_option
      when '-arl'
        @file.ls_alr_option
      else
        @file.ls_no_option
      end
    end
  end
end

Ls::Main.new(ARGV)
