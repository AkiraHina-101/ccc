# msgbox.add_button()

msgbox.add_button()

Description​

An instance of a PSJMessageBox class, adding a button whose button name can be defined by user.

Syntax​

msgbox.add_button(...)

Input​

pos​

An Enum specifying the msgbox_position of the button to be added.

This is a required input.

text​

A String specifying the name of the added button.

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
    msgbox.add_button(pos=msgbox_position.first, text="First")
    msgbox.add_button(pos=msgbox_position.second, text="Second")
    msgbox.add_button(pos=msgbox_position.third, text="Third")
    print("clicked:"+msgbox.show())

if __name__=='__main__':
    main()
