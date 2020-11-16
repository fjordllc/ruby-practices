# ruby-practices

フィヨルドブートキャンプのRubyプラクティスの提出物をまとめるリポジトリです。

# How to use

1. 右上の `Fork` ボタンを押してください。
2. `#{自分のアカウント名}/ruby-practices` が作成されます。
3. 作業PCの任意の作業フォルダにて git clone してください。

```
$ git clone https://github.com/自分のアカウント名/ruby-practices.git
```

4. 各プラクティスの提出物ファイルを該当のフォルダの中に作成してください。
5. ソースコードが完成したら、提出前にrubocopを実行し、警告の箇所を修正してください。

```
# fizzbuzzのフォルダに配置したファイルをrubocopで確認する例
# 設定ファイルとして、ルートディレクトリにある .rubocop.yml が使用されます。
$ cd ruby-practices/01.fizzbuzz
$ rubocop
```

6. 自分のリポジトリへのPull Requestを作成し、URLを提出してください。
