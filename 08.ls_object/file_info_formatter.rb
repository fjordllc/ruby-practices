# frozen_string_literal: true

class FileInfoFormatter
  FILE_TYPE = {
    '01' => 'p',
    '02' => 'c',
    '04' => 'd',
    '06' => 'b',
    '10' => '-',
    '12' => 'l',
    '14' => 's'
  }.freeze

  FILE_ACCESS_RIGHTS = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }.freeze

  class << self
    def format_mode(mode)
      file_type = FILE_TYPE[mode.slice(0, 2)]
      file_access_right_user = FILE_ACCESS_RIGHTS[mode.slice(3)]
      file_access_right_group = FILE_ACCESS_RIGHTS[mode.slice(4)]
      file_access_right_other = FILE_ACCESS_RIGHTS[mode.slice(5)]
      "#{file_type}#{file_access_right_user}#{file_access_right_group}#{file_access_right_other}"
    end

    def format_date(date)
      if date.year == Time.now.year
        "#{date.month} #{date.day} #{date.hour.to_s.rjust(2, '0')}:#{date.min.to_s.rjust(2, '0')}"
      else
        "#{date.month} #{date.day} #{date.year}"
      end
    end
  end
end
