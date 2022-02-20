#!/usr/bin/env ruby

# frozen_string_literal: true

NUM_OF_COLUMNS = 3

def calc_num_of_row(num_of_objects)
  (num_of_objects / NUM_OF_COLUMNS.to_f).ceil
end

def ljust_objects(objects)
  max_length_of_object_name = objects.max_by(&:length).length + 1
  objects.map do |object|
    object.ljust(max_length_of_object_name)
  end
end

def remove_hidden_objects(objects)
  objects.delete_if { |object| object.match?(/^\./) }
end

def generate_rows(objects, num_of_row)
  rows = []
  num_of_row.times { rows.push([]) }

  row_index = 0
  objects.each do |object|
    rows[row_index].push(object)
    row_index == num_of_row - 1 ? row_index = 0 : row_index += 1
  end

  rows
end

objects = Dir.entries('.').sort
ljusted_objects = ljust_objects(objects)

rows = generate_rows(
  remove_hidden_objects(ljusted_objects),
  calc_num_of_row(ljusted_objects.size)
)

rows.each { |row| puts row.join }
