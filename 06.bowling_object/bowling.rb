require_relative 'lib/game'
require_relative 'lib/frame'
require_relative 'lib/shot'

marks = ARGV[0]
puts Game.new(marks).total_score
