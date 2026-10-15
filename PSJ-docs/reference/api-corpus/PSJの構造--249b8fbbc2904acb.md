# PSJの構造

PSJの構造

  	.tebb6baca-f046-4963-9aac-18e66dbd3ae2 {
	    color: #fff;
	    background: #222;
	    border: 1px solid transparent;
  	}

  	.tebb6baca-f046-4963-9aac-18e66dbd3ae2.place-top {
        margin-top: -10px;
    }
    .tebb6baca-f046-4963-9aac-18e66dbd3ae2.place-top::before {
        border-top: 8px solid transparent;
    }
    .tebb6baca-f046-4963-9aac-18e66dbd3ae2.place-top::after {
        border-left: 8px solid transparent;
        border-right: 8px solid transparent;
        bottom: -6px;
        left: 50%;
        margin-left: -8px;
        border-top-color: #222;
        border-top-style: solid;
        border-top-width: 6px;
    }

    .tebb6baca-f046-4963-9aac-18e66dbd3ae2.place-bottom {
        margin-top: 10px;
    }
    .tebb6baca-f046-4963-9aac-18e66dbd3ae2.place-bottom::before {
        border-bottom: 8px solid transparent;
    }
    .tebb6baca-f046-4963-9aac-18e66dbd3ae2.place-bottom::after {
        border-left: 8px solid transparent;
        border-right: 8px solid transparent;
        top: -6px;
        left: 50%;
        margin-left: -8px;
        border-bottom-color: #222;
        border-bottom-style: solid;
        border-bottom-width: 6px;
    }

    .tebb6baca-f046-4963-9aac-18e66dbd3ae2.place-left {
        margin-left: -10px;
    }
    .tebb6baca-f046-4963-9aac-18e66dbd3ae2.place-left::before {
        border-left: 8px solid transparent;
    }
    .tebb6baca-f046-4963-9aac-18e66dbd3ae2.place-left::after {
        border-top: 5px solid transparent;
        border-bottom: 5px solid transparent;
        right: -6px;
        top: 50%;
        margin-top: -4px;
        border-left-color: #222;
        border-left-style: solid;
        border-left-width: 6px;
    }

    .tebb6baca-f046-4963-9aac-18e66dbd3ae2.place-right {
        margin-left: 10px;
    }
    .tebb6baca-f046-4963-9aac-18e66dbd3ae2.place-right::before {
        border-right: 8px solid transparent;
    }
    .tebb6baca-f046-4963-9aac-18e66dbd3ae2.place-right::after {
        border-top: 5px solid transparent;
        border-bottom: 5px solid transparent;
        left: -6px;
        top: 50%;
        margin-top: -4px;
        border-right-color: #222;
        border-right-style: solid;
        border-right-width: 6px;
    }

PSJ はツールとユーティリティを備えており、Jupiter 用のユーザー作成 PythonAPI スクリプトをサポートしています。

Jupiter の機能を実行すると、マクロやPSJ-コマンドが出力されます。 このマクロや PSJ-コマンドを使用することで同じ Jupiter 操作を再実行できます。

モデルのデータベース情報（モデルの名前、ID、色など）を照会したい場合は、PSJ-ユーティリティを使用します。

PSJ の作成には、カスタマイズシェルとカスタマイズ 
IDEIntegrated Development Environmentを使用することで、コードのデバッグを容易にすることができます。

.最終的なコードは
GUIGraphical User Interfaceなしでも実行できますが、より使いやすくしたい場合は、PSJ-GUIを実装することができます。

マクロ

PSJ-コマンド

PSJ-ユーティリティ

PSJ-GUI

カスタマイズシェル

カスタマイズ IDE

マクロは Jupiter ビルドイン機能と同等ですが、GUIはありません。

例：

CreateCube（[0、0、0]、[10、10、10]、[10、10、10]、 "Cube_1"、7105764、0：0） ： デフォルトの入力値で立方体を作成します

ImprintLineS（[[7.8、0、10]、[2.2、10、10]]、[6:26]、1） ： 2 点間の面に線を引きます。

マクロ機能が正常に実行された直後に生成されます。

マクロは、マクロウィンドウを使用して、記録、実行、保存、および再読み込みできます。
🡆 マクロについてもっと読む

PSJ-コマンドはマクロと同等ですが、マクロよりコンパクトで書きやすく、Python と完全に互換性があります。
この PSJ-コマンドは、Jupiter バージョン 5 から導入されています。

例：

 | マクロ | PSJ-コマンド

 | CreateCube([0, 0, 0], [10, 10, 10], [10, 10, 10], "Cube_1", 7105764, 0:0) | Geometry.Part.Cube()

 | ImprintLineS([[7.8, 0, 10], [2.2, 10, 10]], [6:26], 1) | Geometry.Edge.Line([[7.8, 0, 10], [2.2, 10, 10]], [Face(26)])

PSJ-コマンドには特別な機能があります。

関数の名前は、クラスベースの形式とJupiter のリボン名にちなんで付けられています。

デフォルト値が使用されている場合、パラメータはの記述は不要です。

明示的な定義で読みやすくなっています。

コードをより Pythonicに見せることができる戻り値があります。

エラー処理が組み込まれています。これにより、開発者はバグをすばやく簡単に見つけることができます。

customized IDEまたはVSCode extensionsが完全にサポートされています。
🡆 PSJ-コマンドについてもっと読む

PSJ-ユーティリティは、モデルの情報を照会するために使用されます。 これは、マクロまたは PSJ-コマンドに欠けているものを補完するために使用されます。

例:

JPT.Debugger: PSJ 用のコンソールデバッガー。

JPT.Exec: Jupiter マクロを実行する。

JPT.GetAllParts: すべてのパーツの情報を取得。

フォーマット: JPT.Function_Name(parameters)
🡆 PSJ-ユーティリティについてもっと読む

PSJ-GUIは、ダイアログ開発をサポートする UI ライブラリです。

例:

dlg.add_label(name="Label30",text="Average Size", width=100, layout="Layout29")

dlg.add_textbox(name="Aver_size",layout="Layout29")

他の PythonUI パッケージ（PyQT、Tkinter、PySide など）とは異なり、PSJ-GUI は Jupiter の UI フレームワークに完全に統合されており、カスタマイズ機能を Jupiter の機能と同じルックアンドフィールにできます。

PSJ-GUI は、双方向接続もサポートしています。 （ピッキング、テーブル、タブ/ウィザードなど。）

GUI コマンドビルダー

は PSJ-GUI のインタラクティブなビルダーであり、ドラッグアンドドロップ操作によって Jupiter ダイアログまたはウィザードの作成を支援します。
したがって、Jupiter で UI コンポーネントを作成するために Python プログラミング言語を知る必要はありません。
🡆 PSJ-GUI についてもっと読む

カスタマイズシェルは、PSJ の出力と情報を表示する Jupiter ウィンドウです。

Python API ウィンドウ：Python コマンドと実行結果が表示されます。

コマンドラインインターフェイス（CLI）：ユーザーはここで Python スクリプトを直接実行できます。

コマンド入力はコピー＆ペーストが可能です。
🡆 カスタマイズシェルについてもっと読む

カスタマイズ IDEは、PSJ をより簡単に作成するためのサポート環境です。

ハイライト

オートコンプリート

ツールチップ（ビルドイン関数またはユーザー定義関数）

スクリプトのグループブロック（折りたたみ/展開）
🡆 カスタマイズ IDE についてもっと読む
 

組み込みの Python（バージョン 3.*）コンパイラ

PSJ には、便利な Python ライブラリも含まれています。 pandas、numpy、matplotlib、pptx、scikit-learn など。
