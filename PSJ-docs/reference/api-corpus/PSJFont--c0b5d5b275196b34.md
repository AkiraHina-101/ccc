# PSJFont

PSJFont

説明​

PSJFontクラスのインスタンスは、フォントサイズやフォントタイプ（太字、イタリック）、エフェクト（下線、取り消し線）など、論理フォントの属性を表します。

入力​

PSJFontオブジェクトを作成するには、PSJFont() で変数を定義します。

プロパティ​

 | 属性 | 説明

 | size | テキストのサイズを変更します

 | bold | テキストを太字にします

 | italic | テキストをイタリックにします

 | underline | テキストに下線を引きます

 | strikeout | テキストに取り消し線を引きます

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_textbox(name="TextBox2",layout="Window", width=350, 
        height=35, text_color=255)
    font_TextBox2=PSJFont()
    font_TextBox2.size=18
    font_TextBox2.bold=True
    font_TextBox2.italic=True
    font_TextBox2.underline=True
    font_TextBox2.strikeout=False
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.set_item_font(name="TextBox2",font=font_TextBox2)
    dlg.set_item_text(name="TextBox2", text="This is a sample text")

if __name__=='__main__':
    main()
