# dlg.set_item_text()

dlg.set_item_text()

Description​

Set the text which will be shown inside the component.

Syntax​

dlg.set_item_text(...)

Inputs​

name​

A String specifying the name of the component.

This is a required input.

text​

A String specifying the content displayed.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *
def onSetButtonClicked(dlg):
    dlg.set_item_text(name="TextBox1",text="This is sample text")

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_textbox(name="TextBox1",layout="Window")
    dlg.add_button(name="Button2",text="Set text",width=60,height=22,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="Button2",callfunc=onSetButtonClicked)

if __name__=='__main__':
    main()
