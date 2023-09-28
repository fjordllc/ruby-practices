# frozen_string_literal: true

def get_files_and_directories(path)
  Dir.entries(path).sort # path配下にあるhiddenfileを含む全てのファイルとフォルダを取得
end

def ls_with_options(contents, option)
  # optionの指定がない時
  if option.nil?
    filtered_contents = contents.filter { |content| !content.start_with?('.') } # hidden fileをcontentsから除外する。
  # else 以下にoptionが存在する時、各記号によって処理を加える予定。
  end

  show_ls(filtered_contents)
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
