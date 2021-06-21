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
  arrays = []
  Dir.foreach('.') do |item|
    if !params[:a] && item.start_with?('.')
      # aオプションが付与されておらず、かつファイル名の先頭がピリオドの場合はスキップ
      next
    end

    arrays.push(item)
  end

  # 取得したファイル名を昇順にソート
  arrays = arrays.sort.to_a

  # rオプションが付与されている場合は、配列を逆順にソートする
  arrays = arrays.reverse.to_a if params[:r]

  if params[:l]
    # lオプションが付与されている場合は、ファイルの各情報を出力する処理を行う
    ls(arrays)
  else
    # lオプションが付与されていない場合は、ファイルを最大3列で表示する処理を行う
    arrays_organize(arrays)
  end
end

# lオプションの処理を行うメソッド
def ls(arrays)
  arrays_class = []
  i = 0
  # ソートした配列の各要素のFile::Statインスタンスを作成し、新しい配列に格納
  arrays.each do |_array|
    arrays_class[i] = File::Stat.new(arrays[i])
    i += 1
  end

  # クラス配列内の各インスタンスのファイルモードを8進数に変換し、配列に格納
  files_mode_tos8 = []
  files_mode_tos8 = filesmode_tos8conversion(arrays_class)

  # 取得したファイルモード(8進数)から権限を取得する
  owner_authority = []            # 所有者権限
  owner_group_authority = []      # 所有グループ権限
  other_authority = []            # その他権限
  k = 0
  files_mode_tos8.each do |files_mode|
    owner_authority[k] = files_mode[3, 1]
    owner_group_authority[k] = files_mode[4, 1]
    other_authority[k] = files_mode[5, 1]
    k += 1
  end

  owner_authority = make_authority(owner_authority)
  owner_group_authority = make_authority(owner_group_authority)
  owner_group_authority = make_authority(other_authority)

  # ファイルモードの8進数上位2桁の値によって、ファイルの種類を判定
  file_type = []
  file_type = file_type_judge(arrays_class)

  arrays_length = arrays.length
  m = 0
  # ファイルモードを連結してパーミッションを作成し配列に格納
  files_permission = []
  arrays_length.times do
    files_permission[m] = file_type[m] + owner_authority[m] + owner_group_authority[m] + other_authority[m]
    m += 1
  end

  # ファイルのハードリンク数、 ユーザー名、グループ名、ファイルサイズ、タイムスタンプを取得し配列に格納
  n = 0
  files_hardlink = []
  files_username = []
  files_groupname = []
  files_size = []
  files_time = []
  arrays_class.each do |array|
    files_hardlink[n] = array.nlink
    files_username[n] = Etc.getpwuid(arrays_class[n].uid).name
    files_groupname[n] = Etc.getgrgid(arrays_class[n].gid).name
    files_size[n] = array.size
    files_time[n] = array.mtime
    n += 1
  end

  # ファイルのブロック数の合計を求める
  file_block = 0
  arrays_class.each do |array|
    file_block += array.blocks
  end

  # ファイルの各情報を出力
  ls_output(arrays, file_block, files_permission, files_hardlink, files_username, files_groupname, files_size, files_time )
end

# ファイルモードを8進数に変換するメソッド
def filesmode_tos8conversion(arrays_class)
  files_mode_tos8 = []
  j = 0
  arrays_class.each do |array|
    files_mode_tos8[j] =
      if array.mode.to_s(8).length == 5
        # ファイルモードが5桁の場合は、先頭に0を付ける
        [0.to_s, array.mode.to_s(8)].join
      else
        files_mode_tos8[j] = array.mode.to_s(8)
      end
    j += 1
  end
  files_mode_tos8
end

# 取得したファイルモードからファイルの種類を判定するメソッド
def file_type_judge(arrays_class)
  file_type = []
  i = 0
  arrays_class.each do |array|
    top_2digit =
      if array.mode.to_s(8).length == 5
        # ファイルモードが5桁の場合は、先頭に0を付けてから取得
        [0.to_s, array.mode.to_s(8)].join[0, 2]
      else
        array.mode.to_s(8)[0, 2]
      end
  
    case top_2digit
    when '04'
      file_type[i] = 'd'
    when '10'
      file_type[i] = '-'
    when '12'
      file_type[i] = 'l'
    when '01'
      file_type[i] = 'p'
    when '02'
      file_type[i] = 'c'
    when '06'
      file_type[i] = 'b'
    when '14'
      file_type[i] = 's'
    end
    i += 1
  end
  file_type
end

# 権限を表す数値(8進数)を2進数に変換したのち、対応に基づいて権限の記号を付与するメソッド
def make_authority(authority)
  i = 0
  authority.each do |item|
    case (item.to_i).to_s(2)
    when '0'
      authority[i] = '---'
    when '1'
      authority[i] = '--x'
    when '10'
      authority[i] = '-w-'
    when '11'
      authority[i] = '-wx'
    when '100'
      authority[i] = 'r--'
    when '101'
      authority[i] = 'r-x'
    when '110'
      authority[i] = 'rw-'
    when '111'
      authority[i] = 'rwx'
    end
    i += 1
  end
  authority
end

# lオプションの結果と同じような形式でファイルの情報を出力するメソッド
def ls_output(arrays, file_block, files_permission, files_hardlink, files_username, files_groupname, files_size, files_time )
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
      output = [output, files_time[i].hour.to_s, ':']
      output =
        if files_time[i].min.to_s.length == 1
          # タイムスタンプの分が一桁の場合は先頭に０を付けてから表示
          [output, '0', files_time[i].min.to_s]
        else
          [output, files_time[i].hour.to_s, ':']
        end
    end
    output = [output, ' ', arrays[i]].join
    puts output
    i += 1
  end
end

# lオプションを付けない場合、ファイル名を3列で出力するためのメソッド
def arrays_organize(arrays)
  # 表示する行数
  column = 3

  # 1列あたりの行数を求める
  row = (arrays.length.to_f / column).ceil

  # 配列を行列に見立てた場合に、行と列の数を揃える処理
  if (arrays.length % column) != 0
    count = column * row - arrays.length
    count.times do
      arrays.push(nil)
    end
  end

  # 1列あたりの行数で配列を分割
  arrays = arrays.each_slice(row).to_a

  # 配列を行列と見立てて行と列を入れ替え
  arrays = arrays.transpose

  # ファイル名を出力
  three_column_output(arrays, column)
end

# ファイル名を出力するメソッド
def three_column_output(arrays, column)
  index = 0
  while index < arrays.size
    i = 1
    output = arrays[index][0].ljust(15, ' ')
    while i < column
      if arrays[index][i].nil?
        # 要素がnilの場合は何もしない
      else
        output += [' ', arrays[index][i].ljust(15, ' ')].join
      end
      i += 1
    end
    print(output)
    print("\n")
    index += 1
  end
end

main
