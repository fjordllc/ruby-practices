#!/usr/bin/env ruby

# frozen_string_literal: true

SEGMENT_LENGTH = 3

def divide_into_three(entities)
  entities.each_slice((entities.length + 2) / SEGMENT_LENGTH).to_a
end

def transpose(entities)
  max_size = entities.map(&:size).max
  entities.map! { |items| items.values_at(0...max_size) }
  entities.transpose
end

divided_entities = divide_into_three(Dir.entries('.'))

transposed_entities = transpose(divided_entities)

transposed_entities.each do |column_entitites|
  column_entitites.each do |column_entitiy|
    print column_entitiy&.ljust(15)
  end
  print("\n")
end
