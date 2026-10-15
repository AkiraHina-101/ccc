# 高度なサンプル 2 - セルの整列と入力値のデータ型のチェック

高度なサンプル 2 - セルの整列と入力値のデータ型のチェック

🎯 はじめに​

このチュートリアルでは、テーブルでセルの整列を設定し、入力値が文字列/整数/実数であるかをチェックし、イベントをトリガーする方法を学びます：

「String」列と「Double」列のセルが空かどうかをチェックし、空の場合はセルを黄色で塗りつぶします。

「Integer」列のセルが負の値かどうかをチェックし、負の数値の場合はテキストを赤色に設定します。

📖 チュートリアル​

# Python APIウィンドウのエンコーディング
# coding: cp932

from pyjdg import *

def on_button_check(dlg):
    '''
    String列とDouble列のすべてのセルをループし、空のセルチェックとInteger列の負の値チェックを実行します：
    1. セルが空かどうかをチェックし、セルが空の場合は黄色で塗り、入力を促します。
        引数:
            なし
        戻り値:
            空の黄色いセル
    2. Integer列のセルのデータ検証をチェックし、値が負の場合はセルのフォントの色を赤に設定します。
        引数:
            なし
        戻り値:
            値が負の場合は赤いフォントのセル
    '''
    for row in range(5):
        value_cell = dlg.get_cell_value(name="Table1", row=row, col=0)
        if not value_cell:
            dlg.set_table_cell_fill_color(name="Table1", cell=TableCellID(row=row, col=0), color=65535)
        else:
            dlg.set_table_cell_fill_color(name="Table1", cell=TableCellID(row=row, col=0), color=16777215)
    for row in range(5):
        value_cell = dlg.get_cell_value(name="Table1", row=row, col=1)
        if int(float(value_cell)) == 0:
            dlg.set_table_cell_fill_color(name="Table1", cell=TableCellID(row=row, col=1), color=65535)
        else:
            dlg.set_table_cell_fill_color(name="Table1", cell=TableCellID(row=row, col=1), color=16777215)
    for row in range(5):
        value_cell = dlg.get_cell_value(name="Table1", row=row, col=2)
        if int(value_cell) < 0:
            dlg.set_table_cell_text_color(name="Table1", cell=TableCellID(row=row, col=2), color=255)
        else:
            dlg.set_table_cell_text_color(name="Table1", cell=TableCellID(row=row, col=2), color=0)

def main():
    dlg=JDGCreator(title="ダイアログ", resizable=True, validation=True)
    dlg.add_table(name="Table1", rows=5, columns=["String", "Double", "Integer"], layout="Window", width=350, height=150)
    dlg.set_table_column_data_type(name="Table1", col=0, data_type="String")
    dlg.set_table_column_data_type(name="Table1", col=1, data_type="Double", precision=3)
    dlg.set_table_column_data_type(name="Table1", col=2, data_type="Integer")
    dlg.add_hlayout(name="footer", layout="Window")
    dlg.add_space(orientation="horizontal", layout="footer")
    dlg.add_button(name="ButtonCheck", text="チェック", width=80, height=30, layout="footer")
    dlg.add_button(name="ButtonOk", text="OK", layout="footer")
    dlg.add_button(name="ButtonCancel", text="キャンセル", layout="footer")
    dlg.add_space(orientation="horizontal", layout="footer")
    dlg.generate_window()
    for row in range(5):
        dlg.set_table_cell_alignment(name="Table1", row=row, col=0, alignment="Left")
        dlg.set_table_cell_alignment(name="Table1", row=row, col=1, alignment="Right")
        dlg.set_table_cell_alignment(name="Table1", row=row, col=2, alignment="Right")
    for i in range(5):
        if i != 3:
            dlg.set_cell_value(name="Table1", row=i, col=0, value="This is String {}".format(i))
    for i in range(5):
        if i != 3:
            dlg.set_cell_value(name="Table1", row=i, col=1, value=[1.123 + i])
    for i in range(5):
        if i == 1:
            dlg.set_cell_value(name="Table1", row=i, col=2, value=[-5])
        else:
            dlg.set_cell_value(name="Table1", row=i, col=2, value=[i + 3])
    dlg.on_button_clicked(name="ButtonCheck", callfunc=on_button_check)

if __name__=='__main__':
    main()
