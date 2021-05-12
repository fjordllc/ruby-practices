require "optparse"

options = ARGV.getopts('a')
if options['a']
  print Dir.glob("*", File::FNM_DOTMATCH).sort
  puts "\n"
else
  print Dir.glob("*").sort
  puts "\n" 
end
