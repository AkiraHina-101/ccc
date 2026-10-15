# PSJMessageBox

PSJMessageBox

Description​

An instance of a PSJMessageBox class, specifying the methods of a message box.

Input​

To create a PSJMessageBox object, defines a variable with PSJMessageBox()

Methods​

 | Method | Description

 | set_caption() | Set caption of the message box

 | set_header() | Set header of the message box

 | set_icon() | Set the type of icon used in the message box

 | set_message() | Set the message content of the message box

 | enable_checkbox() | Set a checkbox in the message box

 | set_buttons() | Set a set of available buttons supported in the message box

 | add_button() | Set a button whose button name can be defined by user

 | show() | Show message box

Sample Code​

from pyjdg import *

def main():
    msgbox=PSJMessageBox()
    msgbox.set_caption(text="PSJ Message Box")
    msgbox.set_header(text="Error")
    msgbox.set_icon(icon_type=msgbox_icon.error)
    msgbox.set_message(text="This is an error message box")
    msgbox.enable_checkbox(text="Do not show again", checked=True)
    msgbox.set_buttons(button_type=msgbox_buttons.yes_no_cancel)
    print("clicked:"+msgbox.show())  

if __name__=='__main__':
    main()
