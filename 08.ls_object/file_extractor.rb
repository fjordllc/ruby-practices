# frozen_string_literal: true

class FileExtractor
  # オプションから、対象のファイル群を決めるクラス
  attr_reader :a_option, :r_option

  def initialize(options)
    @a_option = options['a']
    @r_option = options['r']
  end

  def target_files
    target_files = a_option ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    r_option ? target_files.reverse : target_files
  end
end
