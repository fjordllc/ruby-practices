# frozen_string_literal: true

require 'optparse'

SEGMENT_LENGTH = 3

class FileSystem
  def initialize(argv)
    @column_file_groups = create_column_file_groups(argv)
  end

  private

  def create_column_file_groups(argv)
    opt = OptionParser.new
    options = {}
    opt.on('-a') { |v| options[:a] = v }
    opt.on('-r') { |v| options[:r] = v }
    opt.on('-l') { |v| options[:l] = v }
    opt.parse!(argv)

    filenames = Dir.glob('*')
    filenames = Dir.entries('.') if options[:a]
    filenames.reverse! if options[:r]

    if options[:l]
    else
    end
  end
end
