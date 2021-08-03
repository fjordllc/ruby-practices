require "optparse"
require "etc"
require "pry"

class String
  def hidden_file?
    start_with?('.')
  end
end

def optparse
  opt = OptionParser.new
  params = {}

  opt.on('-a') { |v| params[:a] = v }
  opt.on('-l') { |v| params[:l] = v }
  opt.on('-r') { |v| params[:r] = v }

  opt.parse!(ARGV)
  binding.pry
  file_names = params[:r] ?  Dir.foreach('.').to_a.reverse : Dir.foreach('.').to_a.sort
  binding.pry
  file_names.reject!(&:hidden_file?) unless params[:a]
  binding.pry

  p params
  p 111
  p file_names
end

optparse

# dir = Dir.pwd
# file = file_names.first
# fs = File::Stat.new("#{dir}/#{file}")
# mode = "%o" % fs.mode
