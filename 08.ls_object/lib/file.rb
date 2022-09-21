module Ls
  class File
    attr_reader :filename
    
    def initialize(filename)
      @filename = filename
    end

    def self.generate_file
      filenames = Dir.glob('*')
      filename = filenames.map { |filename| Ls::File.new(filename) }
    end
  end
end
