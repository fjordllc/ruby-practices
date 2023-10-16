# frozen_string_literal: true

COLUMN_NUMBER = 3

def get_files(path)
  Dir.entries(path).sort
end

def transform_by_option(contents, option)
  filtered_contents = contents.reject { |content| content.start_with?('.') }

  return filtered_contents.reverse if option[:r]

  filtered_contents
end

def show(contents)
  maximum_length = contents.max_by(&:length).length + 3 # 本家lsコマンドに寄せたスペース幅に調整
  height = contents.length.ceildiv(COLUMN_NUMBER)

  (0...height).each do |h_num|
    COLUMN_NUMBER.times do |w_num|
      contents_index = h_num + (height * w_num)
      print contents[contents_index].ljust(maximum_length) if !contents[contents_index].nil?
    end
    puts # ターミナル上で見栄えが悪いので改行。
  end
end
