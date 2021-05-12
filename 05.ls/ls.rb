# frozen_string_literal: true

require 'optparse'
options = ARGV.getopts('a', 'l', 'r')

contents = Dir.glob('*')

if options['a']
  puts Dir.glob('*', File::FNM_DOTMATCH).sort
elsif options['r']
  puts contents.reverse
else
  puts contents
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
