#! /usr/bin/env ruby
# frozen_string_literal: true

outputs = [[], [], []]
temporary_outputs = []

Dir.foreach('./outputs') do |item|
  next if item.include('.') || item.include('..')

  temporary_outputs << item
end

columns = 3

size = temporary_outputs.length / columns + 1

count = 0

temporary_outputs.sort.each do |item|
  outputs[count].push(item)
  count += 1 if (outputs[count].length % size).zero?
end

size.times do |time|
  columns.times do |column|
    print outputs[column][time]
    print outputs[column][time].to_s.length == 1 ? '  ' : ' '
  end
  puts '\n'
end
