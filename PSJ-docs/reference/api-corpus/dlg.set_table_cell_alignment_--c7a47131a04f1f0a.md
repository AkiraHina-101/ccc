# dlg.set_table_cell_alignment()

dlg.set_table_cell_alignment()

説明​

セルのテキスト配置を設定します。

構文​

dlg.set_table_cell_alignment(...)

入力​

name​

テーブルの名前を指定する String です。

これは必須の入力です。

row​

行の順序を指定する Integer です（0から開始）。

これは必須の入力です。

col​

列の順序を指定する Integer です（0から開始）。

これは必須の入力です。

alignment​

セル内のコンテンツの配置位置を指定する String です。

"Left": コンテンツを左寄せ

"Center": コンテンツを中央寄せ

"Right": コンテンツを右寄せ

これは必須の入力です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_click_set_alignment(dlg):
    dlg.set_table_cell_alignment(name="Table1",row=0,col=0,
        alignment="Left")
    dlg.set_table_cell_alignment(name="Table1",row=1,col=0,
        alignment="Center")
    dlg.set_table_cell_alignment(name="Table1",row=2,col=0,
        alignment="Right")

def main():
    dlg=JDGCreator(title="ダイアログ",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,
        columns=["Heading1","Heading2"],
        layout="Window",width=360,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonSetAlignment",width=70,height=30,
        text="配置を設定",layout="footer")
    dlg.add_button(name="Ok",text="OK",layout="footer")
    dlg.add_button(name="ButtonCancel",text="キャンセル",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_table_column_width(name="Table1",col=0,width=200)
    dlg.set_cell_value(name="Table1",row=0,col=0,
        value="左寄せ配置")
    dlg.set_cell_value(name="Table1",row=1,col=0,
        value="中央寄せ配置")
    dlg.set_cell_value(name="Table1",row=2,col=0,
        value="右寄せ配置")
    dlg.on_command(name="ButtonSetAlignment",callfunc=on_click_set_alignment)

if __name__=='__main__':
    main()
