# frozen_string_literal: true

class MergeCalender
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize(all_dates, layout_status)
    @all_dates = all_dates
    @layout_status = layout_status
  end

  def merge
    rendering_calender(@all_dates)
  end

  private

  def rendering_calender(all_dates)
    rendering_string_result = ''
    replaced_all_dates = Marshal.load(Marshal.dump(all_dates))
    replaced_all_dates = replace_layout_var(replaced_all_dates)

    while replaced_all_dates.size / 3 >= 1 && @layout_status[:month_column_num] == 3
      rendering_string_result += merge_date_unit(
        3,
        replaced_all_dates[0],
        replaced_all_dates[1],
        replaced_all_dates[2]
      )
      replaced_all_dates.slice!(0, 3)
    end
    while replaced_all_dates.size / 2 >= 1
      rendering_string_result += merge_date_unit(
        2,
        replaced_all_dates[0],
        replaced_all_dates[1]
      )
      replaced_all_dates.slice!(0, 2)
    end
    if replaced_all_dates.size >= 1
      rendering_string_result += merge_date_unit(
        1,
        replaced_all_dates[0]
      )
      replaced_all_dates.slice!(0, 1)
    end
    rendering_string_result.insert(0, @layout_status[:header_position].call(@all_dates[0][1]))
    rendering_string_result
  end

  def merge_date_unit(
    merge_unit_num,
    first_unit = nil,
    second_unit = nil,
    third_unit = nil
  )
    case merge_unit_num
    when 1
      first_day_cells = first_unit[2]

      maxsize = [first_day_cells.size].max
      column = decide_column(maxsize)

      first_day_cells = add_end_blank(column, merge_unit_num, first_day_cells)
      one_month_day_cells = Array.new(column).map { Array.new(7, nil) }
      one_month_day_cells.map.each_with_index do |grid, index|
        grid[0..6] = first_day_cells[index * 7..index * 7 + 6]
      end
      one_month_days_string_result = join_days_string(one_month_day_cells, column)

      <<~CALENDER
        #{@layout_status[:one_caption].call(first_unit[0], first_unit[1])}
        #{@layout_status[:one_week]}
        #{one_month_days_string_result}
      CALENDER

    when 2
      first_day_cells = first_unit[2]
      second_day_cells = second_unit[2]

      maxsize = [first_day_cells.size, second_day_cells.size].max
      column = decide_column(maxsize)

      first_day_cells, second_day_cells = add_end_blank(column, merge_unit_num, first_day_cells, second_day_cells)

      two_months_day_cells = Array.new(column).map { Array.new(14, nil) }
      two_months_day_cells.map.each_with_index do |grid, index|
        grid[0..6] = first_day_cells[index * 7..index * 7 + 6]
        grid[7..13] = second_day_cells[index * 7..index * 7 + 6]
        grid.insert(7, "\s")
      end
      two_month_days_string_result = join_days_string(two_months_day_cells, column)

      <<~CALENDER
        #{@layout_status[:two_caption].call(first_unit[0], first_unit[1], second_unit[0], second_unit[1])}
        #{@layout_status[:two_weeks]}
        #{two_month_days_string_result}
      CALENDER

    when 3
      first_day_cells = first_unit[2]
      second_day_cells = second_unit[2]
      third_day_cells = third_unit[2]

      maxsize = [first_day_cells.size, second_day_cells.size, third_day_cells.size].max
      column = decide_column(maxsize)

      first_day_cells, second_day_cells, third_day_cells = add_end_blank(
        column,
        merge_unit_num,
        first_day_cells,
        second_day_cells,
        third_day_cells
      )

      three_months_day_cells = Array.new(column).map { Array.new(21, nil) }
      three_months_day_cells.map.each_with_index do |grid, index|
        grid[0..6] = first_day_cells[index * 7..index * 7 + 6]
        grid[7..13] = second_day_cells[index * 7..index * 7 + 6]
        grid[14..20] = third_day_cells[index * 7..index * 7 + 6]
        grid.insert(14, "\s")
        grid.insert(7, "\s")
      end
      three_month_days_string_result = join_days_string(three_months_day_cells, column)

      <<~CALENDER
        #{@layout_status[:three_caption].call(first_unit[0], first_unit[1], second_unit[0], second_unit[1], third_unit[0], third_unit[1])}
        #{@layout_status[:three_weeks]}
        #{three_month_days_string_result}
      CALENDER
    end
  end

  def join_days_string(day_cells, column)
    case column
    when 6
      <<~CALENDER
        #{day_cells[0].join}
        #{day_cells[1].join}
        #{day_cells[2].join}
        #{day_cells[3].join}
        #{day_cells[4].join}
        #{day_cells[5].join}
      CALENDER
    when 5
      <<~CALENDER
        #{day_cells[0].join}
        #{day_cells[1].join}
        #{day_cells[2].join}
        #{day_cells[3].join}
        #{day_cells[4].join}
      CALENDER
    end
  end

  def decide_column(maxsize)
    if 28 < maxsize && maxsize < 36
      5
    else
      6
    end
  end

  def add_end_blank(
    column,
    merge_unit_num,
    first_day_cells,
    second_day_cells = nil,
    third_day_cells = nil
  )

    first_day_cells << "#{@layout_status[:blank]}\s" while first_day_cells.size < column * 7
    if [2, 3].include?(merge_unit_num)
      second_day_cells << "#{@layout_status[:blank]}\s" while second_day_cells.size < column * 7
      if merge_unit_num == 3
        third_day_cells << "#{@layout_status[:blank]}" while third_day_cells.size < column * 7
      end
    end

    case merge_unit_num
    when 1
      return first_day_cells
    when 2
      return first_day_cells, second_day_cells
    when 3
      return first_day_cells, second_day_cells, third_day_cells
    end
  end

  def replace_layout_var(all_dates)
    all_dates.each_with_index do |month, month_index|
      month[2].each_with_index do |element, day|
        if element == "blank\s"
          all_dates[month_index][2][day] = "#{@layout_status[:blank]} "
        end
        if element.include?('blank_for_one_char')
          all_dates[month_index][2][day] = element.gsub(/blank_for_one_char/, @layout_status[:blank_for_one_char].to_s)
        end
        if element.include?('blank_for_two_char')
          all_dates[month_index][2][day] = element.gsub(/blank_for_two_char/, @layout_status[:blank_for_two_char].to_s)
        end
        if element.include?('blank_for_three_char')
          all_dates[month_index][2][day] = element.gsub(/blank_for_three_char/, @layout_status[:blank_for_three_char].to_s)
        end
      end
    end
  end
end
