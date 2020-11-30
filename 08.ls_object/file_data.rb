# frozen_string_literal: true

# !/usr/bin/env ruby

require './format'

module Ls
  class FileData
    def initialize
      @format = Ls::Format.new
    end

    def ls_no_option
      files = Dir.glob('*').sort
      @format.horizontal_row(files)
    end

    def ls_a_option
      files = Dir.glob('*', File::FNM_DOTMATCH).sort
      @format.horizontal_row(files)
    end

    def ls_r_option
      files = Dir.glob('*').sort.reverse
      @format.horizontal_row(files)
    end

    def ls_l_option
      files = Dir.glob('*').sort
      @format.horizontal_rows(files)
    end

    def ls_alr_option
      files = Dir.glob('*', File::FNM_DOTMATCH).sort.reverse
      @format.horizontal_rows(files)
    end
  end
end
