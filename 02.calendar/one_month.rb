require 'date'

# 月間を表すクラス
# 年月を引数にわたしてその月の週や週の数などを取得
class OneMonth
  attr_reader :year, :month

  def initialize(year, month)
    raise ArgumentError, "year `#{year}` not in range 1..9999" unless valid_year?(year)

    raise ArgumentError, "#{month} is neither a month number(1..12) nor a name" unless valid_month?(month)

    @year = year
    @month = month
    @last_day = Date.new(@year, @month, -1).day
    @weeks = []
    init_weeks
  end

  # 月間に含まれる週ごとの日付を要素とするArrayオブジェクトを返す
  # 週の日付の並び順は日曜日の日付を始めとして土曜日の日付を格納
  # 曜日に紐づく日付が存在しない場合の要素はnil
  def weeks
    @weeks.each { |week| yield week.values }
  end

  private

  # @weeksを作成するための初期処理
  def init_weeks
    d = 1
    while d <= @last_day
      week = { 0 => nil,
               1 => nil,
               2 => nil,
               3 => nil,
               4 => nil,
               5 => nil,
               6 => nil }

      week.each_key do |wday|
        break if d > @last_day

        if wday == day_of_week(d)
          week[wday] = d
          d += 1
        end
      end
      @weeks.push(week)
    end
  end

  # 日付に応じた曜日(0から6までで、0は日曜)を返す
  def day_of_week(day)
    Date.new(@year, @month, day).wday
  end

  def valid_month?(month)
    month >= 1 && month <= 12
  end

  def valid_year?(year)
    year >= 1 && year <= 9999
  end
end
