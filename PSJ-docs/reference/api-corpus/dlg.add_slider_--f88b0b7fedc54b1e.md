# dlg.add_slider()

dlg.add_slider()

説明​

作成ダイアログにSliderBarを追加します。

構文​

dlg.add_slider(...)

入力​

name​

作成されるコンポーネントの名前を指定する String です.

この入力は必須です.

layout​

作成されるレイアウトの名前を指定します.
作成されたレイアウトはGroupBoxコンポーネント、Layoutコンポーネントなどです.

この入力は必須です.

width​

SliderBarの幅を指定する Integer です.

デフォルト値は60です.

height​

SliderBarの高さを指定する Integer です.

デフォルト値は22です.

min​

SliderBarの最小値を指定する Integer です.

デフォルト値は0です.

max​

SliderBarの最大値を指定する Integer です.

デフォルト値は100です.

pos​

スクローラーの初期位置を指定する Integer です.

デフォルト値は0です.

vertical​

SliderBarの方向を指定する Boolean 型です:

True: SliderBarを垂直方向に配置します.

False: SliderBarを水平方向に配置します.

デフォルト値は False です.

show_ticks​

スライダーの目盛りの表示を指定する Boolean 型です:

True: 全ての目盛りを表示します.

False: 全ての目盛りを非表示にします.

デフォルト値は True です.

show_border​

スライダーの枠線の表示状態を指定する Boolean 型です:

True: 作成中のSliderBarの外枠線を表示します.

False: 作成中のSliderBarの外枠線を非表示にします.

デフォルト値は False です.

show_bothticks​

目盛りの表示方法を指定する Boolean 型です:

True: SliderBarの両側に目盛りを表示します.

False: SliderBarの片側のみに目盛りを表示します.

デフォルト値は False です.

戻り値​

この関数には出力値がありません.

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="ダイアログ",resizable=True,validation=True)
    dlg.add_slider(name="Slider21",width=100,height=100,min=0,max=100,pos=4,
      vertical=True,show_bothticks=True,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="OK",layout="footer")
    dlg.add_button(name="ButtonCancel",text="キャンセル",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
