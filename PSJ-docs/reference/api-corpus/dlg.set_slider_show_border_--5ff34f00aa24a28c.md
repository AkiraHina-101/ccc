# dlg.set_slider_show_border()

dlg.set_slider_show_border()

説明​

スライダーバーの境界線を表示します。

構文​

dlg.set_slider_show_border(...)

入力​

name​

スライダーバーの名前を指定する String です。

この入力は必須です。

enabled​

スライダーの境界線の状態を指定する Boolean 型です：

True: 作成中のスライダーバーの外部境界線を表示します。

False: 作成中のスライダーバーの外部境界線を非表示にします。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.horizontal,layout="Window")
    dlg.add_slider(name="Slider3",width=100,height=30,min=0,max=100,pos=0,layout="Layout1")
    dlg.set_slider_show_border(name="Slider3",enabled=True)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
