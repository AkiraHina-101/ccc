# dlg.add_spin()

dlg.add_spin()

説明​

作成ダイアログにスピンを追加します。

構文​

dlg.add_spin(...)

入力​

name​

作成したコンポーネントの名前を指定する String です。

この入力は必須です。

min​

スピン範囲の最小値を指定する Double です。
type が spin.double の場合、値は切り上げられます。

この入力は必須です。

max​

スピン範囲の最大値を指定する Double です。
type が spin.double の場合、値は切り上げられます。

この入力は必須です。

pos​

スピン範囲の初期値（開始位置）を指定する Double です。
type が spin.double の場合、値は切り上げられます。

この入力は必須です。

increment​

スピンの増分を指定する Double です。
type が spin.double の場合、値は切り上げられます。

この入力は必須です。

layout​

作成したレイアウト名を指定する String です。
作成したレイアウトは、GroupBoxコンポーネント、Layoutコンポーネントなどがあります。

この入力は必須です。

type​

スピンのタイプを指定する Enum 型です:

spin.integer: 整数型

spin.double: 浮動小数点型

デフォルト値は spin.integer です。

precision​

入力値のゼロ以降の桁数（精度）を指定する Integer です。
type が spin.integer の場合、この入力は無視されます。

デフォルト値は 1 です。

戻り値​

この関数には出力値はありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_spin(name="Spin2",min=1,max=100,pos=2,increment=2,layout="Window")
    dlg.add_spin(name="Spin3",type=spin.double,min=0.000000,max=50.000000,pos=1.500000,
        increment=1.500000,precision=3,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
