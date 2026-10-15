# Release Note V5.0.2

Release Note V5.0.2

Highlight updates

This release mainly focuses on new PSJ-GUI and PSJ-Utility features. In detail:

Improve usability of PSJ-GUI commands (API) and GUI Command Builder.

Add new PSJ-GUI commands (API), especially PSJ Font and PSJMessageBox.

Add new data types for PSJ-GUI and PSJ-Utility.

Fix arguments name used in PSJ-GUI.

Fix crash problem and some minor bugs of PSJ-GUI, GUI Command Builder.

🚀 New Features​

📦 Data types​

PSJ-Command:  New type of Enum DItemType is added.
List of newly added DItemType

 | INT NOTATION | TYPE OF DITEM

 | 2 | JPT.DItemType.INST

PSJ-GUI: New Enumeration Types msgbox_icon,msgbox_buttons,msgbox_position used for PSJMessageBox, are added.

PSJ-Utility: 

New type of Enum MsgBoxType is added.
List of newly added MsgBoxType

 | ID | MSGBOX TYPE

 | 8 | JPT.MsgBoxType.MB_CRITICAL_OK

New Enum MessageBoxOptionType of API command JPT.DisableMessageBox() are added:
List of newly added MessageBoxOptionType

 | ID | MSGBOX OPTION TYPE

 | 1 | JPT.MsgBoxOptionType.MB_OPTION_OK

 | 2 | JPT.MsgBoxOptionType.MB_OPTION_CANCEL

 | 6 | JPT.MsgBoxOptionType.MB_OPTION_YES

 | 7 | JPT.MsgBoxOptionType.MB_OPTION_NO

🛠 PSJ-Utility​

📝 API​

3 new API commands related to database query is added:
Newly added command

JPT.GetAllByTableTypeID(): Get all the information of all entities by inputting DTableType.

JPT.GetOutputLog(): Get the text existing on the Output window.

JPT.DisableMessageBox(): Disable and set default value of the pop-up message box on screen.

Additionally, some commands are modified as below:
List of commands changed and modified

JPT.DisableAnimation(): The command are modified to capture view of rotation.

📐 PSJ-GUI​

📏 GUI Command Builder​

Width/Heigh properties of Tool Box components (TabWnd, Label, TextBox, RichEditCtrl, ComboBox, ListBox, CheckBox, RadioButton, Button, ImageCtrl, SliderBar, Table, PageCtrl) are putted into a subassembly folder "Size".

H.Alignment/V.Alignment of Label components are putted into a subassembly folder "Alignment".

Add new options to modify Color and Font properties to TextBox.

Add new options to modify Color and Font properties to Button.

Add new options to modify Navigator properties (HighLight Color and Separator) to PageCtrl.

Add new options to modify Color and Font properties to PageItem.

Add name property to Separator to control the name of Separator.

Support shortcut keys of Copy/Cut and Paste when operating on the table

📝 API​

Argument names in some commands are changed for unification purpose (Please update the codes with new argument names).
List of argument names changed

 | Component Group | Old Argument Name | New Argument Name | Example of New Argument Name

 | TABLE | cell_row_id | row | dlg.get_cell_value(row=0,col=0…)

 | TABLE | cell_column_id | col | dlg.get_cell_value(row=0,col=0…)

Additionally, some commands are added and modified as below:
List of newly added commands

PSJMessageBox(): An instance of a PSJMessageBox class, specifying the methods of a message box.

msgbox.set_caption(): An instance of a PSJMessageBox class, setting the caption of the message box.

msgbox.set_header(): An instance of a PSJMessageBox class, setting the header of the message box.

msgbox.set_icon(): An instance of a PSJMessageBox class, specifying the type of icon used in the message box.

msgbox.set_message(): An instance of a PSJMessageBox class, setting the message content of the message box.

msgbox.enable_checkbox(): An instance of a PSJMessageBox class, specifying a checkbox in the message box.

msgbox.set_buttons(): An instance of a PSJMessageBox class, specifying a set of available buttons supported in the message box.

msgbox.add_button(): An instance of a PSJMessageBox class, adding a button whose button name can be defined by user.

msgbox.show(): An instance of a PSJMessageBox class, used to show the message box.

dlg.set_item_font(): Set font properties to the text inside the component.

dlg.get_cell_label(): Get label of a button cell, checkbox cell or combobox cell in the Table.
List of commands changed or modified

dlg.add_pagesctrl(): Add two new arguments show_separatorand sel_color to specify the stage of separator border and specify the highlight color when selecting a PageItem.

dlg.add_pageitem(): Add two new arguments text_color and bk_color to specify the text color and the background color of page item.

dlg.add_textbox(): Add two new arguments text_color and bk_color to specify the text color and the background color of textbox.

dlg.add_button(): Add two new arguments text_color and bk_color to specify the text color and the background color of button.

dlg.insert_table_row(): Correct the usage meaning of argument position. If this argument is specified, the row will be inserted in front of the inputted position (position-1). If it is not specified,the row will be inserted at the end of the table.

dlg.set_cell_value(): The argument names are change cell_row_id/cell_column_id to row/col for unification purpose.

dlg.get_cell_value (): The argument names are change cell_row_id/cell_column_id to row/col for unification purpose.

⚙ Macro​

Macros related to post-processing and template utilisation are added:
List of newly added macros

SetHiddingElementFactor: macro for setting hiding element factor.

CmdPostOptimizationAnimationIncPlay: macro for playing animation.

CmdPostOptimizationAnimationIncPause: macro for pausing animation.

CmdPostOptimizationAnimationIncPrev: macro for playing previous animation.

CmdPostOptimizationAnimationIncNext: macro for playing next animation.

CmdPostOptimizationAnimationIncFirst: macro for playing first animation.

CmdPostOptimizationAnimationIncLast: macro for playing last animation.

CmdPostOptimizationAnimationExportMovie: macro for exporting movie.

ViewSelectMethod: macro for turning on/off mid-node option.

ViewCappingOriginalShape: macro for turn on/off Capping Original Shape.

CmdMarkupSearchNodeFromPoint: macro for finding nearest node.

CmdMarkupSearchNodesFromMultiPoints: macro for finding nearest node by position from CSV.

CmdMarkupSearchElementsFromPoint: macro for finding nearest element.

CmdMarkupSearchElementsFromMultiPoints: macro for finding nearest element by position from CSV.

Additionally, some macro are modified as below:
List of marcos changed and modified

ViewSectionBox(): The command are modified to capture view of rotation.

CmdShowPostDeformation(): For ease of reading, we have enclosed the structure cohesion in macro arguments with {}. Please update your code.

🚅 Sample​

Update tutorial Get output, macro and Python log with new PSJ-Utility command JPT.GetOutputLog().

📝 Other​

Update sample code of PSJ GUI commands due to the changing argument names of two commands dlg.set_item_font() and dlg.get_item_font().

🐛 Bug Fix​

⌘ PSJ-Command​

Fix missing strName keyword argument when printing out PSJ-Command Force-General in Python Window.

Fix the bug of mismatched added material IDs between GUI and API code operations.

Fix the bug of getting error when generate PSJ-Command BodyCut-XXYYOnOnePoint.

📐 PSJ-GUI​

📝 API​

Fix the bug of selectors do not display when running API code exported from GUI Command Builder.

Fix cannot re-read data from file after using clear,cut data or insert row option in the menu of command dlg.add_table() .

Fix cannot get value of spin.

Fix cannot set value for Integer column of Table by API command dlg.set_cell_value().

Fix not displaying the min label when using the API command dlg.set_slider_vertical().

Fix displaying indentation when setting page_orientation = horizontal in API command  dlg.add_tabwnd_page().

📏 GUI Command Builder​

Fix the bug of the label (text) cannot align with Middle and Bottom position in vertical alignment.

Fix the bug of the Group's selector does not display when selecting it only in the GUI Command Builder.

Fix the bug of the copied objects of Table/TextBox/Button/PageItem do not inherit enough properties of source file when copying them. 

Fix the bug of the min value of Slider Bar does not update when changing its value.

Fix cannot change icon file of Dialog.

Fix not displaying label of a vertical Slider Bar when putting it into a layout.

Fix icon of Dialog is not saved when re-opening JDB file.

Fix image location of Button is not saved when re-opening JDB file. 

Fix crash problem when importing source file into ComboBox and ListBox.

Fix the bug of the name of Dialog do not display in Japanese environment.

Fix some bugs related Orientation, Text Alignment, Checked, IsCollapsed, Max/Min values and Read only problems of GroupBox, Radio Button, CheckBox, Slider Bar, Spin and TextBox in Japanese environment.

🛠 PSJ-Utility​

📝 API​

Fix cannot select 3D element by its ID when using DItemType.POST_ELEM.
