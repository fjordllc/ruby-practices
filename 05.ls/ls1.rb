# frozen_string_literal: true

# リストのクラス
class List
  @arr = []

  def self.input
    Dir.glob('*').each do |d|
      @arr.push(d)
    end
  end

  def self.output
    arrsize = @arr.size / 3
    (1..arrsize).each do |i|
      puts "#{@arr[i]} ".ljust(25) + "#{@arr[i + arrsize]} ".ljust(25) + "#{@arr[i + arrsize + arrsize]} ".ljust(25)
    end
  end
end

List.input
List.output
