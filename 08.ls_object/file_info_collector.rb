# frozen_string_literal: true

class FileInfoCollector
  attr_reader :target_files

  def initialize(options)
    @target_files = FileExtractor.new(options).target_files
  end

  def build_file_details
    file_details = []
    target_files.each do |file_name|
      file_detail = {}
      stat = File.lstat(file_name)
      file_mode = stat.mode.to_s(8)
      file_mode = file_mode[0] == '1' ? file_mode : format('%06d', file_mode).to_s
      file_detail['mode'] = FileInfoFormatter.format_mode(file_mode)
      file_detail['nlink'] = stat.nlink.to_s
      file_detail['uid'] = Etc.getpwuid(stat.uid).name
      file_detail['gid'] = Etc.getgrgid(stat.gid).name
      file_detail['size'] = stat.size.to_s
      file_detail['date'] = FileInfoFormatter.format_date(stat.mtime)
      file_detail['file_name'] = file_name
      file_details.push(file_detail)
    end
    file_details
  end
end
