require 'optparse'

def main
  files = ARGV
  params = ARGV.getopts('clw')
  file = files.map { |file| File.open(file).read }
  puts file
end

def acquire_number_of_lines(content)
  content.count("\n")
end

main
