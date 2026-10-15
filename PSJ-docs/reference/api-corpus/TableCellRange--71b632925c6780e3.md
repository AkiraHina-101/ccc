# TableCellRange

TableCellRange

説明​

TableCellRangeクラスのインスタンスは、テーブル内のターゲット範囲（複数のセル）の属性を表します。

入力​

TableCellRangeオブジェクトを作成するには、TableCellRange(...)で変数を定義します。

left​

範囲の左側の位置を指定する Integer です（0から開始）。

デフォルト値は-1です。

top​

範囲の上側の位置を指定する Integer です（0から開始）。

デフォルト値は-1です。

right​

範囲の右側の位置を指定する Integer です（0から開始）。

デフォルト値は-1です。

bottom​

範囲の下側の位置を指定する Integer です（0から開始）。

デフォルト値は-1です。

属性​

TableCellRangeの属性を取得します。

left​

指定された範囲の左側の位置を指定する Integer です。

デフォルト値は-1です。

top​

指定された範囲の上側の位置を指定する Integer です。

デフォルト値は-1です。

right​

指定された範囲の右側の位置を指定する Integer です。

デフォルト値は-1です。

bottom​

指定された範囲の下側の位置を指定する Integer です。

デフォルト値は-1です。

備考​

TableCellRangeの_left_、top、right、_bottom_のインデックス番号は、オブジェクトを作成する際に既存のテーブルの範囲を超えることはできません。

サンプルコード​

from pyjdg import *

def on_button_check(dlg):
    # TableCellRangeのインスタンスを作成するには
    range_1 = TableCellRange()
    range_2 = TableCellRange(left=1,top=2,right=3,bottom=4)
    # オブジェクトの属性を確認するには
    print("デフォルトの範囲は位置を持っています：左={}, 上={}, 右={}, 下={}"
        .format(range_1.left, range_1.top, range_1.right, range_1.bottom))
    print("指定された範囲は位置を持っています：左={}, 上={}, 右={}, 下={}"
        .format(range_2.left, range_2.top, range_2.right, range_2.bottom))

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=10,
        columns=["Heading1","Heading2","Heading3","Heading4"],
        layout="Window",width=420,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonCheck",text="Check",width=80,height=30,layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="ButtonCheck",callfunc=on_button_check)

if __name__=='__main__':
    main()
