# リポジトリ構成

* [chapter*/*.md](chapter1/1_1_sashihara.md) : サンプル原稿
* 生成物
  * [book.pdf](book.pdf) : PDF
  * [book-count.png](book-count.png) : 文字数カウントグラフ
* writing-support : データ生成スクリプト群
  * [writing-support.sh](writing-support/writing-support.sh) : データ生成ラッパースクリプト
  * [Dockerfile](writing-support/Dockerfile) : データ生成環境構築ファイル
  * [header.tex](writing-support/header.tex) : PDF整形設定ファイル
  * [count.plt](writing-support/count.plt) : 文字数カウントグラフ設定ファイル
  * [count_chapter*.dat](writing-support/count_chapter1.dat) : 文字数カウントグラフ生成用データ
* [README_real.md](README_real.md) : 執筆時に実際に用意したREADME

# 実行方法

```
$ docker pull ikikko/book-template
$ writing-support/writing-support.sh
```

* 4G弱のDockerイメージをpullしてくるので、少し時間がかかります
* 何か思うように動かない場合、`writing-support.sh`から追ってみてください

# サンプル文書引用元

* https://ja.wikipedia.org/wiki/指原莉乃
* https://ja.wikipedia.org/wiki/AKB48_45thシングル選抜総選挙
