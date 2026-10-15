# ComboBox

ComboBox

Create a combo box.

Preview dialog:

Parameters​

Name​

Enter name of the combo box.

Enable​

Specify whether to enable it or not.

Check On : Available

Check Off : Unavailable (grayed out)

Width​

specifying the minimum width of the combo box. (in pixels)

Height​

specifying the minimum height of the combo box.(in pixels)

Source File​

Import options from a text file.

Structure of the Source File:

Option1
Option2
Option3
Option4
Option5

↓ Import result:

Options Count​

Specify the number of selection options.

Options​

Enter name of the selection in the combo box.

API associated with​

dlg.add_combobox : Add a ComboBox component to the dialog.

dlg.add_combobox_option : Add an option to the ComboBox component.

dlg.get_combobox_sel : Get the index of the being selected ComboBox option.

dlg.get_combobox_option : Get the string value of the being selected ComboBox option.

dlg.get_len_combobox : Get the size (number of items) of the ComboBox.

dlg.set_combobox_sel : Set current selection to the ComboBox component.

dlg.on_combobox_sel : Run a created function after a ComboBox item is selected.

dlg.insert_combobox_option : Insert an option to a specific position of the ComboBox component.

dlg.insert_combobox_options : Insert multiple options to a specific position of the ComboBox component.
