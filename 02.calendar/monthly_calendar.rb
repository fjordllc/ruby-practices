# frozen_string_literal: true

require 'date'
require 'color_echo'
require './calendar_date_unit'

class MonthlyCalendar
  THIS_Y = Date.today.year
  THIS_M = Date.today.mon
  THIS_D = Date.today.day
  THIS_W = Date.today.wday

  def initialize(request)
    @request = request
  end

  def make_cal
    all_request_about_month = make_request_about_month
    layout_status = make_layout_status
    all_dates = all_request_about_month.map do |date|
      this_date = CalendarDateUnit.new(date[0], date[1], @request)
      this_date.generate_days
    end
    merge_cal(all_dates, layout_status)
  end

  private

  def make_request_about_month
    all_request_about_month_result = []
    premonth_request = premonth_calc(@request[:basic_month], @request[:basic_year], @request[:pre_month])
    nextmonth_request = nextmonth_calc(@request[:basic_month], @request[:basic_year], @request[:next_month])

    all_request_about_month_result += premonth_request if !premonth_request.nil?
    all_request_about_month_result += [[@request[:basic_month], @request[:basic_year]]]
    all_request_about_month_result += nextmonth_request if !nextmonth_request.nil?
    all_request_about_month_result
  end

  def premonth_calc(basic_month, basic_year, pre_num)
    return if pre_num.nil?

    premonth_request_result = []
    case
    when basic_month - pre_num > 0
      count_pre_month = basic_month - pre_num
      count_pre_year = basic_year
    when basic_month - pre_num <= 0
      count_pre_month = 12 - ((basic_month - pre_num).abs % 12)
      count_pre_year =  basic_year - ((basic_month - pre_num).abs / 12) - 1
    end

    while count_pre_year < basic_year
      while count_pre_month <= 12
        premonth_request_result << [count_pre_month, count_pre_year]
        count_pre_month += 1
      end
      count_pre_month = 1
      count_pre_year += 1
    end
    while count_pre_month < basic_month
      premonth_request_result << [count_pre_month, count_pre_year]
      count_pre_month += 1
    end
    premonth_request_result
  end

  def nextmonth_calc(basic_month, basic_year, next_num)
    return if next_num.nil?

    next_month = nil
    next_year = nil
    nextmonth_request_result = []
    case
    when basic_month + next_num <= 12
      next_month = basic_month + next_num
      next_year = basic_year
    when basic_month + next_num > 12
      next_month = (basic_month + next_num) % 12
      next_year =  basic_year + (basic_month + next_num) / 12
    end

    count_next_month = basic_month + 1
    count_next_year = basic_year
    while count_next_year < next_year
      while count_next_month <= 12
        nextmonth_request_result << [count_next_month, count_next_year]
        count_next_month += 1
      end
      count_next_month = 1
      count_next_year += 1
    end
    while count_next_month <= next_month
      nextmonth_request_result << [count_next_month, count_next_year]
      count_next_month += 1
    end
    nextmonth_request_result 
  end

  def make_layout_status
    layout_status_result = {}
    case @request[:julius]
    when true
      layout_status_result[:margin] = "\s\s\s"
      layout_status_result[:blank] = "\s\s\s"
      layout_status_result[:blank_for_one_char] = "\s\s"
      layout_status_result[:blank_for_two_char] = "\s"
      layout_status_result[:blank_for_three_char] = ""
      layout_status_result[:month_column_num] = 2
      layout_status_result[:one_week] = " 日  月  火  水  木  金  土"
      layout_status_result[:two_weeks] = " 日  月  火  水  木  金  土   日  月  火  水  木  金  土"
      layout_status_result[:three_weeks] = " 日  月  火  水  木  金  土   日  月  火  水  木  金  土   日  月  火  水  木  金  土" 
      one_caption = proc{ |first_month, first_year| "#{"\s" * 10}#{first_month}月\s#{first_year}" }
      two_caption = proc{ |first_month, first_year, second_month, second_year| "#{"\s" * 10}#{first_month}月 #{first_year}#{"\s" * 21}#{second_month}月\s#{second_year}" }
      three_caption = proc{ |first_month, first_year, second_month, second_year, third_month, third_year| "#{"\s" * 10}#{first_month}月\s#{first_year}#{"\s" * 7}#{second_month}月\s#{second_year}#{"\s" * 17}#{third_month}月\s#{third_year}" }
      layout_status_result[:one_caption] = one_caption
      layout_status_result[:two_caption] = two_caption
      layout_status_result[:three_caption] = three_caption
    when false
      layout_status_result[:margin] = "\s\s"
      layout_status_result[:blank] = "\s\s"
      layout_status_result[:blank_for_one_char] = "\s"
      layout_status_result[:blank_for_two_char] = ''
      layout_status_result[:month_column_num] = 3
      layout_status_result[:one_week] = "日 月 火 水 木 金 土"
      layout_status_result[:two_weeks] = "日 月 火 水 木 金 土  日 月 火 水 木 金 土"
      layout_status_result[:three_weeks] = "日 月 火 水 木 金 土  日 月 火 水 木 金 土  日 月 火 水 木 金 土"
      one_caption = proc { |first_month, first_year| "#{"\s" * 7}#{first_month}月\s#{first_year}" }
      two_caption = proc { |first_month, first_year, second_month, second_year| "#{"\s" * 7}#{first_month}月 #{first_year}#{"\s" * 14}#{second_month}月\s#{second_year}" }
      three_caption = proc { |first_month, first_year, second_month, second_year, third_month, third_year| "#{"\s" * 7}#{first_month}月\s#{first_year}#{"\s" * 14}#{second_month}月 #{second_year}#{"\s" * 14}#{third_month}月 #{third_year}" }
      layout_status_result[:one_caption] = one_caption
      layout_status_result[:two_caption] = two_caption
      layout_status_result[:three_caption] = three_caption
    end

    case @request[:year_position]
    when 'default'
      header_position = proc { |this_year| '' }
      layout_status_result[:header_position] = header_position
    when 'header'
      case @request[:julius]
      when true
        one_caption = proc { |first_month| "#{"\s" * 13}#{first_month}月" }
        two_caption = proc { |first_month, second_month| "#{"\s" * 13}#{first_month}月#{"\s" * 26}#{second_month}月" }
        header_position = proc { |this_year| "#{"\s" * 26}#{this_year}年\n" }
        layout_status_result[:one_caption] = one_caption
        layout_status_result[:two_caption] = two_caption
        layout_status_result[:header_position] = header_position
      when false
        one_caption = proc { |first_month| "#{"\s" * 7}#{first_month}月" }
        two_caption = proc { |first_month, second_month| "#{"\s" * 7}#{first_month}月#{"\s" * 14}#{second_month}月" }
        three_caption = proc { |first_month, second_month, third_month| "#{"\s" * 9}#{first_month}月#{"\s" * 18}#{second_month}月#{"\s" * 18}#{third_month}月" }
        header_position = proc { |this_year| "#{"\s" * 28}#{this_year}年\n" }
        layout_status_result[:one_caption] = one_caption
        layout_status_result[:two_caption] = two_caption
        layout_status_result[:three_caption] = three_caption
        layout_status_result[:header_position] = header_position
      end
    end

    case @request[:highligth]
    when true
      layout_status_result[:highligth] = true
    when false
      layout_status_result[:highligth] = false
    end
    layout_status_result
  end

  def merge_cal(all_dates, layout_status)
    this_calendar = MergeCalendar.new(all_dates, layout_status)
    this_calendar.merge
  end
end
