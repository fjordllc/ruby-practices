# frozen_string_literal: true

require 'optparse'

# 表示列の最大数をココで変更
COLUMN = 3

# 表示時に必要な行数rowを求める
def calc_row(num)
  (num % 3).zero? ? num / 3 : (num / 3) + 1
end

# ファイル一覧をlsのルールに従い表示
def display(files, row)
  row.times do |y|
    COLUMN.times { |x| printf(files[x * row + y].to_s.ljust(files.map(&:size).max + 3)) }
    puts
  end
end

opt = OptionParser.new
params = {}
opt.on('-a') { |v| params[:a] = v }
opt.parse!(ARGV)

disp_files = Dir.glob('*', File::FNM_DOTMATCH) if params[:a]
disp_files = Dir.glob('*') if params == {}

# display files
sorted_files = disp_files.sort
display(sorted_files, calc_row(sorted_files.size))
