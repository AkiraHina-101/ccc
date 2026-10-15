# Show Tooltip

Show Tooltip

🎯 Introduction​

In this tutorial, you'll learn how to show tooltip of a component to display information to user:

Create a dialog.

Add tooltip with information.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

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
    dlg.show_tooltip(name="Label1",tip="Tooltip for Label1")
    dlg.show_tooltip(name="TextBox2",tip="Tooltip for TextBox2")
    dlg.show_tooltip(name="RichEditBox3",tip="Tooltip for RichEditBox3")
    dlg.show_tooltip(name="ComboBox4",tip="Tooltip for ComboBox4")
    dlg.show_tooltip(name="CheckBox5",tip="Tooltip for CheckBox5")
    dlg.show_tooltip(name="RadioButton6",tip="Tooltip for RadioButton6")
    dlg.show_tooltip(name="Button7",tip="Tooltip for Button7")
    dlg.show_tooltip(name="Spin8",tip="Tooltip for Spin8")
    dlg.show_tooltip(name="Slider9",tip="Tooltip for Slider9")

if __name__=='__main__':
    main()
