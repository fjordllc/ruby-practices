#!ruby

require_relative 'ls_methods'

# 現在のディレクトリ配下の全てのファイルシステムを取得
pwd = fetch_present_working_directory
contents_list = get_current_directory_contents(pwd)

# ls の結果を表示
contents_list.each do |content|
  print "#{content} "
end
