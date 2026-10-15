# dlg.on_button_clicked()

dlg.on_button_clicked()

Description​

Bind a created function to a Button/RadioButton/CheckBox.

Syntax​

dlg.on_button_clicked(...)

Inputs​

name​

A String specifying the name of the Button/RadioButton/CheckBox using for binding a created def function.

This is a required input.

callfunc​

The name of function wants to be bound to.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def on_button_clicked(dlg):
    JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 5357649, 0:0)')
    print("--- Cube created! ---")

def on_checkbox_clicked(dlg):
    print("You clicked on Checkbox!")

def on_radio_buton_clicked(dlg):
    print("You clicked on Radio Button!")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_groupbox(name="GroupBox2",text="GroupBox",layout="Window")
    dlg.add_layout(name="Layout4",orientation=orientation.vertical,layout="GroupBox2")
    dlg.add_label(name="Label8",text="Click on Button!",text_halign="left",text_valign="top",layout="Layout4")
    dlg.add_button(name="Button5",text="Button",width=60,height=22,layout="Layout4")
    dlg.add_label(name="Label9",text="Click on Checkbox!",text_halign="left",text_valign="top",layout="Layout4")
    dlg.add_checkbox(name="CheckBox6",text="CheckBox",layout="Layout4")
    dlg.add_label(name="Label10",text="Click on Radio Button!",text_halign="left",text_valign="top",layout="Layout4")
    dlg.add_radiobutton(name="RadioButton7",text="RadioButton",layout="Layout4")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="Button5",callfunc=on_button_clicked)
    dlg.on_button_clicked(name="CheckBox6",callfunc=on_checkbox_clicked)
    dlg.on_button_clicked(name="RadioButton7",callfunc=on_radio_buton_clicked)

if __name__=='__main__':
    main()
