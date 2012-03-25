Webクリエータのための多言語対応Webサイト高速構築ツール

* hamlなので
  * コーディングが速い！
  * 厳密なコーディングができる！
* gitなので
  * 変更の反映が速い！
  * 差分の管理が楽！
  * コラボレーションが楽！
* Sinatraなので
  * Apache不要！
  * PaaSを使って瞬時にWebサイト開設！
  * 簡単にインタラクティブコンテンツを追加できる！
* i18nなので
  * 言語の追加が簡単！
  * メッセージ定義ファイルがシンプル！

以下のような人にお勧めです.

* Webをコーディングするスピードを高めたいフリーランスのWebデザイナ
* TwitterとblogだけではかっこつかなくなってきたからそろそろばりっとしたWebサイトつくりたい, Webのプロ向けのツールなんぞほとんど持ってないけどMacだけは持っている市民活動家
* 学校の先生に「前略プロフのアカウント取っちゃいけません」って言われた小中学生


# 凡例

$ではじまっている行は, $のあとに続く文字列がコマンドであることを表しています.
例えば,

```
$ cd maribase
```

は, Terminalにcd maribaseと入力して, returnを押すことを表しています.

```
maribase$
```

は, cdで移動後のディレクトリ内で次のコマンドを入力することを表しています.


# 準備（MacOSXの場合）

準備は少々大変ですが, 一度やっておくとLokkaなどの他のRubyベースのWebアプリケーションをスムーズに導入できるし, UNIXコマンドラインの初歩的な操作方法を覚えられるのでいろいろとお得です.
また, あなたが今日からプログラミングを学ぶことができる環境が同時に手に入ります. そう, Macならね.

## Xcodeのインストール

### Lionの場合

Mac App StoreからXcode4をインストールしてください.

### SnowLeopardの場合

Developer ZoneからXcode3が無料で利用できます.
https://developer.apple.com/devcenter/ios/index.action#downloads

### Leopardの場合

まずOSをアップグレードしましょう.


## MacPortsまたはHomebrewのインストール

どちらもMacOSXに伝統的なUNIX向けに書かれた多くのソフトウェアをインストールするためのパッケージ管理システムです.
MacPortsの歴史は古く, 多くのソフトウェアが安定して利用できます.
後発のHomebrewはよりシンプルな仕組みで動き, 未知のソフトウェアを導入する手順がMacPortsよりも簡単です.

### MacPortsを利用する場合



### Homebrewを利用する場合

準備中（とりあえず以下のURL見といて）
http://tech.caph.jp/2011/04/06/homebrew%E3%81%AE%E5%B0%8E%E5%85%A5%E3%81%A8%E4%BD%BF%E3%81%84%E6%96%B9/



# 準備（Debian GNU/Linuxの場合）

```
$ sudo apt-get install build-essential
$ sudo apt-get install git-core
```


# 準備（共通）

MariBaseはRubyという言語でつくられているので, Rubyアプリケーションを動作させるための環境（処理系という）をインストールします.

```
$ bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
$ source ~/.bash_profile
$ rvm requirements
$ rvm install 1.9.3
$ gem install shotgun
```


# MariBaseのインストール手順

MariBase自体のインストール手順はMac, Linux問わず共通だよ.

```
$ git clone git://github.com/miminashi/maribase.git
$ cd maribase
maribase$ bundle install --path vendor/bundle
```


# 起動手順

```
maribase$ shotgun config.ru
```

Webブラウザで http://localhost:9393/ を開く


# Webサイトのつくりかた

## エディタの選択

miやCotEditorでも構いませんが、hamlを正しく色分け表示できるエディタが良いでしょう.
個人的にはVim for Macがお勧めです.


## ファイルの編集

* viewsディレクトリ以下のディレクトリ構造がほぼそのままブラウザから見えるツリー構造（パス）に対応する
* index.hamlに対応するパスは / であり, /index ではない
* layout.hamlはレイアウト（枠）を定義するファイルなので, パスには含まれない

試しに, index.hamlを改変してみましょう.
body要素の中身だけを書くつもりで書いてみてください.

hamlの書き方については, 以下のページが参考になります.
http://labs.unoh.net/2009/05/5haml.html
最初は違和感があるかもしれませんが, hamlに慣れてしまうとHTMLをベタ書きするのが煩わしく感じられるほど簡潔にコーディングできます.

アドバイス:
* サイト内のリンクは全て / からの絶対パスで記述することをお勧めします

JavaScript, CSS, 画像などのファイルは public 以下に配置します.
public/css/main.css は /css/main.css として参照できます.


## 国際化

例えば,

views/hoge.haml

```
%p= t.site.hoge
```

i18n/ja.yml

```
site:
  hoge: ほげ
```

i18n/en.yml

```
site:
  hoge: hoge
```

とした場合, ブラウザの言語設定が

日本語の場合

```
<p>ほげ</p>
```

英語の場合

```
<p>hoge</p>
```

と出力されます.


# 公開手順

## サイト作成中での一時的な公開

コラボレーションしている相手に見せるときなどに, proxylocalを利用するのが便利です.
わざわざファイル送る必要すらありません.

### proxylocalのインストール

```
$ gem install proxylocal
```

### proxylocalの起動

shotgunがlocalhost:9393で起動しているとしてます.

```
$ proxylocal 9393
```

接続に成功するとURLが表示されるので, コラボレーション相手にそのURLを伝えます.


## 公開環境の選択

a) とりあえず試してみたい
-> heroku, fluxflexなどのPaaSがお勧めです

b) 受託でWebサイトをつくっていて, 多数のクライアントを抱えている
-> さくらVPSに全てのクライアントのWebサイトをまとめてしまうのがお勧めです


# 質問, バグ報告など
@miminashiまでお気軽にどうぞ.

