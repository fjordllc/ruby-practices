require 'date'

class Calendar
  WEEK_DAYS =
    { 'Sun' => 1,
      'Mon' => 2,
      'Tue' => 3,
      'Wed' => 4,
      'Thu' => 5,
      'Fri' => 6,
      'Sat' => 7 }.freeze

  def initialize(year, month)
    @year = if !year.nil?
              year
            else
              Date.today.year.to_s # 引数yearはnil以外でstringで渡ってくるので、この値もstringに合わせる
            end

    @month = if !month.nil?
               month
             else
               Date.today.month.to_s
             end
  end

  def fetch_the_end_of_the_month
    Date.new(@year.to_i, @month.to_i, -1).mday
  end

  def create_date(day)
    Date.parse("#{@year}-#{@month}-#{day}")
  end

  def show_header(week_days)
    print "#{@month}th #{@year}".center(25)
    puts
    week_days.each_key do |week_day|
      print week_day.ljust(4)
    end
    puts
  end

  def show_1st_week
    week_day_1st = create_date('1').strftime('%a')
    (1...WEEK_DAYS[week_day_1st]).each do |_|
      print '    '
    end
    print '1'.rjust(3)
  end

  # 今月のカレンダーをCLI上に表示する。
  def desplay_this_month_calendar
    # カレンダーのヘッダーを表示
    show_header(WEEK_DAYS)

    # １日の曜日を調べてスペースを入力し１日目の日付を表示
    show_1st_week

    # 二日目から月末までの日時を表示
    end_month = fetch_the_end_of_the_month
    today = Date.today.mday

    (2...end_month + 1).each do |day|
      day_s = day.to_s

      # 曜日の取得: week_day
      date = create_date(day_s)
      week_day = date.strftime('%a')

      if week_day != 'Sun'
        if day == today
          print " \e[#40;#37m#{day_s.rjust(3)}\e[0m"
        else
          print " #{day_s.rjust(3)}"
        end
      # 日曜日の場合に改行する。
      else
        print "\n#{day_s.rjust(3)}"
      end
    end
    # 最後に改行しないとが表示される謎仕様があるので改行
    print "\n"
  end
end
