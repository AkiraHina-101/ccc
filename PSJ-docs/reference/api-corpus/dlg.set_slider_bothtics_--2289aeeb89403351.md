# dlg.set_slider_bothtics()

dlg.set_slider_bothtics()

説明​

スライダーバーの両側/片側に目盛りを表示します。

構文​

dlg.set_slider_bothtics(...)

入力​

name​

スライダーバーの名前を指定する String .

この入力は必須です。

enabled​

目盛りを表示する方法を指定する Boolean 型:

True: スライダーバーの両側に目盛りを表示します.

False: スライダーバーの片側にのみ目盛りを表示します.

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_slider(name="Slider3",width=200,height=100,min=0,max=100,pos=0,layout="Layout1")
    dlg.set_slider_bothtics(name="Slider3",enabled=True)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
