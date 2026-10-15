# dlg.on_spin_changed()

dlg.on_spin_changed()

説明​

スピンの値が変更された後に作成された関数を実行します。

構文​

dlg.on_spin_changed(...)

入力​

name​

作成された def 関数にバインドするために使用する Spin コンポーネントの名前を指定する String 。

これは必須の入力です。

callfunc​

バインドしたい関数の名前。

これは必須の入力です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def on_spin_changed(dlg,old_value,new_value):
    total_rows=dlg.get_total_row(name="Table6")
    if new_value is None:
        new_rows=int(dlg.get_item_text(name="Spin4"))
    elif new_value >= 0:
        new_rows=new_value
    if new_rows >= total_rows:
        dlg.insert_table_rows(name="Table6",row_num=int(new_rows-total_rows))
    else:
        if new_rows >= 1:
            for idx in range (new_rows, total_rows):
                dlg.delete_table_row(name="Table6",position=new_rows)
    if new_value >= 1:
        print("現在の行数は："+ str(new_value))
    else:
        print("現在の行数は："+ str(new_value+1))

def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_layout(name="Layout2",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="行数",width=80,
        text_halign="left",text_valign="top",layout="Layout2")
    dlg.add_spin(name="Spin4",min=1,max=10,pos=5,increment=1,layout="Layout2")
    dlg.add_layout(name="Layout5",orientation=orientation.vertical,layout="Window")
    dlg.add_table(name="Table6",width=350,height=300,columns=["見出し1","見出し2","見出し3"],
        rows=5,layout="Layout5")
    dlg.generate_window()
    dlg.on_spin_changed(name="Spin4",callfunc=on_spin_changed)

if __name__=='__main__':
    main()
