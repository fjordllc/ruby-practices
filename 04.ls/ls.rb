#!ruby

require_relative 'ls_methods'
def main
  p LsMethods.new.ls_without_any_options

  # 現在のディレクトリ配下の全てのファイルシステムを取得
  # pwd = fetch_present_working_directory
end

main
