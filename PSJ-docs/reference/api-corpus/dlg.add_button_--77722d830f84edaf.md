# dlg.add_button()

dlg.add_button()

説明​

作成ダイアログにボタンを追加します。ボタンは画像ボタンにすることができます。

構文​

dlg.add_button(...)

入力​

name​

作成されたコンポーネントの名前を指定する String です。

この入力は必須です。

layout​

作成されたレイアウトの名前を指定する String です。
作成されたレイアウトはGroupBoxコンポーネント、Layoutコンポーネントなどになります。

この入力は必須です。

text​

ボタンに表示されるテキストを指定する String です。

デフォルト値は "" です。

width​

ボタンの幅を指定する Integer です。

デフォルト値は 0 です。

height​

ボタンの高さを指定する Integer です。

デフォルト値は 0 です。

text_color​

テキストの色を指定する Integer です。

デフォルト値は 0 です。

bk_color​

背景色を指定する Integer です。

デフォルト値は 15790320 です。

img​

ボタンに表示される画像のパスを指定する String です。

デフォルト値は "" です。

location​

ボタンに表示される画像の位置を指定する String です。

デフォルト値は "left" です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

TechnoStarImage = JPT.GetProgramPath() + "SampleData/PSJ/PSJ-Utility/Utils/TechnoStar.ico"

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout2",orientation=orientation.horizontal,layout="Window")
    dlg.add_button(name="Button3",text="Button",width=60,height=22,layout="Layout2")
    font_Button3=PSJFont()
    font_Button3.size=10
    font_Button3.bold=True
    font_Button3.italic=False
    font_Button3.underline=False
    font_Button3.strikeout=False
    dlg.set_item_font(name="Button3",font=font_Button3)
    dlg.add_button(name="Button4",text="Button",width=60,height=22,bk_color=65535,
        text_color=255,img=TechnoStarImage,location="left",layout="Layout2")
    font_Button4=PSJFont()
    font_Button4.size=10
    font_Button4.bold=False
    font_Button4.italic=True
    font_Button4.underline=False
    font_Button4.strikeout=False
    dlg.set_item_font(name="Button4",font=font_Button4)
    dlg.add_button(name="Button5",text="Button",width=60,height=22,bk_color=65535,
        text_color=255,img=TechnoStarImage,location="right",layout="Layout2")
    font_Button5=PSJFont()
    font_Button5.size=10
    font_Button5.bold=False
    font_Button5.italic=False
    font_Button5.underline=True
    font_Button5.strikeout=False
    dlg.set_item_font(name="Button5",font=font_Button5)
    dlg.add_button(name="Button6",text="Button",width=60,height=22,bk_color=65535,
        text_color=255,img=TechnoStarImage,location="top",layout="Layout2")
    font_Button6=PSJFont()
    font_Button6.size=10
    font_Button6.bold=True
    font_Button6.italic=True
    font_Button6.underline=True
    font_Button6.strikeout=False
    dlg.set_item_font(name="Button6",font=font_Button6)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="OK",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
