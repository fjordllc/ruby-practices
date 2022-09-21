require_relative 'normal_format'

module Ls
  class Command
    def initialize(option = false)
      @option = option
    end

    def run_ls
      NormalFormat.new.show_files
    end
  end
end
