# frozen_string_literal: true

class Display
  require 'etc'
  def initialize(stats)
    @display = stats
  end

  def l_option
    file_mode = @display.map {|stat|stat.file_mode}
    link = adjust_blank(@display.map {|stat|stat.link},2)
    name = adjust_blank(@display.map {|stat|stat.name},1)
    group = adjust_blank(@display.map {|stat|stat.group},2)
    size = adjust_blank(@display.map {|stat|stat.size},2)
    month = adjust_blank(@display.map {|stat|stat.month},2)
    day = adjust_blank(@display.map {|stat|stat.day},1)
    time = adjust_blank(@display.map {|stat|stat.time},0)
    file_name = @display.map {|stat|" " + stat.file_name}

    file_mode.zip(link,name,group,size,month,day,time, file_name).each do |row|
      puts row.join
    end
  end

  private

  def adjust_blank(contents, blank_size_num)
    max_length = contents.max.to_s.length
    contents.map do |content|
      content.to_s.rjust(max_length + blank_size_num, ' ')
    end
  end


end