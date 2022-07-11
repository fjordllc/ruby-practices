# frozen_string_literal: true

class List
  @@arr = []

  def self.input
    Dir.glob('*').each do |d|
      @@arr.push(d)
    end
  end

  def self.output
    arrsize = @@arr.size / 3
    a = 0
    for i in 1..arrsize
      puts "#{@@arr[i + a]} ".ljust(25) + "#{@@arr[i + arrsize + a]} ".ljust(25) + "#{@@arr[i + arrsize + arrsize + a]} ".ljust(25)
      a += 1
    end
  end
end

List.input
List.output
