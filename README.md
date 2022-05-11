# ruby-practices

フィヨルドブートキャンプのRubyプラクティスの提出物をまとめるリポジトリです。

# プラクティスを進めるにあたって

Web上では、プラクティスを通過できる状態のソースコードがそのまま公開されていることもあります。
正解を見てしまわないように注意しながら進めていってください。
実力をつけていくためにも、自分自身の力でソースコードを完成させていきましょう。

# How to use

1. 右上の `Fork` ボタンを押してください。
2. `#{自分のアカウント名}/ruby-practices` が作成されます。
3. 作業PCの任意の作業ディレクトリにて git clone してください。

```
$ git clone https://github.com/自分のアカウント名/ruby-practices.git
```
4. 各プラクティスのブランチを**main**ブランチから作ってください。例えばfizzbuzz用ならば以下のようにします。
```
$ git checkout -b my-fizzbuzz main
```

5. 各プラクティスの提出物ファイルを該当のディレクトリの中に作成してください。
6. ソースコードが完成したら、提出前にrubocopを実行し、警告の箇所を修正してください。
(ただし、fizzbuzz、calendar、rakeの提出時は不要です)

```
# bowlingのディレクトリに配置したファイルをrubocopで確認する例
# 設定ファイルとして、ルートディレクトリにある .rubocop.yml が使用されます。
$ cd ruby-practices/04.bowling
$ rubocop
```

7. Pull Requestを作成し、URLを提出してください。
Pull Requestの作成画面では、merge先として **自分自身のアカウントのruby-practices** を指定してください。
また、**作成したPull Requestは提出後に確認OKをもらうまでmergeのボタンを押さないでください。**
![Pull Request作成画面](https://user-images.githubusercontent.com/2603449/99864665-0c145c00-2be8-11eb-8501-14bd484529f2.png)

# 注意点

- [プルリクエスト形式で提出物を出す際の「これはやっちゃダメ」リスト](https://bootcamp.fjord.jp/pages/317)、[GitHubでコードを提出するときに気をつけること](https://bootcamp.fjord.jp/pages/info-for-github)を一読してください。
- 基本的に、1課題につきPull Requestは1つとします。
- もし、誤って1つのPull Request内に複数の課題の内容を含めてしまった時、修正する方法がわからない場合は、一度リポジトリ自体を消してForkからやり直してください。
