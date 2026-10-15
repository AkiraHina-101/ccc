# PSJ-GUI

PSJ-GUI

はじめに​

PSJ-GUIは、コマンドダイアログを簡単に、時間をかけずに作成できるようにする UI ライブラリです。

例:

dlg.add_label(name="Label30",text="平均サイズ", width=100, layout="Layout29") : テキストラベルを追加します。

dlg.add_textbox(name="Aver_size",layout="Layout29") : テキスト編集ボックスを追加します。

他の PythonUI パッケージ（PyQT、 Tkinter、 PySideなど）とは異なり、PSJ-GUI はJupiter の UI フレームワークに完全に統合されています。

作成した機能の GUI を Jupiter の組み込みダイアログ機能と同じルックアンドフィールにすることができます。

PSJ-GUI は、双方向接続もサポートしています。（モデルピッキング、テーブル、タブ／ウィザードなど。）

続きを読む

利用可能な PSJ-GUI のリストは、スクリプト API
または、チュートリアルをご覧ください。

GUI コマンドビルダー​

GUI コマンドビルダーは PSJ-GUI のインタラクティブなビルダーであり、ドラッグアンドドロップ操作によって Jupiter ダイアログまたはウィザードを作成することができます。

したがって、 Jupiter で UI コンポーネントを作成するための Python プログラミング言語の知識は必要はありません。

続きを読む

詳細については、GUIコマンドビルダーに関するドキュメントをご確認ください。
