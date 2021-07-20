モデル名 Task

| name | detail |
| ---- | ------ |
|string| string |
|      |        |
|      |        |



# herokuへのデプロイ方法h1

1.herokuに新しいアプリケーションを作成
  heroku create　コマンドを開発してるローカルアプリケーションに位置していることをターミナルで確認して、実行。

2.アセットプリコンパイルする。
  rails assets:precompile RAILS_ENV=production　コマンドを実行。

3.GemfileのRubyバージョンをコメントアウトし、bundle installコマンドを実行。(Gemfile ruby '2.6.5' になってる為)

4.Heroku buildpackを追加する。
  heroku buildpacks:set heroku/ruby と heroku buildpacks:add --index 1 heroku/nodej コマンドを実行。

5.herokuにデプロイする。
  git push heroku "開発ブランチ/master"
