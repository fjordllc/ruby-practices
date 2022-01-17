require 'date'

# コマンドからのオプション設定用クラス
class AppOption
    require 'optparse'

    def initialize
        @options = {}
        OptionParser.new do |o|
            o.on('-m', '--month [MONTH]', 'Specify the month') { |v| @options[:month] = v }
            o.on('-y', '--year [YEAR]', 'Specify the year') { |v| @options[:year] = v }
            o.on('-h', '--help', 'show this help') {|v| puts o; exit }
            o.parse!(ARGV)
        end
        options_to_i()
    rescue OptionParser::InvalidOption
        @options = {}
    end

    def has?(name)
        @options.include?(name)
    end

    def get(name)
        @options[name]
    end


    private
    def options_to_i()
        @options.each do |key, value|
            @options[key] = Integer(value)
        end
    rescue
        
    end
end

# 引数で指定した月のカレンダーを表示するメソッド
def show_month_calendar(month = Date.today.month, year = Date.today.year)
    # 対象付きの情報を取得
    first_day = Date.new(year, month, 1)
    last_day = Date.new(year, month, -1)
    days = [*1..last_day.day]
    
    #月初めの曜日に応じて表示をずらす
    calendar_start_position = first_day.wday
    calendar_start_position.times do
        days.unshift(" ")
    end
    
    # カレンダーの共通パーツの設定
    calendar_title = first_day.strftime("%Y年 %m月").center(19)
    calendar_header = ["日","月","火","水","木","金","土"]

    # カレンダーを表示
    puts calendar_title
    puts calendar_header.join(" ")
    days.each_with_index  do |day, i|
        print day.to_s.length < 2 ? " " + day.to_s + " " : day.to_s + " " #1桁日の表示調整
        puts "\n" if (i+1)%7 == 0
    end
end


# 実行
option = AppOption.new
month = option.has?(:month) ? option.get(:month) : Date.today.month
year = option.has?(:year) ? option.get(:year) : Date.today.year

show_month_calendar(month, year)
