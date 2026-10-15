# dlg.show_tooltip()

dlg.show_tooltip()

説明​

ユーザーがマウスを UI コンポーネントに重ねると、ツールチップを表示します。

構文​

dlg.show_tooltip(...)

入力​

name​

UI コンポーネントの名前を指定する String です。

この入力は必須です。

tip​

マウスを重ねると表示されるテキストを指定する String です。

この入力は必須です。

戻り値​

この関数は出力値を持ちません。

サンプルコード​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_label(name="Label1",text="Label",layout="Window")
    dlg.add_textbox(name="TextBox2",layout="Window")
    dlg.add_richeditbox(name="RichEditBox3",text="RichEditBox",
        width=200,height=200,layout="Window")
    dlg.add_combobox(name="ComboBox4",layout="Window")
    dlg.add_checkbox(name="CheckBox5",text="CheckBox",layout="Window")
    dlg.add_radiobutton(name="RadioButton6",text="RadioButton",
        layout="Window")
    dlg.add_button(name="Button7",text="Button",width=60,height=22,
        layout="Window")
    dlg.add_spin(name="Spin8",layout="Window")
    dlg.add_slider(name="Slider9",width=100,height=30,min=0,max=100,pos=0,
        layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.show_tooltip(name="Label1",tip="ラベル1用のツールチップ")
    dlg.show_tooltip(name="TextBox2",tip="TextBox2用のツールチップ")
    dlg.show_tooltip(name="RichEditBox3",tip="RichEditBox3用のツールチップ")
    dlg.show_tooltip(name="ComboBox4",tip="ComboBox4用のツールチップ")
    dlg.show_tooltip(name="CheckBox5",tip="CheckBox5用のツールチップ")
    dlg.show_tooltip(name="RadioButton6",tip="RadioButton6用のツールチップ")
    dlg.show_tooltip(name="Button7",tip="Button7用のツールチップ")
    dlg.show_tooltip(name="Spin8",tip="Spin8用のツールチップ")
    dlg.show_tooltip(name="Slider9",tip="Slider9用のツールチップ")

if __name__=='__main__':
    main()
