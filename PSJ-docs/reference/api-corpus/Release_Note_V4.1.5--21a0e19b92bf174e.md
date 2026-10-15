# Release Note V4.1.5

Release Note V4.1.5

ハイライト更新

このリリースは、主にパフォーマンスの向上に焦点を当て、いくつかの機能強化とバグ修正が行われています。

🚀 新機能​

🛠 PSJ-Utility​

📝 API​

データベースクエリに関連するAPIコマンドが追加されました：

新しく追加されたコマンドの一覧

JPT.GetProgramVersion() : Jupiterの現在のリリース番号を取得します。

JPT.GetContactType() : Abaqusの接触タイプを取得します。

🐛 バグ修正​

Parasolidファイルをインポートした後（前景モードと背景モード）、組立ツリーに日本語名のパートまたは DItem がある場合、Jupiterは読み取ることができず、part.nameに格納して出力することができません。例：

parts = JPT.GetAllParts()
for part in parts:
    print(part.name)

他のソフトウェアによってPYTHONHOMEとPYTHONPATHが設定されている場合、Jupiterがクラッシュします。
