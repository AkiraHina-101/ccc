# msgbox.set_message()

msgbox.set_message()

Description​

An instance of a PSJMessageBox class, setting the message content of the message box.

Syntax​

msgbox.set_message(...)

Input​

text​

A String specifying the message content of the message box.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def main():
    msgbox=PSJMessageBox()
    msgbox.set_caption(text="PSJ Message Box")
    msgbox.set_header(text="")
    msgbox.set_icon(icon_type=msgbox_icon.exclamation)
    msgbox.set_message(text="This is a warning message box")
    msgbox.set_buttons(button_type=msgbox_buttons.yes_no_cancel)
    print("clicked:"+msgbox.show())

if __name__=='__main__':
    main()
