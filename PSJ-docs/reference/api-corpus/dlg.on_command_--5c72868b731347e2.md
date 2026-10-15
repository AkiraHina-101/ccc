# dlg.on_command()

dlg.on_command()

説明​

コンポーネントに作成された関数をバインドします。

構文​

dlg.on_command(...)

入力​

name​

作成されたdef関数をバインドするコンポーネントの名前を指定する String 。

この入力は必須です。

callfunc​

バインドしたい関数の名前。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def onApplyButtonClicked(dlg):
    Geometry.Part.Cube()
    print("--- Cube created! ---")

def main():
    dlg=JDGCreator(title="TechnoStar",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",margin=[80,0,50,0],orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label2",text="Click on Apply button!",layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonApply",text="Apply",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="ButtonApply",callfunc=onApplyButtonClicked)

if __name__=='__main__':
    main()
