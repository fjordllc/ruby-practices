# frozen_string_literal: true

require 'optparse'
require 'pathname'

module Ls
  module Parser
    class << self
      def parse(args)
        options = {
          dot_match: false,
          long_format: false,
          reverse: false
        }
        parser = create_parser options
        path = Pathname(parser.parse(args)[0] || '.')
        [path, options]
      end

      def create_parser(options)
        OptionParser.new do |opts|
          opts.on('-a', 'Include directory entries whose names begin with a dot (.).') do
            options[:dot_match] = true
          end
          opts.on('-l', 'List in long format.') do
            options[:long_format] = true
          end
          opts.on('-r', 'Reverse the order of the sort') do
            options[:reverse] = true
          end
        end
      end
    end
  end
end
