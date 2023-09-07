require 'date'

class Calendar
    def initialize(year, month)
        if year != nil
            @year = year
        else 
            @year = Date.today.year.to_s # 引数yearはnil以外でstringで渡ってくるので、この値もstringに合わせる
        end

        if month != nil
            @month = month
        else
            @month = Date.today.month.to_s
        end
    end
    
    def get_the_end_of_the_month
        end_month_mday = Date.new(@year.to_i, @month.to_i, -1).mday
        return end_month_mday
    end

    def create_date(day)
        date = Date.parse(@year + "-" + @month + "-" + day)
        return date
    end
    
    #今月のカレンダーをCLI上に表示する。
    def desplay_this_month_calendar

        week_days = {"Sun" => 1, "Mon" => 2, "Tue" =>3, "Wed" => 4, "Thu" => 5, "Fri" => 6, "Sat" => 7}

        # show Header
        print (@month+ "th" + " " + @year).center(21) + "\n"
        week_days.keys.each do |week_day|
            print week_day + " "
        end
        puts

        # １日の曜日を調べてスペースを入力し１日目の日付を表示
        week_day_1st = create_date("1").strftime('%a')

        for _ in 1 ... week_days[week_day_1st]
            print "    "
        end 
        print "1".rjust(2)

        # 二日目から月末までの日時を表示
        end_month = get_the_end_of_the_month()
        today = Date.today.mday

        for day in 2 ... end_month+1
            
            day_s = day.to_s

            # 曜日の取得: week_day
            date = create_date(day_s)
            week_day = date.strftime('%a')

            if week_day != "Sun"
                if day == today
                    print '  ' + "\e[#40;#37m#{day_s.rjust(2)}\e[0m"
                else 
                    print '  ' + day_s.rjust(2)
                end
            #日曜日の場合に改行する。
            else 
                print "\n" + day_s.rjust(2)
            end
        end   
        # 最後に改行しないと%が表示される謎仕様があるので改行
        print "\n"     
    end
end
