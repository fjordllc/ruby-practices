# frozen_string_literal: true

# !/usr/bin/env ruby

require './formatter'

module Ls
  class FileData
    def initialize(opt)
      @formatter = Ls::Formatter.new
      @target_files = if opt['a'] && opt['r']
                        Dir.glob('*', File::FNM_DOTMATCH).sort.reverse
                      elsif opt['a']
                        Dir.glob('*', File::FNM_DOTMATCH).sort
                      elsif opt['r']
                        Dir.glob('*').sort.reverse
                      else
                        Dir.glob('*').sort
                      end
    end

    def print_l_option(opt)
      if opt['l']
        ls_l_option
      else
        ls_no_option
      end
    end

    def ls_no_option
      @formatter.simple(@target_files)
    end

    def ls_l_option
      @formatter.detail(@target_files)
    end
  end
end
