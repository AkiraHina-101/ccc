# dlg.add_textbox()

dlg.add_textbox()

説明​

作成ダイアログにテキストボックスを追加します。

構文​

dlg.add_textbox(...)

入力​

name​

作成されたコンポーネントの名前を指定する String 。

この入力は必須です。

layout​

作成したレイアウト名を指定する String 。
作成されたレイアウトは、GroupBox コンポーネント、Layout コンポーネントなどがあります。

この入力は必須です。

text​

表示されるテキストを指定する String 。

デフォルト値は "" です。

readonly​

テキストボックスの読み取り専用状態を指定する Boolean 型。

True: テキストは読み取り専用状態です。編集できません。

False: テキストは手動で編集可能です。

デフォルト値は False です。

text_color​

テキストの色を指定する Integer 。

デフォルト値は 0 です。

bk_color​

背景色を指定する Integer 。

デフォルト値は 16777215 です。

width​

テキストボックスの幅を指定する Integer 。

デフォルト値は 0 です。

height​

テキストボックスの高さを指定する Integer 。

デフォルト値は 0 です。

text_align​

テキストの表示位置を指定する String 。

"Left": テキストを左に揃えます。

"Center": テキストを中央に揃えます。

"Right": テキストを右に揃えます。

デフォルト値は "Left" です。

type​

テキストボックスのデータ型を指定する String 。

"string": 入力値は String で入力します。

"double": 入力値は Double 型で入力します。

"integer": 入力値は Integer で入力します。

デフォルト値は "string" です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",include_apply=False)
    dlg.add_layout(name="Layout2",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label3",text="String Type",width=100,text_halign="left",text_valign="top",layout="Layout2")
    dlg.add_textbox(name="TextBox4",width=150,height=25,readonly=True,
        text="TechnoStar",type="string",text_align="left",layout="Layout2")
    dlg.add_layout(name="Layout6",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label7",text="String Type",width=100,text_halign="left",text_valign="top",layout="Layout6")
    dlg.add_textbox(name="TextBox8",width=150,height=25,readonly=False,
        text="12345",type="string",bk_color=16711168,text_color=255,text_align="left",layout="Layout6")
    dlg.add_layout(name="Layout9",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label10",text="Integer Type",width=100,text_halign="left",text_valign="top",layout="Layout9")
    dlg.add_textbox(name="TextBox11",width=150,height=25,readonly=False,
        text="TechnoStar",type="integer",text_align="center",layout="Layout9")
    dlg.add_layout(name="Layout12",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label13",text="Integer Type",width=100,text_halign="left",text_valign="top",layout="Layout12")
    dlg.add_textbox(name="TextBox14",width=150,height=25,readonly=True,
        text="12345",bk_color=65535,text_color=255,type="integer",text_align="center",layout="Layout12")
    font_TextBox14=PSJFont()
    font_TextBox14.size=12
    font_TextBox14.bold=True
    font_TextBox14.italic=False
    font_TextBox14.underline=True
    font_TextBox14.strikeout=False
    dlg.set_item_font(name="TextBox14",font=font_TextBox14)
    dlg.add_layout(name="Layout15",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label16",text="Double Type",width=100,text_halign="left",text_valign="top",layout="Layout15")
    dlg.add_textbox(name="TextBox17",width=150,height=25,readonly=False,
        text="TechnoStar",type="double",text_align="right",layout="Layout15")
    dlg.add_layout(name="Layout18",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="Label19",text="Double Type",width=100,text_halign="left",text_valign="top",layout="Layout18")
    dlg.add_textbox(name="TextBox20",width=150,height=25,readonly=True,
        text="12345.123",type="double",text_align="right",layout="Layout18")
    font_TextBox20=PSJFont()
    font_TextBox20.size=12
    font_TextBox20.bold=False
    font_TextBox20.italic=True
    font_TextBox20.underline=True
    font_TextBox20.strikeout=False
    dlg.set_item_font(name="TextBox20",font=font_TextBox20)
    dlg.generate_window()

if __name__=='__main__':
    main()
