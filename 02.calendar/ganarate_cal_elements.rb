# frozen_string_literal: true

require 'date'

class GanarateCalElements
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  
  def initialize(keys, layout)
    @keys = keys
    @layout = layout
  end

  def generate
    days_array = (1..month_last_d).to_a.flatten
    days_array = lay_out_cells(days_array)
    { month: @keys[:m], year: @keys[:y], days: days_array }
  end

  def lay_out_cells(days_array)
    days_array = days_to_s(days_array)
    days_array = add_blank_cells(days_array)
    days_array = add_hilight(days_array)
    days_array = add_blank_char(days_array)
    add_mergin(days_array)
  end

  def days_to_s(days_array)
    days_array.map(&:to_s)
  end

  def add_blank_cells(days_array)
    month_first_w.times { days_array.unshift('blank_cell') }
    days_array = replace_blank_cell(days_array)
  end

  def replace_blank_cell(days_array)
    days_array.map do |day|
      if day.include?('blank_cell')
        @layout[:blank_cell].to_s
      else
        day
      end
    end
  end

  def add_hilight(days_array)
    days_array.map do |day|
      if today?(day)
        "\e[47m\e[30m#{day}\e[0m"
      else
        day
      end
    end
  end

  def today?(day)
    @keys[:y].to_i == THIS_Y && @keys[:m].to_i == THIS_M && day.to_i == THIS_D
  end

  def add_blank_char(days_array)
    add_blank_char = []
    days_array.map do |day|
      add_blank_char << day.to_s.gsub(/^\w+$/, "blank_for_#{day.to_s.length}char#{day}")
    end
    replayce_blank_for_char(add_blank_char)
  end

  def replayce_blank_for_char(days_array)
    days_array.map do |day|
      if day.to_s.include?('blank_for_1char')
        day.gsub(/blank_for_1char/, @layout[:blank_for_1char].to_s)
      elsif day.to_s.include?('blank_for_2char')
        day.gsub(/blank_for_2char/, @layout[:blank_for_2char].to_s)
      else
        day
      end
    end
  end

  def add_mergin(days_array)
    days_array.map do |day|
      "#{@layout[:mergin]}#{day}"
    end
  end

  def month_last_d
    Date.new(@keys[:y].to_i, @keys[:m].to_i, -1).day
  end

  def month_first_w
    Date.new(@keys[:y].to_i, @keys[:m].to_i, 1).wday
  end
end