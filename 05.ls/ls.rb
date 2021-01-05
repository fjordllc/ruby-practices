# !/usr/bin/env ruby
# frozen_string_literal: true

#ディレクトリの中身を取得(ls)
p Dir.glob("*",).sort
#ディレクトリの中身を逆から取得(ls -r)
p Dir.glob("*",).sort.reverse

#ディレクトリの隠しファイルを含めた中身を取得(ls -a)
p Dir.glob("*", File::FNM_DOTMATCH).sort
#ディレクトリの隠しファイルえお含めた中身を取得(ls -ar/ls -ra)
p Dir.glob("*", File::FNM_DOTMATCH).sort.reverse

#ディレクトリの詳細を含めた中身を取得(考え中)
#           | | usr  |      |   |   | |mtime| ファイルの名前   
#drwxr-xr-x  3 chica  staff   96 12  4 21:14 09.wc_object
#-rw-r--r--@ 1 chica  staff  393  1  4 19:51 a.rtf
#mtime => 最終更新時刻
#p Dir.glob("*",)
