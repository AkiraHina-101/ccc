# カスタマイズIDE

カスタマイズIDE

Python リボンからアクセスできる Jupiter の PSJ 用にカスタマイズされた IDE です。

この IDE は以下をサポートしています。

文字入力
コードのハイライト

オートコンプリート

ツールチップ

スクリプトのグループブロック（折りたたみ/展開）

File メニュー

Edit メニュー

View メニュー

Run メニュー

データベース

文字入力​

コードのハイライト​

Python キーワードや PSJ-API が異なる色で強調表示されます。
この強調表示対象のキーワードはデータベースフォルダに保存されています。

また、単語をダブルクリックした時は同じ単語がハイライト表示（黄色）されます。

オートコンプリート​

IDE に入力した文字列に基づいて、入力しようとしている単語を予測し、候補を表示します。

たとえば、「Geometry.Me」と入力すると、「Me」で始まる単語が表示されます。

オートコンプリートのデータはデータベースフォルダに保存されており、以下をサポートします。

IDE 内のすべての単語

Python キーワード

PSJ-ユーティリティ

PSJ-コマンド

ツールチップ​

単語を入力すると、その単語の補足説明などが表示されます。

たとえば、 JPT.ClearLog（と入力すると、 JPT.ClearLogドキュメントを示すツールチップが表示されます。

定義した関数の docstring も表示されます。

ツールチップのデータはデータベースフォルダに保存されています。

スクリプトのグループブロック（折りたたみ/展開）​

コードブロックのグループ化をサポートしています。（コードの一部を表示／非表示ができます。）

File メニュー​

 | 名前 | 説明 | ショートカットキー

 | New | 新規のドキュメントを開きます。 | ^ Ctrl + N

 | Open | 保存済の Python スクリプトファイルを開きます。 | ^ Ctrl + O

 | Save | Python スクリプトファイルを保存します。 | ^ Ctrl + S

 | Save As | Python スクリプトファイルに別名をつけて保存します。 | ^ Ctrl + E

 | Exit | IDE を終了します。 | ^ Ctrl + Q

Edit メニュー​

 | 名前 | 説明 | ショートカットキー

 | Undo | 実行した操作を取り消し、ひとつ前の状態に戻します。 | ^ Ctrl + Z

 | Redo | 取り消した操作を再実行します。 | ^ Ctrl + Y

 | Cut | 選択したテキストを切り取ります。 | ^ Ctrl + X

 | Copy | 選択したテキストをコピーします。 | ^ Ctrl + C

 | Paste | カット/コピーしたテキストを貼り付けます。 | ^ Ctrl + V

 | Import Macro Log | 実行したコマンドのマクロを JPT.Exec（macro command）の形式でインポートします。 | ^ Ctrl + M

 | Import Python Macro Log | 実行された PSJ-コマンドをインポートします。 | ^ Ctrl + J

 | Import Script From Last Run | IDE で最後に実行した Python スクリプトをインポートします。 | ^ Ctrl + L

 | Find | スクリプトで特定の文字を検索します。 | ^ Ctrl + F

 | Comment | 選択したスクリプトの前にコメントタグ ＃を挿入します。 | ^ Ctrl + K

 | Toggle Comment | コメント ⇔ コメント解除の切り替えを行います。 | ^ Ctrl + T

 | Go To Line | スクリプトの特定の行に移動します。 | ^ Ctrl + G

 | Find And Replace | スクリプト内の特定の文字を見つけて置き換えます。 | ^ Ctrl + H

View メニュー​

 | 名前 | 説明 | ショートカットキー

 | Toggle Text Wrapping | IDE のサイズに合わせたコードの折り返し表示の設定をおこないます。 | ^ Ctrl + W

Run メニュー​

 | 名前 | 説明 | ショートカットキー

 | Run All | すべてのスクリプトを実行します。 | F5

 | Run Selected | 選択されているスクリプトのみを実行します。 | F6

データベース​

IDE データベースは、Jupiter インストールフォルダー/ IDEData /に保存されます。
このデータベースは編集できます。

各ファイルの内容

Keywords.dat：IDE 上でハイライトされるキーワード

PSJCommandCalltips.dat：PSJ-コマンドのオートコンプリートとツールチップデータ

PSJUtilityCalltips.dat：PSJ-ユーティリティのオートコンプリートとツールチップデータ

PSJPythonHelperCalltips.dat：PSJPython ヘルパーのコールチップ
