# Release Note V5.0.3

Release Note V5.0.3

Highlight updates

This release adds API functions primarily to enhance Post processing. It also updates macros and PSJ Command for new features and new options. In detail:

New data types, macros, and APIs for the Custom Notes (New Feature) control have been added.

Added API to retrieve Post result display information.

Added API to assist with element and node manipulation on Post documents.

Fixed a bug in retrieving elements and nodes on Post documents.

Added APIs to toggle activation, select, and close the currently displayed document.

Fixed a crash problem and other minor bugs in the PSJ-GUI.

Added openpyxl to the preinstalled python library.

🚀 New Features​

📦 Data types​

PSJ-Command:  

New Enumeration Type DItemType and  is added.
List of newly added DItemType

 | INT NOTATION | TYPE OF DITEM

 | 270 | CUSTOM_NOTE

 | 271 | CUSTOM_NOTE_COLLECTION

New Enumeration Type PathType is added.
List of newly added PathType

 | INT NOTATION | TYPE OF PATHTYPE

 | 10 | JPT.PathType.PSJ_COMMAND_PATH

PSJ-Utility: 

New Enumeration Type DTableType is added.
List of newly added DTableType

 | INT NOTATION | TYPE OF DTABLE

 | 154 | JPT.DTableType.DTABLE_CUSTOM_NOTE

 | 155 | JPT.DTableType.DTABLE_CUSTOM_NOTE_COLLECTION

⌘ PSJ-Command​

Updated by adding new option or by aspect of usability/maintainability.
List of commands changed

Connections.Contacts.CheckPattern(): enables to get result of check pattern - matched element ids and mismatched element ids.

Connections.Pretension.Abaqus(): the target designation has been changed from a face cursor to a cursor list of arbitrary entities to match the macro implementation. Also, add one argument to specify a reference node.

Analysis.ADVC.Structure(): added ADVC optimization settings.

Analysis.Ansys.Structure(): added one argument to specify command version for backward compatibility.

🛠 PSJ-Utility​

📝 API​

27 new API commands are added:
List of newly added command

JPT.GetAppPathInfo(): Get the information of path specified by PathType.

JPT.SelectionByIDs(): Select entities by using their IDs.

JPT.IsSpatialPointRendered():Check if a specified point (node) that has the spatial coordinates (X, Y, Z) is rendered in the current view.

JPT.CastDItemToDPostElem():Convert DItem object to DROElem object to get the information of the selected Post element.

JPT.CloseAllGraphViews() : Close all chart views.

JPT.CloseGraphViewByDocumentName(): Close all chart views of indicated document.

JPT.ConvertCoordinateFromGlobalToLocal(): Convert global coordinate of selected DItem Type into specified local coordinate.

JPT.HighlightByID(): The command highlights LBC and property items in the Assemble Tree. At the same time, it changes the display of part faces connected to the highlighted LBC/property in the Main Window.

JPT.SetActiveDocumentByID(): Active the document specified by ID.

JPT.SetActiveDocumentByName(): Active the document specified by Name.

JPT.GetDocumentList(): Get a list of documents opening at current.

JPT.GetActiveDocument(): Get the active document. 

JPT.GetDocumentByID(): Get a document specified by ID.

JPT.GetDocumentByName(): Get a document specified by Name.

JPT.CloseDocumentByID(): Close a document specified by ID.

GetAllCustomNotes: Get all Custom Notes.

GetAllCustomNoteCollections: Get all Custom Note Collections.

JPT.GetCurrentDeformation(): Get current deformation settings.

JPT.GetCurrentViewPoint(): Get current view point settings.

JPT.GetCurrentCrossSection(): Get current cross section settings.

JPT.GetCurrentContour(): Get current contour settings.

JPT.GetCurrentCircle(): Get current circle settings.

JPT.GetCurrentDiagram(): Get current diagram settings. 

JPT.GetCurrentVector(): Get current vector settings.

JPT.GetCurrentAnimation(): Get current animation settings.

JPT.CastDItemToDRONode(): Convert DItem object to DPostNode object.

JPT.CastDItemToDROElem(): Convert DItem object to DPostElem object.

Additionally, some commands are modified as below: 
List of commands changed and modified

JPT.EnableLicenseFeature(): Changed so that JPT_BASE is automatically enabled when a license that requires JPT_BASE to be enabled is specified and activated.

📐 PSJ-GUI​

📝 API​

7 new API commands are added:
List of newly added commands

dlg.remove_combobox_option(): Remove all or some options of a Combobox.

dlg.remove_listbox_options(): Remove all or some options of a Listbox.

dlg.get_listbox_sels(): Get all selected indexes in Listbox.

dlg.get_table_cell_fill_color(): Get the fill color of selected/specified cell.

dlg.on_spin_changed(): Enables to run a function after a Spin value is changed.

dlg.on_listbox_sel(): Enables to run a function after a ListBox item is selected.

dlg.fill_table_by_file(): Set Table data from file directly without using right-click on GUI.

⚙ Macro​

9 new macros are added:
List of newly added macros

ViewRemoveMode: macro for turn ON/OFF remove mode.

ViewShowGroupMode: macro for turn ON/OFF group mode.

ViewShowGlobalCoordinate: macro for turn ON/OFF show global coordinate.

CmdSetPreUnit: macro for setting pre document units.

SetDefaultInitialViewPoint: macro for setting initial view point.

ShowContactPairData: macro implements the display of selections in the Contact Pair Selection dialog.

CreateCustomNote: macro create a Custom Note under specified Collection.

CreateCollection: macro create a Collection.

EditCustomNoteWndPosition: macro move the indicated custom note to specified screen position.

Additionally, some macro are modified as below:
List of marcos changed and modified

LaunchOperation(): Enabled to return value of succeed/failed.

🚅 Sample​

Add new tutorials of intermediate level.
Solving plane stress problem.

Small sample of model setting, analysis and result check.

Small sample to read / write CSV file.

Add a new tutorial of python code.
Python Tips - File I/O

📝 Other​

openpyxl is included in distribution. 

🐛 Bug Fix​

⌘ PSJ-Command​

Fix the bug of Analysis.ADVC.Structure is not displayed in Python API Window.

Fixed a bug in Analysis.MakeProcess.Static where some LBCs did not accept cursor string notation.

Fixed an Invalid literal error caused by Geometry.Transform.Translation returning an empty list.

📐 PSJ-GUI​

📝 API​

Fixed a bug that prevented dlg.set_table_column_width from being set to less than 66. 22 and above can now be set.

Fixed a bug that dlg.on_browse did not return folder paths.

Fixed a bug that dlg.on_dlg_selector_changed

Fixed a crash bug when a selection was deleted during execution of dlg.on_dlg_selector_changed.

📏 GUI Command Builder​

Fixed a bug that the type of a text box is not saved in *.jdb file correctly.

Fix crash by inputting wrong value into Options Count of a Combobox.

Fix crash by inputting wrong value into Total Row Count of a Table.

Fix crash by inputting wrong value into Total Column Count of a Table.

🛠 PSJ-Utility​

📝 API​

Fix the bug of JPT.GetEntitiesByPosition finds wrong target.

Fix the bug of JPT.GetSelectedNodes cannot get nodes of solid elements of post document.

Fix the bug of JPT.MacroListTCursorToListDItem does not work correctly in post document.

⚙ Macro​

Fix an error that LoadTemplate macro does not change view points if it runs sequentially.

Fix an error that SetDefaultInitialTreeCondition does not work correctly.

Fix an error that CmdShowPostContour does not work correctly.

Fix an error that CmdShowPostContour does not change status of show middle node icon.

📝 Other​

Fix error of IDE that Import Python Macro Log (Ctrl+J) fails to import some commands.
