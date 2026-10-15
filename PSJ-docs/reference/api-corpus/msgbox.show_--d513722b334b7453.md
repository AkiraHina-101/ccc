# msgbox.show()

msgbox.show()

Description​

An instance of a PSJMessageBox class, used to show the message box.

Syntax​

msgbox.show()

Input​

This function does not require any input value.

Return Code​

A String specifying the name of clicked button.

Sample Code​

from pyjdg import *

def main():
    msgbox=PSJMessageBox()
    msgbox.set_caption(text="PSJ Message Box")
    msgbox.set_header(text="")
    msgbox.set_icon(icon_type=msgbox_icon.error)
    msgbox.set_message(text="This is an error message box")
    msgbox.set_buttons(button_type=msgbox_buttons.yes_no_cancel)
    print("clicked:"+ msgbox.show())

if __name__=='__main__':
    main()
