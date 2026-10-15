# dlg.set_slider_show_tics()

dlg.set_slider_show_tics()

説明​

SliderBarの目盛りを表示します。

構文​

dlg.set_slider_show_tics(...)

入力​

name​

SliderBarの名前を指定する String です。

この入力は必須です。

enabled​

スライダーの目盛りの状態を指定する Boolean 型です：

True: すべての目盛りを表示します。

False: すべての目盛りを非表示にします。

この入力は必須です。

戻り値​

この関数には出力値はありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_slider(name="Slider3",width=100,height=30,min=0,max=100,pos=0,layout="Layout1")
    dlg.set_slider_show_tics(name="Slider3",enabled=False)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
