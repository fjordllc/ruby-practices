# frozen_string_literal: true

require 'optparse'

options = ARGV.getopts('a')
if options['a']
  print Dir.glob('*', File::FNM_DOTMATCH).sort
  puts "\n"
else
  print Dir.glob('*').sort
  puts "\n"
end

permissions = {
  '0' => '---',
  '1' => '--x',
  '2' => 'r--',
  '3' => '-w-',
  '4' => '-wx',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}
