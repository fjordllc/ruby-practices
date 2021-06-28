require 'optparse'
require 'etc'

# メインメソッド
def main
  opt = OptionParser.new
  params = {}

  opt.on('-a') { |v| params[:a] = v }
  opt.on('-l') { |v| params[:l] = v }
  opt.on('-r') { |v| params[:r] = v }

  opt.parse!(ARGV)
  # カレントディレクトリ内のファイルを取得して配列に格納する
  files = Dir.foreach('.').to_a
  # aオプションが付けられていない場合は、先頭にピリオドがあるファイルを配列から除外する
  files = files.filter { |file_name| !file_name.start_with?('.') } unless params[:a]
  # 取得したファイル名を昇順にソート
  files = files.sort.to_a

  # rオプションが付与されている場合は、配列を逆順にソートする
  files = files.reverse.to_a if params[:r]

  if params[:l]
    # lオプションが付与されている場合は、ファイルの各情報を出力する処理を行う
    l_option(files)
  else
    # lオプションが付与されていない場合は、ファイル名のみを表示する処理を行う
    none_l_option(files)
  end
end

# lオプションの処理を行うメソッド
def l_option(files)
  # ファイル名を格納した配列の各要素のFile::Statインスタンスを作成し、新しい配列に格納
  files_class = files.map do |file|
    File::Stat.new(file)
  end

  # クラス配列内の各インスタンスのファイルモードを8進数に変換し、配列に格納
  files_mode_tos8 = filesmode_tos8conversion(files_class)

  # 取得したファイルモード(8進数)から権限を取得する
  owner_authority = []            # 所有者権限
  owner_group_authority = []      # 所有グループ権限
  other_authority = []            # その他権限
  i = 0
  files_mode_tos8.each do |files_mode|
    owner_authority[i] = files_mode[3, 1]
    owner_group_authority[i] = files_mode[4, 1]
    other_authority[i] = files_mode[5, 1]
    i += 1
  end

  owner_authority = make_authority(owner_authority)
  owner_group_authority = make_authority(owner_group_authority)
  owner_group_authority = make_authority(other_authority)

  # ファイルモードの8進数上位2桁の値によって、ファイルの種類を判定
  file_type = file_type_judge(files_class)

  j = 0
  # ファイルモードを連結してパーミッションを作成し配列に格納
  files_permission = []
  files.length.times do
    files_permission[j] = file_type[j] + owner_authority[j] + owner_group_authority[j] + other_authority[j]
    j += 1
  end

  # ファイルのハードリンク数、 ユーザー名、グループ名、ファイルサイズ、タイムスタンプを取得し配列に格納
  files_hardlink = files_class.map(&:nlink)
  files_username = files_class.map do |file|
    Etc.getpwuid(file.uid).name
  end
  files_groupname = files_class.map do |file|
    Etc.getgrgid(file.gid).name
  end
  files_size = files_class.map(&:size)
  files_time = files_class.map(&:mtime)

  # ファイルのブロック数の合計を求める
  file_block = files_class.sum(&:blocks)

  # ファイルの各情報を出力
  l_option_output(files, file_block, files_permission,
                  files_hardlink, files_username, files_groupname, files_size, files_time)
end

# ファイルモードを8進数に変換するメソッド
def filesmode_tos8conversion(files_class)
  files_mode_tos8 = []
  i = 0
  files_class.each do |file|
    files_mode_tos8[i] =
      if file.mode.to_s(8).length == 5
        # ファイルモードが5桁の場合は、先頭に0を付ける
        [0.to_s, file.mode.to_s(8)].join
      else
        files_mode_tos8[i] = file.mode.to_s(8)
      end
    i += 1
  end
  files_mode_tos8
end

# 取得したファイルモードからファイルの種類を判定するメソッド
def file_type_judge(files_class)
  file_type = []
  file_type_hush = { '04' => 'd', '10' => '-', '12' => 'l' }
  i = 0
  files_class.each do |file|
    # ファイルモードの上位2桁を取得
    top_2digit =
      if file.mode.to_s(8).length == 5
        # ファイルモードが5桁の場合は、先頭に0を付けてから取得
        [0.to_s, file.mode.to_s(8)].join[0, 2]
      else
        file.mode.to_s(8)[0, 2]
      end
    # ハッシュから上位2桁の値に応じたファイルの種類を取得
    file_type[i] = file_type_hush[top_2digit]
    i += 1
  end
  file_type
end

# 権限を表す数値(8進数)を2進数に変換したのち、対応に基づいて権限の記号を付与するメソッド
def make_authority(authority)
  i = 0
  authority_hush = { '0' => '---', '1' => '--x', '10' => '-w-', '11' => '-wx', '100' => 'r--',
                     '101' => 'r-x', '110' => 'rw-', '111' => 'rwx' }
  authority.each do |item|
    authority[i] = authority_hush[(item.to_i).to_s(2)]
    i += 1
  end
  authority
end

# lオプションの結果と同じような形式でファイルの情報を出力するメソッド
def l_option_output(arrays, file_block, files_permission,
                    files_hardlink, files_username, files_groupname,
                    files_size, files_time)
  i = 0
  # Timeインスタンスを生成
  nowis = Time.new
  # ブロック数を出力
  puts ['total ', file_block.to_s].join
  arrays.length.times do
    output = [files_permission[i], '  '].join
    output = [output, files_hardlink[i].to_s, '  '].join
    output = [output, files_username[i], '  '].join
    output = [output, files_groupname[i], '  '].join
    output = [output, files_size[i].to_s, ' '].join
    output = [output, files_time[i].month.to_s, ' '].join
    output = [output, files_time[i].day.to_s, ' '].join
    if nowis.year != files_time[i].year
      # タイムスタンプの年と、現在の年が異なっている場合は時間ではなく年を表示
      output = [output, files_time[i].year.to_s, ' '].join
    else
      # タイムスタンプの年と、現在の年が同じの場合は時間、分を出力
      # タイムスタンプの時間と分が一桁の場合は、0を付けて出力
      output =
        if files_time[i].hour.to_s.length == 1
          [output, '0', files_time[i].hour.to_s, ':'].join
        else
          [output, files_time[i].hour.to_s, ':'].join
        end
      output =
        if files_time[i].min.to_s.length == 1
          [output, '0', files_time[i].min.to_s].join
        else
          [output, files_time[i].min.to_s].join
        end
    end
    output = [output, ' ', arrays[i]].join
    puts output
    i += 1
  end
end

# lオプションを付けない場合の処理を行うメソッド
def none_l_option(files)
  # 表示する行数
  column = 3

  # 1列あたりの行数を求める
  row = (files.length.to_f / column).ceil

  # ファイル数が「1列あたりの行数の倍数」でない場合
  # 配列を行列に見立てた場合に、行と列の数がズレてエラーになるので
  # nilを挿入して行と列の数を揃える
  if (files.length % column) != 0
    count = column * row - files.length
    count.times do
      files.push(nil)
    end
  end

  # 1列あたりの行数で配列を分割
  files = files.each_slice(row).to_a

  # 配列を行列と見立てて行と列を入れ替え
  files = files.transpose

  # ファイル名を出力
  none_l_option_output(files, column)
end

# lオプションを付けない場合にファイル名を出力するメソッド
def none_l_option_output(files, column)
  index = 0
  while index < files.size
    i = 1
    # nilの要素は配列から除外する
    files = files.map { |file| file.filter { |f| !f.nil? } }
    output = files[index][0].ljust(15, ' ')
    while i < column
      unless files[index][i].nil?
        # この条件がないと、ファイル数が1列あたりの行数未満の場合にエラーが出る
        output += [' ', files[index][i].ljust(15, ' ')].join
      end
      i += 1
    end
    print(output)
    print("\n")
    index += 1
  end
end

main
