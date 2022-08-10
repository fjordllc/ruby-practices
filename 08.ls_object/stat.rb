# frozen_string_literal: true

class Stat
  require 'etc'
  SIX_MONTH = 15_552_000
  def initialize(file)
    @stat = File.stat(file)
    @file = file
  end
  
  def link
   @stat.nlink
  end

  def name
   Etc.getpwuid(@stat.uid).name
  end

   def group
    Etc.getgrgid(@stat.gid).name 
  end

  def size
    @stat.size
  end
  
  def month
    @stat.mtime.mon
  end
  
  def day
    @stat.mtime.mday
  end
  
  def time
    detailed_time = @stat.mtime
      today = Time.new
      time = if today - detailed_time > SIX_MONTH
               "  #{detailed_time.year}"
             else
               " #{detailed_time.strftime('%H:%M')}"
             end
    time.to_s.rjust(6)
  end

  def file_mode
    convert_to_letter(format('0%o', @stat.mode))
  end

  def file_name
    @file
  end
  
  private
  
  def file_types_nums
    {
      '001' => 'p',
      '002' => 'c',
      '004' => 'd',
      '006' => 'b',
      '010' => '-',
      '012' => 'l',
      '014' => 's'
  }.freeze
  end
  
  def file_permissions_nums
    {
      '00' => '---',
      '01' => '--x',
      '02' => '-w-',
      '03' => '-wx',
      '04' => 'r--',
      '05' => 'r-x',
      '06' => 'rw-',
      '07' => 'rwx'
  }.freeze
  end
  
  def convert_to_letter(mode_num)
    formatted_num = mode_num.rjust(7, '0')
    file_type = file_types_nums[(formatted_num[0, 3]).to_s] 
    owner_permission = file_permissions_nums[formatted_num[3, 2].to_s]
    group_permission = file_permissions_nums["0#{formatted_num[5, 1]}"]
    other_permission = file_permissions_nums["0#{formatted_num[6, 1]}"]
    [file_type, owner_permission, group_permission, other_permission].join
  end
end