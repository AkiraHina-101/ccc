# dlg.enable_drag_table_row()

dlg.enable_drag_table_row()

説明​

テーブルの行を上下にドラッグできるようにします。

構文​

dlg.enable_drag_table_row(...)

入力​

name​

テーブルコンポーネントの名前を指定する String です。

この入力は必須です。

enable​

テーブル行をドラッグできる状態（上下）を指定する Boolean です。

True: テーブル行のドラッグを有効にします

False: テーブル行のドラッグを無効にします

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=5,columns=["String","Integer","Double"],
                layout="Window",width=360,height=260)
    dlg.set_table_column_data_type(name="Table1",col=0,data_type="String")
    dlg.set_table_column_data_type(name="Table1",col=1,data_type="Integer")
    dlg.set_table_column_data_type(name="Table1",col=2,data_type="Double",precision=5)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")   
    dlg.generate_window()
    dlg.set_cell_value(name="Table1",row=0,col=0,value="Option1")
    dlg.set_cell_value(name="Table1",row=1,col=0,value=["Option2","Option3"])
    dlg.set_cell_value(name="Table1",row=0,col=1,value="1")
    dlg.set_cell_value(name="Table1",row=1,col=1,value=[2,3])
    dlg.set_cell_value(name="Table1",row=0,col=2,value="1.5")
    dlg.set_cell_value(name="Table1",row=1,col=2,value=[2.5,3.5])
    dlg.enable_drag_table_row(name="Table1",enable=True)
if __name__=='__main__':
    main()
