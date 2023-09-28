# frozen_string_literal: true

def get_files_and_directories(path = '.')
  Dir.entries(path).sort # path配下にあるhidden fileを含む全てのファイルシステムを取得
end

def ls_without_any_options(file_system_arr)
  filtered_file_system_arr = file_system_arr.filter { |content| !content.start_with?('.') } # hidden fileをall_contentsから除外する。
  show_ls(filtered_file_system_arr)
end

def show_ls(contents)
  maximum_length = contents.max_by(&:length).length + 3
  height = contents.length.ceildiv(3)
  # 行のナンバリング
  (0...height).each do |h_num|
    # 列のナンバリング　今回は最大３列までなので最大３つまで表示したら次の行に折り返す。
    3.times do |w_num|
      contents_index = h_num + (height * w_num)
      print contents[contents_index].ljust(maximum_length) if !contents[contents_index].nil?
    end
    puts # ターミナル上で見栄えが悪いので改行。
  end
end
