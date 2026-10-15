# dlg.set_slider_vertical()

dlg.set_slider_vertical()

説明​

スライダーバーを縦または横の方向に表示します。

構文​

dlg.set_slider_vertical(...)

入力​

name​

スライダーバーの名前を指定する String です。

この入力は必須です。

enabled​

スライダーバーの方向を指定する Boolean 型です：

True: スライダーバーは縦に配置されます。

False: スライダーバーは横に配置されます。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_slider(name="Slider3",width=100,height=100,min=0,max=100,pos=0,layout="Layout1")
    dlg.set_slider_vertical(name="Slider3",enabled=True)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
