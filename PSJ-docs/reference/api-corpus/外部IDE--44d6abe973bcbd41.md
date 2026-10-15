# 外部IDE

外部IDE

PSJを開発するために、ユーザーはJupiterの組み込みIDE、他のテキストエディタ、またはMicrosoftのVisual Studio Code（略してVSCode）を使用できます。

PSJ用Visual Studio Code​

紹介​

VSCodeはオープンソースのテキストエディタであり、さまざまな拡張機能をインストールすることでPython開発をより速く、より簡単にすることができます。
現在のJupiter組み込みIDEのすべての機能に加えて、VSCodeは次の機能も提供します:

デバッガ

AIコパイロット

オンライン/ローカルのスクリプティングAPIドキュメントへのリンク

リンティング（コード修正のヒント）

注意

これはベータ版ですので、実際のアプリケーションには使用しないでください。
フィードバックや質問がある場合は、こちらからお問い合わせください。

インストール手順​

コードハイライト、サジェスト、スニペット用のVSCode拡張機能をこのリンクからインストールします。

以下のコマンドを使用してJupiter-Connection/デバッガ用のPythonライブラリをインストールします（Jupiterが異なる場所にインストールされている場合は、下記のダブルクォート内のリンクを変更してください）：

python -m pip install "C:\Program Files\TechnoStar\Jupiter_5.1\tools\jupiterutils-3.9.tar.gz"

PSJスクリプトを書く前に、インストールされたモジュールをfrom jupiterutils import *を使用してインポートすることをVSCodeで忘れないでください。
