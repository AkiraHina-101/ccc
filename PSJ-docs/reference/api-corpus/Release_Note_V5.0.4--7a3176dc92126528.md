# Release Note V5.0.4

Release Note V5.0.4

Highlight updates

This release adds API functions primarily to enhance Post processing. It also updates macros and PSJ Command for new features and new options. In detail:

New data types, macros, and APIs for the OOBB Alignment (New Feature)  have been added.

Added macro and API to Show/Hide parts appearance.

Added macro and API to control and check license status easier.

Image trimming options are added to image capture macro and API.

Added visible only option to Get Value APIs.

🚀 New Features​

📦 Data types​

PSJ-Command:

New Enumeration Type AnalysisType are added.

List of newly added Post Analysis type 

 | INT NOTATION | TYPE OF POST ANALYSIS

 | 10 | JPT.PostAnalysisType.POST_ANALYSIS_SHAPE_OPTIMIZATION

 | 11 | JPT.PostAnalysisType.POST_ANALYSIS_TOPOLOGY_OPTIMIZATION

PSJ-Utility:

New Enumeration Type DTableType are added.

List of newly added Post DTalbe type

 | ID | DTABLE TYPE | Description

 | 96 | JPT.DTableType.DTABLE_POST_NODE | Post Node table

 | 97 | JPT.DTableType.DTABLE_POST_ELEM | Post Element table

⌘ PSJ-Command​

Updated by adding new option or by aspect of usability/maintainability.

List of newly added command

MainWindow.RightClick.SetPartAppearance: Enables to Show/Hide Part Appearance.

List of commands changed

Additionally, some commands are modified as below:

Home.CopyToClipboard: Options enables to crop captured image to the displayed entity range are added.

Home.ToImage: Options enables to crop captured image to the displayed entity range are added.

Home.ToPPTX: Options enables to crop captured image to the displayed entity range are added.

🛠 PSJ-Utility​

📝 API​

12 new API commands are added:

List of newly added command

JPT.EnableAllLicenses : Enable all the available licenses.

JPT.GetAllContacts : Get the information of all existing contacts.

JPT.GetAllLicensesStatus : Get the status of all the available licenses.

JPT.GetAllPostNodes : Get all the information of Post (read-only) nodes. It works on Post document.

JPT.GetAllPostElems : Get all the information of Post (read-only) elements. It works on Post document.

JPT.GetInternalIDRefItem: Get internal ID of reference entity.

JPT.GetResultTitle: Get contents of title when result is loaded.

JPT.GetScreenHeight : Get the height of screen window.

JPT.GetScreenPositionOfEntities : Obtains the position of the specified item in the Main Window.

JPT.GetScreenWidth : Get the width of screen window.

JPT.GetAllResultsByElemId : Get all the result values of specified Element by ID.

JPT.GetAllResultsByNodeId : Get the result value of specified Node by ID.

JPT.GetPostSolverTypeString :Get import result type and return an Enum value representing the type.

Additionally, some commands are modified as below:

List of commands changed and modified

JPT.GetAllNodes : Display a hint when it is run on Post documents to inform the user that this function is exclusively for Pre documents.

JPT.GetAllElems : Display a hint when it is run on Post documents to inform the user that this function is exclusively for Pre documents.

JPT.GetMaxResultId : Enables to get value only for visible entities.

JPT.GetMaxResultValue : Enables to get value only for visible entities.

JPT.GetMinResultId : Enables to get value only for visible entities.

JPT.GetMinResultValue : Enables to get value only for visible entities.

📐 PSJ-GUI​

📏 GUI Command Builder​

Visible option are putted into Properties folder of all Tool Box components: Layout, GroupBox, TabWnd, TabItem, Label, TextBox, RichEditCtrl, ComboBox, ListBox, CheckBox, RadioButton, Button, ImageCtrl, Spin, SliderBar, Separator, Browser, Table, PageCtrl, PageItem.

📝 API​

3 new API commands are added:

List of newly added commands

dlg.set_item_visible: Set the state of the created component as visible or hidden.

dlg.is_groupbox_checked: Check the state of a GroupBox's checkbox.

dlg.on_groupbox_checked: Bind a created def function to a GroupBox's CheckBox.

⚙ Macro​

10 new macros are added:

List of newly added macros

ALIGNMENTBYOOBB : Align the position of the target part with the position of the reference part by using OOBB (Object Oriented Boundary Box).

CmdWriteCSVForGeneralReportLinearStatic: macro for export Linear Static report into CSV file.

CmdWriteCSVForGeneralReportModal: macro for export Modal report into CSV file.

ExportGroup: Enables to export group by macro.

ExportWindowSettings: Enables to export window settings by macro.

ImportGroup: Enables to import group by macro.

SetHidingElementFactor: (For Topology Optimization) Enables to indicate hiding source and factor.

SetPartAppearance : Enables to Show/Hide Part Appearance by macro.

ToPre: macro for convert Post document to Pre document.

ToPost: macro for convert Pre document to Post document.

Additionally, some macro are modified as below:

List of marcos changed and modified

ADVC_Structure: Options enables to output gray_scale_ratio_tol and output_gray_scale_ratio are added.

Capture_CopyToClipboardEx: Options enables to crop captured image to the displayed entity range are added.

Capture_ToPPT: Options enables to crop captured image to the displayed entity range are added.

Capture_ToImageEx: Options enables to crop captured image to the displayed entity range are added.

Prop2DShell: Options enables to set ERP options and temperature variation value are added.

🐛 Bug Fix​

⌘ PSJ-Command​

Fixed the issue where Measure commands return a different precision than the specified value.

Fixed the issue where Tools.TotalLoad commands return incorrect values in some cases.

📐 PSJ-GUI​

📝 API​

Fixed a bug of dlg.set_item_text()  causing the incorrect formatting of GroupBox when using the command for it.

Fixed a bug of the name of GroupBox is changed when toggling the PageItem of a PageCtrl.

Fixed a bug of dlg.add_table() cannot run if Columns Count = 0 or Rows Count = 0

📏 GUI Command Builder​

Fixed a bug that the default text of RichEditControl was not kept when reloading *jdb file.

Fixed a bug that the double properties of Spin were not kept when reloading *jdb file.

🛠 PSJ-Utility​

📝 API​

Fixed the issue that JPT.GetAllByTypeID() returns incorrect values for POST_NODE and POST_ELEM types in Post documents.

Fixed the performance issue where it took a long time to check the isFloating attribute of the DNODE class.

Fixed the issue that JPT.GetMaxIDEntity() returns incorrect value.

Fixed the issue that JPT.DisableScreenAnimation() does not work for SetUserViewPoint macro. (March release)

⚙ Macro​

Fix an error that DeleteFace macro requires internal ID of entity as argument.

Fix errors that MeasureTotalLoad_ macros return incorrect values in some cases.

Fix errors that SetUserViewPoint macro show different result from GUI operation. (March release)
