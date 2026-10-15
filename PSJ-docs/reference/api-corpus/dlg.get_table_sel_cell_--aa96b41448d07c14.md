# dlg.get_table_sel_cell()

dlg.get_table_sel_cell()

説明​

選択したセルの情報と属性を取得します。

構文​

dlg.get_table_sel_cell(...)

入力​

name​

表の名前を指定する String です。

これは必須の入力です。

戻り値​

セルの方法を指定する TableCellVector オブジェクトまたは List of TableCellID の戻り値です。

サンプルコード​

from pyjdg import *

def on_context_click(dlg,name,menu):
    cellvector=dlg.get_table_sel_cell(name="表1")
    for i in range(cellvector.size()):
        print("{}番のセルに情報があります".format(i+1))
        print("セルの位置（行） = "+str(cellvector[0].row_number))
        print("セルの位置（列） = "+str(cellvector[0].col_number))
        print("---------------------------")

def main():
    dlg=JDGCreator(title="ダイアログ",resizable=True,validation=True)
    dlg.add_table(name="表1",rows=5,
        columns=["見出し1","見出し2"],
        layout="Window",width=260,height=260)
    dlg.add_hlayout(name="フッター",layout="Window")
    dlg.add_space(orientation="horizontal",layout="フッター")
    dlg.add_button(name="ButtonOk",text="OK",layout="フッター")
    dlg.add_button(name="ButtonCancel",text="キャンセル",layout="フッター")
    dlg.add_space(orientation="horizontal",layout="フッター")
    dlg.add_table_right_menu(name="表1",menus=["セル情報を確認"])
    dlg.generate_window()
    dlg.on_table_right_menu(name="表1",callfunc=on_context_click)

if __name__=='__main__':
    main()
