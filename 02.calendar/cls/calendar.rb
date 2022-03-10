class Calendar
  def initialize
    today = Date.today
    @dates = []
    @month = today.month
    @year = today.year
    init_option
    print_header
    print_week
    print_calendar
  end

  private
    # 表示するカレンダー用の配列を作成する
    def calendar_init
      endof_month = Date.new(@year, @month, -1)
      endof_month.day.times do |i|
        @dates.push(Date.new(@year, @month, i + 1))
      end
    end

    # 見出しの年月表示用
    def print_header
      puts "#{@month}月 #{@year}".center(28)
    end

    # 見出しの曜日表示用
    def print_week
      week = ["日", "月", "火", "水", "木", "金", "土"]
      week.each_index do |i|
        print " #{week[i]} "
        puts "\n" if i == 6
      end
    end

    # カレンダーの出力
    def print_calendar
      calendar_init
      @dates.each do |d|
        # 1日が日曜日以外の時に先頭に空白を入れる処理
        if d.wday != 0 && d.day == 1
          print "    " * d.wday
          print "  #{d.day} "
        # 日付が一桁の時の空白調整
        elsif d.day < 10
          print "  #{d.day} "
        else
          print " #{d.day} "
        end
        # 曜日が土曜日の時の改行
        print "\n" if d.wday == 6
      end
    end

    # コマンドライン引数の初期化
    def init_option
      opt = OptionParser.new
      init_option_month(opt, ARGV)
      init_option_year(opt, ARGV)
      opt.parse!(ARGV)
    end

    # -mオプションの登録
    def init_option_month(opt, arg)
      opt.on('-m') do |v|
        arg = arg[0].to_i
        @month = arg if v && arg > 0 && arg <= 12
        raise_argument_error(@month, arg) if arg < 0 || arg >= 13
      end
    end

    # -yオプションの登録
    def init_option_year(opt, arg)
      opt.on('-y') do |v|
        arg = arg[0].to_i
        @year = arg if v && arg > 0
        raise_argument_error(@year, arg) if arg < 0
      end
    end

    def raise_argument_error(type, arg)
      if type == @month
        raise ArgumentError, "cal: #{arg} is neither a month number (1..12) nor a name"
      elsif type == @year
        raise ArgumentError, "cal: illegal option"
      end
    end
end
