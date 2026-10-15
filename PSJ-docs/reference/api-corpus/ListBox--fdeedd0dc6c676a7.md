# ListBox

ListBox

Create a list box.

Preview dialog:

Parameters​

Name​

Enter name of the list box.

Enable​

Specify whether to enable it or not.

Check On : Available

Check Off : Unavailable (grayed out)

Allow Multiple Selection​

Multiple options (items in the list box component) can be selected.

Check On : Allowed

Check Off : Not allowed

Size​

Width : Specify the minimum width of the list box. (in pixels)

Height: Specify the minimum height of the list box. (in pixels)

Source File​

Import options from a text file.

Structure of the Source File:

Option1
Option2
Option3
Option4
Option5

↓ Import result:

Option Count​

Specify the number of selection options.

Options​

Enter name of the option in the list box.

Visible​

Specify whether to show/hide the created ListBox.

Check On : Show

Check Off : Hide

API associated with​

dlg.add_listbox : Add a ListBox to the creating dialog.

dlg.add_listbox_option : Add an option to the ListBox component.

dlg.clear_listbox : Clear all options of a specified ListBox.

dlg.get_listbox_sel : Get the index of the selecting ListBox option.

dlg.get_listbox_sels : Get the indexes of the selecting ListBox options.

dlg.get_listbox_option : Get the string value of the being selected ListBox option.

dlg.get_len_listbox : Get the size (number of items) of the ListBox.

dlg.set_listbox_sel : Set current selection to the ListBox component.

dlg.insert_listbox_option : Insert an option to a specific position of the ListBox component.

dlg.insert_listbox_options : Insert multiple options to a specific position of the ListBox component.

dlg.remove_listbox_option : Remove a specified option in a ListBox.

dlg.on_listbox_sel : Run a created function after a ListBox item is selected.
