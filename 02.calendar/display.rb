class Display
  def initialize(cal_elements, layout)
    @cal_elements = cal_elements
    @layout = layout
  end

  def run
    assigned_days = assign_days_to_cal
    assigned_days_string = join_day_cells(assigned_days)

    puts <<~CALENDAR
          #{@cal_elements[:month]}月 #{@cal_elements[:year]}年
     日 月 火 水 木 金 土
    #{assigned_days_string}
    CALENDAR
  end

  def assign_days_to_cal
    @layout[:column] = decide_column(@cal_elements[:days].length)
    assigned_days = Array.new(@layout[:column]).map { Array.new(7, nil) }
    assigned_days.map.each_with_index do |grid, index|
      grid[0..6] = @cal_elements[:days][index * 7..index * 7 + 6]
    end
    assigned_days
  end

  def decide_column(maxsize)
    if maxsize > 28 && maxsize < 36
      5
    else
      6
    end
  end

  def join_day_cells(day_cells)
    case @layout[:column]
    when 6
      <<~CALENDAR
        #{day_cells[0].join}
        #{day_cells[1].join}
        #{day_cells[2].join}
        #{day_cells[3].join}
        #{day_cells[4].join}
        #{day_cells[5].join}
      CALENDAR
    when 5
      <<~CALENDAR
        #{day_cells[0].join}
        #{day_cells[1].join}
        #{day_cells[2].join}
        #{day_cells[3].join}
        #{day_cells[4].join}
      CALENDAR
    end
  end
end