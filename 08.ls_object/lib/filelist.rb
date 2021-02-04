# frozen_string_literal: true

require './lib/filedata'

class FileList
  attr_reader :target, :files

  def initialize(target)
    @target = target || Dir.pwd
  end

  def file_stat
    files.map { |file| FileData.new(target, file) }
  end

  def contain_dotfile
    @files = Dir.glob('*', File::FNM_DOTMATCH, base: target).sort
  end

  def without_dotfile
    @files = Dir.glob('*', base: target).sort
  end
end
