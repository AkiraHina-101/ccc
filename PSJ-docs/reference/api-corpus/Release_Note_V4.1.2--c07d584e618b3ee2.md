# Release Note V4.1.2

Release Note V4.1.2

Highlight updates

This release mainly focuses on PSJ-GUI development and introduce GUI Command Builder.

🚀 New Features​

📐 PSJ-GUI​

📝 API​

API commands related to combobox, listbox, groupbox, slider, layout, etc. are added:

List of newly added commands

dlg.add_space() : Add a placeholder.

dlg.disable_item() : Make a component disabled.

dlg.enable_item() : Make a component enabled.

dlg.get_combobox_sel() : Get combobox current selection index.

dlg.get_item_text() : Get a component window text.

dlg.get_len_combobox() : Get combobox options count number.

dlg.get_len_listbox() : Get listbox options count number.

dlg.get_listbox_sel() : Get listbox current selection index.

dlg.hide_layout() : Hide a layout and all components within this layout.

dlg.insert_combobox_option() : Insert an option to specified position.

dlg.insert_combobox_options() : Insert an option array to specified position.

dlg.insert_listbox_option() : Insert an option to specified position.

dlg.insert_listbox_options() : Insert an option array to specified position.

dlg.isbutton_checked() : Judge a checkbox checked or not.

dlg.set_checkbox_state() : Set a checkbox checked or not.

dlg.set_combobox_sel() : Set a combobox current selection.

dlg.set_image_file() : Give an image file to imagectrl and display it.

dlg.set_item_text() : Set component window text.

dlg.set_listbox_sel() : Set listbox selection.

dlg.set_popup_menu() : Set settings for popup menu in table.

dlg.add_button() : Add a button component to dialog.

dlg.add_checkbox() : Add a checkbox component to dialog.

dlg.add_combobox() : Add a combobox component to dialog.

dlg.generate_window() : Generate a dialog and display it.

dlg.on_command() : Connect a component to a user defined function.

dlg.add_groupbox() : Add a groupbox component to dialog.

dlg.set_groupbox_checked() : Make a groupbox checked at right top corner.

dlg.set_groupbox_collapsed() : Make a groupbox collapsed.

dlg.set_groupbox_orientation() : Set a groupbox layout direction, horizontal or vertical.

dlg.add_imagectrl() : Add a imagectrl component to dialog.

dlg.add_label() : Add label component to dialog.

dlg.add_hlayout() : Add a horizontal layout.

dlg.add_vlayout() : Add a vertical layout.

dlg.add_listbox() : Add a listbox component to dialog.

dlg.add_radiobutton() : Add a radiobutton component to dialog.

dlg.add_richeditbox() : Add a richeditbox component to dialog.

dlg.add_separator() : Add a separator component to dialog.

dlg.add_slider() : Add a slider component to dialog.

dlg.set_slider_bothtics() : sShow or hide ticks at both side of a slider component.

dlg.set_slider_show_border() : Show or hide a slider component border frame.

dlg.set_slider_show_tics() : Show or hide ticks.

dlg.set_slider_vertical() : Set a slider at vertical or horizontal direction.

dlg.add_spin() : Add spin component to dialog.

dlg.add_tabwnd() : Add a tab component to dialog.

dlg.add_tabwnd_page() : Add a tab page to an existed tab component.

dlg.add_textbox() : Add a textbox component to dialog.

📏 GUI Command Builder​

Introduce new GUI Command Builder to create PSJ-GUI easier.
