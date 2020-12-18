require 'date'
require 'optparse'

options = ARGV.getopts('m:y:')
year = options["y"]
month = options["m"]

