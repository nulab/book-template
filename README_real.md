# Markdown記法

今回は、MarkdownファイルからPDFへの変換を実現するために、[Pandoc](http://sky-y.github.io/site-pandoc-jp/users-guide/)というツールでサポートされている、拡張Markdown記法を使います。
また、PDFに変換する際にLatexという形式を経由しますので、整形のために一部Latexコマンドも使います。

代表的な構文を紹介します。詳しい使い方は、各サイトもしくはchapter3のmarkdownファイルを参照してください。ここであげた構文は、chapter3中で一度は使用しています。

## 見出し

行頭に"#"を付けます。"1.1.1 はじめに"などの"1.1.1"の見出し番号は自動採番されるので、明示的な記載は不要です。

```
# 見出し1
## 見出し2
### 見出し3
#### 見出し4 {-}
```

見出しは4階層までを想定しています。見出し3までは"1.1.1 見出し3"のように見出し番号付きで表示しますが、見出し4は見出し番号無しで表示するために'{-}'を付けます。

（この辺は中村の趣味なので、DTP作業時に変更入るとは思います）

## 箇条書き（リスト）

順序無しの箇条書きは、行頭に"*"です。

```
* 箇条書き1-1
* 箇条書き1-2
  * 箇条書き2-1
  * 箇条書き2-2
```

順序付きの箇条書きは、行頭に"1."です。

```
1. 箇条書き1-1
1. 箇条書き1-2
  1. 箇条書き2-1
  1. 箇条書き2-2
```

## 図

図は、以下の3つのセットで定義します。

* Cacooで作った図のURL（Markdown記法での図挿入）
* 図を自動採番するためのラベル（\label）
* 図のラベルを本文中から参照する定義（\ref）

Cacooについては、後述します。使用例は以下のようになります（"3_1_background.md"から抜粋）。

```
手間暇かけて自動化しても何度も実行するものではないため、コストに見合うだけのリターンが得られなかったのです（**図\ref{fig-setupByHand}**）。

![インフラ構築の手作業での対応\label{fig-setupByHand}](https://cacoo.com/diagrams/8YtMvS2GoF4j6Vhp-95A35.png)
```

このときのPDF上での図参照イメージは、以下のようになります。図番号を直接記載せずに、ラベル経由で参照することにより図番号が自動採番されるため、図の順序を入れ替えても図番号も入れ替える必要がなくなります。

![図参照のイメージ](https://cacoo.com/diagrams/8YtMvS2GoF4j6Vhp-95A35.png)

## 表

基本的には図と同じです。表組みと表のラベルを定義し、ラベルを本文中から参照します（"3_2_infra_as_code.md"から抜粋）。

```
**表\ref{tab-comparisonOfprovisioningTool}**に、構成管理ツールの比較表を示します。

| ツール | 1stリリース | 定義構文 | 学習コスト | 柔軟性 | 特徴 |
|:--------|:-----:|:--------|:--:|:--:|:--------------------------|
| Puppet  | 2005年 | 独自言語 | 高 | 高 | 歴史が古く、ノウハウがたまっている |
| Chef    | 2009年 | Ruby   | 高 | 高 | 柔軟性が高く、適用範囲が広い |
| Ansible | 2012年 | YAML   | 中 | 中 | YAMLベースでシンプルに記述可能 |
| Itamae  | 2014年 | Ruby   | 低 | 中 | Rubyベースかつ、Chefよりシンプル |

  : \label{tab-comparisonOfprovisioningTool}構成管理ツールの比較
```

Pandocで定義されている表組み構文をいくつか試しましたが、ここで例にあげた[パイプテーブル](http://sky-y.github.io/site-pandoc-jp/users-guide/#%E3%83%91%E3%82%A4%E3%83%97%E3%83%86%E3%83%BC%E3%83%96%E3%83%AB)が一番楽なようです。

## コードブロック

コードブロックは"```"で表します（"3_2_infra_as_code.md"から抜粋）。

    ```
    $ aws ec2 describe-instances
    {
        "Reservations": [
            {
                "OwnerId": "063264636398",
                "ReservationId": "r-06f31733",
    ...
  　```

## 段落分け

一行以上の空行を挟むと、段落分けされます。

## 脚注

脚注は、脚注のラベルを定義として、そのラベルを本文から参照します（"3_1_background.md"から抜粋）。

```
例えば、RHEL系Linuxを自動インストールするための仕組みであるKickstart[^kickstart]や、Kickstartに基づいて更にDHCPやDNSといったサービスを構成するCobbler[^cobbler]が挙げられます。

[^kickstart]: https://access.redhat.com/documentation/ja-JP/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/ch-kickstart2.html
[^cobbler]: http://cobbler.github.io/
```

このときのPDF上での脚注のイメージは、以下のようになります。

![脚注のイメージ](https://cacoo.com/diagrams/8YtMvS2GoF4j6Vhp-8FF44.png)

## コラム構文

コラム構文はMarkdown記法に存在しないので、`\begin{itembox}`~`\end{itembox}`というLatexコマンドで実現します（"3_4_advanced_practice.md"から抜粋）。

```
\begin{itembox}[l]{コラム：DevOpsを支えるツール群}
例として、前述したVagrant/Packer/Serf/Consulを提供しているHashiCorp\footnote{https://hashicorp.com/}や、クックパッドが提供しておりAWSの各種サービスやいくつかのミドルウェアを制御できるCodenize.tools\footnote{http://codenize.tools/}があげられます。
\end{itembox}
```

このときのPDF上でのコラムのイメージは、以下のようになります。

![コラムのイメージ](https://cacoo.com/diagrams/8YtMvS2GoF4j6Vhp-CD169.png)

Latexコマンドを直接扱う関係上、Markdown記法が使えません。上記の例では、脚注を`\footnote{url}`でLatex側で実現しています。また、脚注がコラム内に入ってるなど、いくつか見栄え的にあまりよくないところがありますが、このPDFはDTPまでのつなぎということでいったんこのままにしておきます。

## コメントアウト

MarkdownはHTML記法も解釈できるので、HTMLのコメントアウトを利用できます。PDF上にも表示されませんので、メモ用に利用しておくといいでしょう。

```
<!--
TODO コラムネタをここではさむ
-->
```

## 改ページ

節（例："1.1 過去から現在まで"）の最後に改ページを促すコマンドを定義しておいてください。節が切り替わるごとに改ページされた状態でPDFが作成されます。

```
\pagebreak
```

## その他注意事項

* 見出しや箇条書き・コードブロックや図表の前後は、一行はさみましょう。
* 日本語文字と英字の間のスペースは無しで統一しましょう（Latex側で自動で半角スペースが入ります）。
* 文字コードはUTF-8にしてください（それ以外だと、PDFファイルへの変換がうまくできないので）。

中村は、Markdownエディタに[Atom](https://atom.io/)を使っているので、Atomだとある程度サポートできます。Windows版も提供されているので、特にこだわりなければAtomでいいかと思います。

# 図の作成

原稿内で使う図を書くためのサービスとして、[Cacoo](https://cacoo.com)を用意しました。

PNGファイルなどではなくCacooの図をMarkdown中で直接参照するようにしておくと、Cacoo中で図の更新を行っても再度PNGに落としこむ必要がなくリアルタイムで反映されます。

Cacoo内の標準ステンシル（アイコン）は、著作権フリーですのでそのままご利用になれます。外部から持ってきた画像もはれますが、その著作権はご自身でご確認ください。なお、最終的にCacoo上の図をそのまま利用するかは、DTP時に作業しながら確認することになると思います。

## 図の書き方

編集ボタン押下後、編集画面上でお好きなように図を作成ください。

1シートが1つの図に対応します。なので、図1-1, 図1-2といった図ごとにシートを作成する形になります。

## 図のURLの取得方法

編集画面で保存ボタンを押下すると、各シートごとにURLが割り当てられます。こちらのURLをMarkdown中でお使いください。各URLは一意なので、シート名を変更してもMarkdownファイル中のURLを変更する必要はありません。

![図のURLの取得方法](https://cacoo.com/diagrams/8YtMvS2GoF4j6Vhp-685C5.png)

# PDFへの変換・文字数カウント

成果物確認と進捗状況を把握するためのファイルを、定期的に生成しています。

* book.pdf : Markdownファイルから、全章通して1つにまとめたPDFファイル
* book-count.png : 各章の文字数を、1日ごとにプロットしたグラフ

それぞれスクリプト化して、中村のPC上で毎朝5:00に定期実行しています。もちろん、Dropboxと同期しているので、PDF・グラフ作成後すぐにリモートに反映されます。

Dockerやgnuplotを使ったり無駄に凝ってますので、興味がある方は"writing-support"ディレクトリを眺めてください。"writing-support.sh"がエントリポイントのスクリプトです。Dockerの環境さえあれば、みなさんの環境でも実行できると思います。

## ファイル名の命名規約

このスクリプトの前提として、ファイル名は以下のように命名してください。ファイル名に日本語は含めず、全てアルファベットとするようお願いします。

* 章で1つのファイルにする場合：1_*.md
* 節ごとにファイル分割する場合：1\_1_*.md

PDFに変換する際には1つにまとまるので、こだわりがなければ分割しておいた方がやりやすいかなと思います。

例として、chapter3は以下のように命名しています。

```
$ tree
.
├── README.md
├── book-count.png
├── book.pdf
├── chapter1
├── chapter2
├── chapter3
│   ├── 3_1_background.md
│   ├── 3_2_infra_as_code.md
│   ├── 3_3_basic_practice.md
│   └── 3_4_advanced_practice.md
├── chapter4
├── chapter5
├── chapter6
├── chapter7
└── writing-support
```
