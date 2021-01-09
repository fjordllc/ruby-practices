# !/usr/bin/env ruby
# frozen_string_literal: true

#ディレクトリの中身を取得(ls)
p Dir.glob("*").sort
#ディレクトリの中身を逆から取得(ls -r)
p Dir.glob("*").sort.reverse

#ディレクトリの隠しファイルを含めた中身を取得(ls -a)
p Dir.glob("*", File::FNM_DOTMATCH).sort
#ディレクトリの隠しファイルえお含めた中身を取得(ls -ar/ls -ra)
p Dir.glob("*", File::FNM_DOTMATCH).sort.reverse

#ディレクトリの詳細を含めた中身を取得(考え中)
#ディレクトリ内のファイルの詳細を出力するようにする
fs = File::Stat.new($0) 
p fs.rdev_major
p fs.dev
p fs.mode
p fs.nlink
p fs.uid
p fs.gid
p fs.size
p fs.mtime
#ディレクトリの名前を取得(考え中)
