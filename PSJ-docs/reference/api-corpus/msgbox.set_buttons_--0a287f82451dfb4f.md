# msgbox.set_buttons()

msgbox.set_buttons()

Description​

An instance of a PSJMessageBox class, specifying a set of available buttons supported in the message box.

Syntax​

msgbox.set_buttons(...)

Input​

button_type​

An Enum specifying a set of msgbox_buttons supported in the message box.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    msgbox=PSJMessageBox()
    msgbox.set_caption(text="PSJ Message Box")
    msgbox.set_header(text="")
    msgbox.set_icon(icon_type=msgbox_icon.error)
    msgbox.set_message(text="This is an error message box")
    msgbox.set_buttons(button_type=msgbox_buttons.yes_no_cancel)
    print("clicked:"+msgbox.show())

if __name__=='__main__':
    main()
