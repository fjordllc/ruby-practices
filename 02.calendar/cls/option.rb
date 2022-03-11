require 'optparse'

class Option
  attr_accessor :options
  def initialize(*options)
    @opt = OptionParser.new
    @options = {}
    init_options(options)
    @opt.parse!(ARGV)
  end
  
  private
    def init_options(options)
      options.each do |opt|
        @opt.on("-#{opt}") do |v|
          arg = ARGV[0].to_i
          @options[opt] = arg if v && (arg > 0)
        end
      end
    end
end
