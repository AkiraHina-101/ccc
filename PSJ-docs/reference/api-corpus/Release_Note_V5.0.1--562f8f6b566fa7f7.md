# Release Note V5.0.1

Release Note V5.0.1

Highlight updates

This release mainly focuses on new PSJ-GUI and PSJ-Utility features. In detail:

Improve usability of PSJ-GUI commands (API) and GUI Command Builder.

Add new PSJ-Utility commands (API), especially Preview and Post Utility.

Add new data types for PSJ-Command, PSJ-Utility and PSJ-GUI.

Fix arguments name used in PSJ Command.

Fix crash problem and some minor bugs of PSJ-GUI, GUI Command Builder.

🚀 New Features​

📦 Data types​

PSJ-Command: EntityType has been merged into DItemType as the official type representing type of DItem in Jupiter.
New types of DItemType are also added.
List of newly added DItemType

 | INT NOTATION | TYPE OF DITEM

 | 8 | JPT.DItemType.SHAPELINK

 | 9 | JPT.DItemType.BODYLINK

 | 17 | JPT.DItemType.REF_SHAPELINK

 | 18 | JPT.DItemType.REF_BODYLINK

 | 48 | JPT.DItemType.LBC_TEMP_LOAD

 | 59 | JPT.DItemType.LBC_DYNAMIC_INITIAL_CONDITION

 | 62 | JPT.DItemType.LBC_MAPPING_FORCE

 | 63 | JPT.DItemType.LBC_MAPPING_TEMP_LOAD

 | 174 | JPT.DItemType.LBC_MAPPING_TEMP_INIT

 | 66 | JPT.DItemType.LBC_INITSTRESS_GENERAL

 | 77 | JPT.DItemType.LBC_WELD

 | 92 | JPT.DItemType.PROPERTY_3D_WELDBEAD

 | 95 | JPT.DItemType.SECTION_SKETCHER

 | 100 | JPT.DItemType.CONNECT_PROD

 | 104 | JPT.DItemType.CONNECT_MOMENT

 | 105 | JPT.DItemType.CONNECT_WELD

 | 113 | JPT.DItemType.CONTACT

 | 114 | JPT.DItemType.CUSTOM_ATTR_STRING

 | 115 | JPT.DItemType.CUSTOM_ATTR_VECTOR

 | 116 | JPT.DItemType.CUSTOM_ATTR_DOUBLE

 | 128 | JPT.DItemType.ADVCPROCESS_SSH

 | 129 | JPT.DItemType.ADVCPROCESS_TH

 | 149 | JPT.DItemType.WELDORDER

 | 150 | JPT.DItemType.ATTRIBUTE_FXWELD

 | 154 | JPT.DItemType.ATTRIBUTE_PS_BLENDSURFACE

 | 160 | JPT.DItemType.LBC_PRETENSION_NXN

 | 161 | JPT.DItemType.LBC_MAPPING_TEMP_MARINE_ENGINE

 | 162 | JPT.DItemType.USER_PROP

 | 165 | JPT.DItemType.LBC_MAPPING_FORCEDDISPLACEMENT

 | 166 | JPT.DItemType.LBC_MAPPING_FORCED_TEMP

 | 167 | JPT.DItemType.NASTRAN_POSTJOB

 | 168 | JPT.DItemType.ADVC2_POSTJOB

 | 183 | JPT.DItemType.TSV_POSTJOB

 | 184 | JPT.DItemType.MARCJOB

 | 173 | JPT.DItemType.PERMASJOB

 | 180 | JPT.DItemType.FRONTISTRJOB

 | 192 | JPT.DItemType.POST_NODE

 | 193 | JPT.DItemType.POST_ELEM

 | 232 | JPT.DItemType.OPTISHAPE_TS_JOB

In addition, new types of ElemKind and ElemType are also added:
List of newly added ElemKind and ElemType

 | ElemKind Int Notation | Kind of Elem | ElemType Int Notation | Type of Elem

 | 3 | ELEMKIND_2D | 17 | ELEMTYPE_QUAD6

 |  |  | 18 | ELEMTYPE_QUAD9

 | 4 | ELEMKIND_3D | 19 | ELEMTYPE_PRISM12

 |  |  | 20 | ELEMTYPE_HEX18

 | 5 | ELEMKIND_SP | 16 | ELEMTYPE_PLOT

 |  |  | 21 | ELEMTYPE_RBE

 |  |  | 22 | ELEMTYPE_MASS

 |  |  | 23 | ELEMTYPE_VIRTUAL

PSJ-Utility: has been separated into 2 types Pre-Utility and Post-Utility:

Pre-Utility: Data type used for pre-processing workflow, with some new classes and updates:

Built-in-type: Add new DItemPair, DItemPairVector, DCoord, CoordVector, DConnect, ConnectVector, DLoadBC, LoadBCVector, DSolverJob, SolverJobVector, Document.
Furthermore, DBody has been added new attribute properties.

Enumeration type: Added new type JPT.PathType.FILE_PATH of Path Types.
Additionally, new types of DTableType are added:
List of newly added DTableType

 | ID | Dtable type

 | 58 | JPT.DTableType.DTABLE_SUP_GROUP

 | 60 | JPT.DTableType.DTABLE_ELEMEDGE_GROUP

 | 62 | JPT.DTableType.DTABLE_SECTION

 | 65 | JPT.DTableType.DTABLE_CUSTOM_ATTRIBUTE

 | 79 | JPT.DTableType.DTABLE_LBC_DOFSET

 | 86 | JPT.DTableType.DTABLE_POSTJOB

 | 87 | JPT.DTableType.DTABLE_USER_RESULT

New UnitType are also added:
List of newly added UnitType

 | ID | Unit Type | String Unit

 | 28 | JPT.UnitType.Unit_LinearDensity | kg/moz/ftoz/inlb/ydkg/m\\oz/ft\\oz/in\\lb/ydkg/moz/ftoz/inlb/yd

 | 29 | JPT.UnitType.Unit_SurfaceDensity | 

 | 30 | JPT.UnitType.Unit_AreaMomentInertia | mm4m4ft4in4cm4mm^4\\m^4\\ft^4\\in^4\\cm^4mm4m4ft4in4cm4

 | 37 | JPT.UnitType.Unit_StrainEnergy | N−mmN−mN-mm\\N-mN−mmN−m

 | 41 | JPT.UnitType.Unit_ElectricalResistivity | Ohm−mmOhm−mOhm-mm\\Ohm-mOhm−mmOhm−m

Post-Utility: Data type used for post-processing workflow, with whole new classes added:

Built-in-type: DPostElem, DPostNode, Post Data Option, Post Time Step Info.

Enumeration type: Post Analysis Types, Post Data Range Types, Post Result Data Location Types, Post Result Data Conversion Types, Post Result Data Continuous Types, Post Result Data Coordinate Types, Post Result Data Load 1D Types, Post Result Data Load 2D Types, Post Result Data Complex Types.

PSJ-GUI: Add new classes to work with Table: TableCellID, TableCellVector, TableCellRange, TableCellRangeVector, TableColumnInfo, TableColumnInfoVector.

⌘ PSJ-Command​

Rename keyword arguments of PSJ-Command to ensure the readability while using them and unify the scientific terminology aspect.
List of commands changed

 | PSJ-Command | Old | New

 | Analysis.AbaqusStep.CoupledTDStep | dDampingfactor | dDampingFactor

 | Analysis.AbaqusStep.DynamicStep | iNlgeom | iNlGeom

 | Analysis.AbaqusStep.SteadyStateStep | iNlgeom | iNlGeom

 | BoundaryConditions.Pressure.General | iArrowdir | iArrowDir

 | Connections.MPC.Equation.SemiAuto | listMPCConnection | listMpcConnection

🛠 PSJ-Utility​

📝 API​

29 new API commands related to database query, preview and post-processing are added:
List of newly added commands

JPT.GetAllCoordinates(): Get the information of all the created coordinate systems.

JPT.GetAssemblyEntityData() : Get all information of a specific item from Assembly Tree.

JPT.GetSelectedElemEdges() : Get all information of the selected element edges.

JPT.GetSuppressedParts() : Get all information of all suppressed parts.

JPT.GetPostElemFromPosition() : Get post element from a specific position.

JPT.GetAllAvailableResultOptions() : Get all available result options of the inputted result type.

JPT.GetActiveDataOption() : Get the active Post Data Option of the working result.

JPT.GetResultByNodeId() : Get the result value of specified Node by ID.

JPT.GetResultByElemId() : Get the result value of specified Element by ID.

JPT.GetElementResult() : Get elements with loaded results satisfy a condition.

JPT.GetNodeResult() : Get nodes with loaded results satisfy a condition.

JPT.GetResultSetName() : Get the name of Result Set (Subcase).

JPT.GetTimeStepInfoName() : Get the name of Time Step Info.

JPT.GetActivePostJob() : Get information of active Post Job.

JPT.PostHasDeform() : Check whether if the working result has deformation or not.

JPT.SelectionByID() : Select an entity by using its ID.

JPT.ClearPreview() : Clear preview render on the main screen.

JPT.HidePreview() : Hide preview render on the main screen. Preview is still existing, but it will be hidden.

JPT.ShowPreview() : Show preview render on the main screen.

JPT.PreviewTranslation() : Show result preview of body translation.

JPT.PreviewScaling() : Show result preview of body scaling.

JPT.PreviewRotate() : Show result preview of body rotation.

JPT.PreviewMirror() : Show result preview of body mirror.

JPT.PreviewBCForceGeneral() : Show result preview of applying general force on target.

JPT.PreviewBCForceNormal() : Show result preview of applying normal force on target.

JPT.PreviewBCPressureGeneral() : Show result preview of applying general pressure on target.

JPT.UpdateCheckboxAssembly() : Set state of checkbox of item in Assembly Tree.

JPT.GetAllSolverJobs() : Get all the information of solver jobs (job name, steps, job description).

JPT.MacroTCursorPairToDItemPair() : Convert cursor pair (Macro string type) to a pair of DItem object.

📐 PSJ-GUI​

📏 GUI Command Builder​

Add collapse/expansion functions to the hierarchy toolbar.
Expand all tree nodes: Expand all components inside selected container.

Collapse all tree nodes: Collapse all components inside selected container.

Add Save As button to the toolbar menu.

Add name of file on the top-left corner when opening *.jdb and working behavior when saving data (an asterisk * will be added to name of *.jdb if data is changed).

Support Drag & Drop operations in the hierarchy window, this helps moving component to different location faster and easier.

Add status bar at the bottom-left corner: Show message when using GUI Command Builder.

Add "Modal Mode" and "Icon File" to Dialog.

Auto fit of column width in the table after double-clicking the border between 2 headers.

Table cell is displayed as blank if Double or Integer typed cell’s value is zero.

Rename components: TabWnd, Browser, PagesCtrl.

Enable option of other components/containers which are in GroupBox container with using Has Check Label will be disabled and grayed out automatically. At that time, their enable control will depends on their parent GroupBox.

📝 API​

Some APIs have changed name, such as TabWnd, PagesCtrl, Browser, PagesCtrl as the same as GUI Command Builder described.

To get value inside a GUI component, use API instead of passing component name as input argument, for example:

Current

Before

def on_execute_button_clicked(dlg):
  argument1=dlg.get_item_text(name="...")
  argument2=dlg.get_combox_sel(name="...")
  argument3=dlg.get_listbox_sel(name="...")
  argument4=dlg.get_combobox_option(name="...",index=1)
  #execution function below

def on_execute_button_clicked(dlg,argument1,argument2,argument3,argument4):
  #execution function below

Argument name in some commands are changed for unification purpose.
List of argument name changed

 | Component Group | Old Argument Name | New Argument Name | Example of New Argument Name

 | TABITEM | tabwnd_name | name | dlg.add_tabwnd_page(name="TabWnd1",…)

 | COMBOBOX | combobox_name | name | dlg.add_combobox_option(name="ComboBox2",…)

 | LISTBOX | listbox_name | name | dlg.add_listbox_option(name="ListBox3",…)

 | TABLE | table_name | name | dlg.get_cell_value(name="Table4",…)

 | PAGEITEM | pagesctrl_name | name | dlg.add_pageitem(name="PagesCtrl5",…)

Additionally, some commands are added and modified as below:
List of newly added commands

JDGCreator(): A Class to generate Dialog in Jupiter.

dlg-on_dlg_apply(): Execute a created function when Apply button is clicked.

dlg-on_dlg_cancel(): Execute a created function when Cancel button is clicked.

dlg-on_dlg_ok(): Execute a created function when OK button is clicked.

dlg.on_dlg_help(): Execute a created function when help button is clicked.

dlg.do_modal(): Execute the created dialog (show the dialog with all the created functions) with Modal mode.

dlg.close(): Close the dialog.

dlg.set_icon_file(): Set icon for the creating GUI dialog.

dlg.show_tooltip(): Show tooltip when user hover the mouse to a UI component.

dlg.show_dlg_help_button(): Show or hide the help button in the creating dialog.

dlg.on_combobox_sel(): Run a created function after a Combobox item is selected.

dlg.on_button_clicked(): Bind a created function to a Button/RadioButton/CheckBox.

dlg.on_browse(): Bind a created function to a file/folder Browser component.

dlg.add_table_right_menu(): Add options to the context menu (Right click event) of Table.

dlg.enable_table_column_filter(): Add filter option of column of Table.

dlg.get_cell_value(): Get value of a specific cell.

dlg.get_table_column_width(): Get the width of the specified column in a Table.

dlg.get_table_sel_cell(): Get the information and attributes of the selected cells.

dlg.get_table_sel_range(): Get the information and attributes of the selected ranges of cell.

dlg.insert_table_rows(): Insert row(s) at a specific position on the Table.

dlg.insert_table_columns(): Insert column(s) at a specific position on the Table.

dlg.delete_table_row(): Delete row at a specific position on the Table.

dlg.delete_table_column(): Delete column at a specific position on the Table.

dlg.is_table_cell_button(): Check the input cell is a button cell or not.

dlg.is_table_cell_checkbox(): Check the input cell is a checkbox cell or not.

dlg.is_table_cell_combobox(): Check the input cell is a combobox cell or not.

dlg.is_table_cell_checked(): Check the state of checkbox cell.

dlg.on_table_right_menu(): Set event when opening/executing context menu.

dlg.on_table_sel_changed(): Set event when selecting a cell.

dlg.on_table_button_clicked(): Set event when selecting a button cell.

dlg.set_cell_value(): Set a value for a specific cell.

dlg.set_table_cell_fill_color(): Set fill color to the selected/specified cells.

dlg.set_table_cell_text_color(): Set color to text in the selected/specified cells.

dlg.set_table_cell_alignment(): Set text alignment of cell.

dlg.set_table_column_width(): Set the width of the specified column in a Table.

dlg.set_table_column_data_type(): Set data type validation of cell of Table.

dlg.set_table_cell_button(): Set button cell in Table.

dlg.set_table_cell_checkbox(): Set checkbox cell in Table.

dlg.select_table_range(): Select a specific range by position on the Table.

dlg.clear_table_range(): Clear content of the specific range by position on the Table.

dlg.clear_table_all(): Clear all content of the Table.

dlg.get_pagesctrl_current_page(): Get the index order of current selected PageItem of the PagesCtrl.

dlg.get_pagesctrl_page_name(): Get the name of current selected PageItem of the PagesCtrl.

dlg.on_pagesctrl_active_page(): Set event when selecting a PageItem.

dlg.set_item_size_behavior(): Set display behavior of TabWnd, ImageCtrl, Table, PagesCtrl.
List of commands changed or modified

dlg.add_groupbox(): Remove width and height arguments of GroupBox.

dlg.add_textbox(): Support arguments to control alignment and read-only state of text in Textbox.

dlg.add_combobox(): Support arguments to control default displaying option of ComboBox.

dlg.add_checkbox(): Support arguments to control alignment of text in CheckBox.

dlg.add_table(): Support arguments to enhance controlling the Table.

dlg.add_tabwnd(): Change name from TabCtrl to TabWnd.

dlg.add_button(): Support image Button.

dlg.add_spin(): Support integer and double Spin.

⚙ Macro​

Macros related to post-processing and template utilisation are added:
List of newly added macros

CmdActivateWindow: macro for activating a specific Pre or Post window.

CmdDistancePlot: macro for Distance Plot.

CmdMaxMinPlot: macro for Max Min Plot.

CreateTemplate: macro for create template.

DeleteTemplate: macro for delete template.

LoadTemplate: macro for load template to current document.

CopyTemplate: macro for copy template.

UpdateTemplate: macro for update specified template.

ExportTemplate: macro for export templates to .xml file.

ImportTemplate: macro for import templates from .xml file.

AttachTemplateContour: macro for attach contour setting to existing template.

AttachTemplateDeformation: macro for attach deformation setting to existing template.

AttachTemplateViewPoint: macro for attach view point setting to existing template.

AttachTemplateDiagram: macro for attach dialog setting to existing template.

AttachTemplateVector: macro for attach vector setting to existing template.

AttachTemplateCircle: macro for attach circle setting to existing template.

AttachTemplateCrossSection: macro for attach cross section setting to existing template.

AttachTemplateAnimation: macro for attach cross section setting to existing template.

CmdSaveOpenTsdv: macro for save / load tree of Post Tools window.

CreateNewChartWindow: macro for create new chart window.

CmdMarkupSearchPoint: macro for pick position on / inside result data from input value.

CmdMarkupSearchMultiPoints: macro for pick multiple positions on / inside result data from input value.

Path description in macro is unified to separate by slash (/), some import and save commands are updated, i.e. CmdExportLoad, CmdImportGauge, etc.

String description in macro is unified to be enclosed in double quotation (“”), some commands that use string in arguments are updated, i.e. CmdDataPaneSaveToFile, CmdChartSetTitleX, CmdChartSetTitleY.

Add some curly bracket ({}) that means structure in CmdShowPostContour macro argument, this macro is also updated according to the new option added.

🚅 Sample​

Add sample Manipulate PSJ data type to instruct user how to make use/handle datatype proficiently.

Add sample Get entity from selection to instruct user how to get and deal with entities getting from selection.

Add sample Update window checkbox to instruct user how to control checkboxes of Assembly Tree and Watch Selected window efficiently.

Add 12 basic Table samples, and 6 advanced Table samples, to instruct user how to make use of PSJ-GUI effectively, especially with Table component.

📝 Other​

Update tutorial Get Jupiter path information with new new type JPT.PathType.FILE_PATH.

Update sample Creating a standard bolt with new upgraded PSJ-GUI.

🐛 Bug Fix​

⌘ PSJ-Command​

Fix wrong typo of argument name

 | PSJ-Command | Old | New

 | Home.Find | strSeletedType | strSelectedType

📐 PSJ-GUI​

📝 API​

Fix problem that user cannot import PySide2 library (previously used by Jupiter Dialog Generator - JDG).

📏 GUI Command Builder​

Fix problem with appearance of GUI Command Builder.

Fix redo/undo, adding components, saving/opening jdb file affects collapse/expansion in the hierarchy window.

Fix crash problem while using GUI Command Builder and PSJ dialog.

Fix missing keyword argument/API of component when generating PSJ code from GUI Command Builder.

Fix enlarging the dialog changes the position of picture inside.

Fix random dialog appears after pressing a button.

⚙ Macro​

Fix the bug of CmdPostAnimationIncPlay macro does not work.

Fix the bug of CmdPostAnimationIncPlay macro does not display in Macro Window.

Fix the bug of CmdPostAnimationIncPausemacro does not display in Macro Window.

Fix the unit conversion error of 7th argument of CmdPlotStrainGauge2Nodes.

Remove extra macro lines displayed when mesh file is imported in post document.

🚅 Sample​

Fix import command of sample Get info from Part.
