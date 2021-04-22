# frozen_string_literal: true

class CalenderDateUnit
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize(month, year, request)
    @year = year
    @month = month
    @request = request
  end

  def generate_days
    month_last_d = Date.new(@year, @month, -1).day

    days_array = []
    days_array = generate_one_month_days(days_array, month_last_d)
    optimized_days_array = add_blank(days_array)

    [@month, @year, optimized_days_array]
  end

  private

  def generate_one_month_days(days_array, month_last_d)
    case @request[:julius]
    when true
      j_month_first_d = Date.new(@year, @month, 1).yday
      j_month_last_d = Date.new(@year, @month, month_last_d).yday
      days_array << [*j_month_first_d..j_month_last_d]
    when false
      days_array << [*1..month_last_d]
    end
    days_array.flatten!
    days_array
  end

  def add_blank(days_array)
    month_first_w = Date.new(@year, @month, 1).wday
    optimized_days_array_result = []

    month_first_w.times { days_array.unshift('blank') }

    days_array.each do |day|
      case
      when day == 'blank'
        optimized_days_array_result << "#{day}\s"
      when day.to_s.length == 1
        if turn_on_highlight(day, @request[:highligth])
          optimized_days_array_result << "\e[47m\e[30mblank_for_one_char#{day}\e[0m\s"
          next
        end
        optimized_days_array_result << "blank_for_one_char#{day}\s"
      when day.to_s.length == 2
        if turn_on_highlight(day, @request[:highligth])
          optimized_days_array_result << "\e\e[47m\e[30mblank_for_two_char#{day}\e[0m\s"
          next
        end
        optimized_days_array_result << "blank_for_two_char#{day}\s"
      when day.to_s.length == 3
        if turn_on_highlight_when_j(day, @request[:highligth])
          optimized_days_array_result << "\e\e[47m\e[30mblank_for_three_char#{day}\e[0m\s"
          next
        end
        optimized_days_array_result << "blank_for_three_char#{day}\s"
      end
    end
    optimized_days_array_result
  end

  def turn_on_highlight(day, highligth)
    @year == THIS_Y && @month == THIS_M && day == THIS_D && highligth
  end

  def turn_on_highlight_when_j(day, highligth)
    @year == THIS_Y && @month == THIS_M && day == Date.new(@year, @month, THIS_D).yday && highligth
  end
end
