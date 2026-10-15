# dlg.add_richeditbox()

dlg.add_richeditbox()

Description​

Add a rich edit box to the dialog.

Syntax​

dlg.add_richeditbox(...)

Inputs​

name​

A String specifying the name of the created component.

This is a required input.

layout​

A String specifying the created Layout name.
The created Layout can be a GroupBox component, Layout component, etc.

This is a required input.

text​

A String specifying text displayed by default.

The default value is "".

width​

An Integer specifying the width of the rich edit box.

The default value is 60.

height​

An Integer specifying the height of the rich edit box.

The default value is 22.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_richeditbox(name="RichEditBox17",text="RichEditBox content",
        width=200,height=200,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

if __name__=='__main__':
    main()
