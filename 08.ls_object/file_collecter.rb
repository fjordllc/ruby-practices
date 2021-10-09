# frozen_string_literal: true

class FileCollecter
  def initialize(params)
    @params = params
  end

  def collect
    files = @params['a'] ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    @params['r'] ? files.sort.reverse : files.sort
  end
end
