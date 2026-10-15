# dlg.add_browser()

dlg.add_browser()

説明​

作成ダイアログにファイル/フォルダー ブラウザー コンポーネントを追加します。

構文​

dlg.add_browser(...)

入力​

name​

作成されたコンポーネントの名前を指定する String です。

この入力は必須です。

layout​

作成されたレイアウト名を指定する String です。
作成可能なレイアウトには、GroupBox コンポーネント、Layout コンポーネントなどがあります。

この入力は必須です。

mode​

ブラウザーのタイプを指定する String です：

"file": ユーザーがファイル/ファイルを選択できるようにします。

"folder": ユーザーがフォルダー/フォルダーを選択できるようにします。

デフォルト値は "file" です。

file_filter​

ファイル/ファイルの形式を指定する String です（*.拡張子で指定）。

例: 全ファイル (*.*)、Abaqus (*.inp)

デフォルト値は "" です。

default​

このコンポーネントのテキストボックスに表示されるデフォルト テキストを指定する String です。

デフォルト値は "" です。

multisel​

複数選択の可能性を指定する Boolean 型です：

True: ユーザーが一度に複数のファイル/フォルダーを選択できます。

False: ユーザーが一度に1つのファイル/フォルダーしか選択できません。

デフォルト値は False です。

戻り値​

この関数には出力値がありません。

サンプル コード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="Open",layout="Layout1")
    dlg.add_browser(name="Open File/Folder2",mode="file",file_filter="All Files(*.*)",
      default="C:\\temp",multisel=True,layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
