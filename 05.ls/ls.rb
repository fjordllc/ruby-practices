# frozen_string_literal: true

class LsCommand
  def main
    @files = Dir.entries('.').sort
    @files = @files.reject { |f| f =~ /^\..*/ }
    word_count = @files.max_by(&:length).length + 1
    @column_count = 5
    @column = 0
    @line_count = 0
    (@files.size + @files.size % @column_count).times do
      if @column == @column_count
        puts "\n"
        @column = 0
        @line_count += 1
      end
      space_count = word_count - @files[now_column].to_s.size
      print @files[now_column]
      space_count.times { print ' ' }
      @column += 1
    end
    puts "\n"
  end

  def now_column
    @line_count + equal_difference * @column
  end

  def equal_difference
    if (@files.size % @column_count).zero?
      @files.size / @column_count
    else
      (@files.size / @column_count).floor + 1
    end
  end
end

l = LsCommand.new
l.main
