class Bowling
  attr_reader :score

  @score = ARGV[0].split(',').map{|val| val == "X" ? 10 : val.to_i}


end
