# msgbox.set_icon()

msgbox.set_icon()

Description​

An instance of a PSJMessageBox class, specifying the type of icon used in the message box.

Syntax​

msgbox.set_icon(...)

Input​

icon_type​

An Enum specifying the msgbox_icon to be used in the message box.

This is a required input.

path​

A String specifying the full path of the icon file used to set the icon for the message box.

This argument is only used if the icon_type is set by "user" icon type.

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
