# Release Note V4.1.3

Release Note V4.1.3

Highlight updates

This release mainly focuses on PSJ-Utility and PSJ-GUI improvements along with few enhancements and bug fixes.

Add new PSJ-Utility commands (API)

Add new PSJ-GUI commands (API)

Add advanced control to GUI Command Builder

🚀 New Features​

🛠 PSJ-Utility​

📝 API​

API commands related to database query, modification are added:

List of newly added commands

JPT.CheckLicense() : Check whether the inputted license is activated or not.

JPT.ClearRedo() : Clear all the saved redo steps.

JPT.ClearUndo() : Clear all the saved undo steps.

JPT.ConvertFromDocUnit() : Convert the user's unit to the SI unit system.

JPT.ConvertFromMacroUnit() : Convert the user's unit to the macro unit system.

JPT.ConvertValueToDocUnit() : Convert the SI unit system to the user's unit.

JPT.ConvertValueToMacroUnit() : Convert the macro unit system to the user's unit.

JPT.CopyToClipBoard() : Take a screenshot of the current view and save it to window clipboard.

JPT.CreateSubAssembly() : Create sub assembly automatically.

JPT.DeleteSubAssembly() : Delete the inputted sub assembly containing all the related information.

JPT.Exec() : Run Jupiter macro by inputting that macro to this function.

JPT.FindSubAssemblyByID() : Get all the related information of the inputted assembly ID.

JPT.FindSubAssemblyByName() : Get all the related information of the inputted assembly name.

JPT.GetAllByTableTypeID() : Get all the information of the inputted table type id (To check the current available table type id, user can use JPT.Debugger(JPT.DTableType.values)).

JPT.GetAllByType() : Get all the information of the inputted type id (To check the current available type id, user can use JPT.Debugger(JPT.EntityType.values)).

JPT.GetAllEdges() : Get all the information of all existing edges on the model.

JPT.GetAllElems() : Get all the information of all existing elements on the model.

JPT.GetAllFaces() : Get all the information of all existing faces on the model.

JPT.GetAllGroups() : Get all the information of all existing groups on the model.

JPT.GetAllLoadsBCs() : Get all the information of all existing boundary conditions on the model.

JPT.GetAllNodes() : Get all the information of all existing nodes on the model.

JPT.GetAllParts() : Get all the information of all existing parts on the model.

JPT.GetAllPartsInSubAssembly() : Get all the related information of the parts which are belonging to the inputted assembly.

JPT.GetAllSelected() : Get all the information of all the selected items (Part, nodes, elements, etc.).

JPT.GetCenterOfEntities() : Get the center of the selected entities.

JPT.GetCountByType() : Get the total number of the inputted type.

JPT.GetCurrentDocumentPath() : Get the path of the current working Jupiter file.

JPT.GetJPTTempPath() : Get the link of the temporary folder of Jupiter.

JPT.GetLastCreatedCursor() : Get the last created cursor and all of its related information.

JPT.GetMacroLog() : Get the text which is existing on the Macro window.

JPT.GetMaterialDBById() : Get the material ID in the Material Database of the inputted material ID.

JPT.GetMaterialXML() : Get all the existing materials in the Material Database.

JPT.GetOpnList() : Get all the available functions of Jupiter which are having their own GUI.

JPT.GetProgramPath() : Get the Jupiter installation folder path.

JPT.GetRedoCount() : Get all the redo steps existing on the current model.

JPT.GetSelectedEdges() : Get all the information of the selected edges.

JPT.GetSelectedEdgesCr() : Get the ID of the selected edges.

JPT.GetSelectedElems() : Get all the information of the selected elements.

JPT.GetSelectedElemsCr() : Get the ID of the selected elements.

JPT.GetSelectedFaces() : Get all the information of the selected faces.

JPT.GetSelectedFacesCr() : Get the ID of the selected faces.

JPT.GetSelectedGroups() : Get all the information of the selected groups.

JPT.GetSelectedGroupsCr() : Get the ID of the selected groups.

JPT.GetSelectedNodes() : Get all the information of the selected nodes.

JPT.GetSelectedNodesCr() : Get the ID of the selected nodes.

JPT.GetSelectedParts() : Get all the information of the selected parts.

JPT.GetSelectedPartsCr() : Get the ID of the selected parts.

JPT.GetSharedElements() : Get all the related information of the shared elements which are relating to the inputted conditions.

JPT.GetSharedFaces() : Get all the related information of the shared faces which are relating to the inputted conditions.

JPT.GetSharedNodes() : Get all the related information of the shared nodes which are relating to the inputted conditions.

JPT.GetUndoCount() : Get the total number of undo steps.

JPT.MsgOut() : Print the inputted text to the Python API window.

JPT.RemoveAllAbaqusStep() : Remove all the existing Abaqus steps on the current model.

JPT.RemoveAllByTableType() : Remove all the related items of the inputted table type.

JPT.RemoveAllConnections() : Remove all the existing connections on the current model.

JPT.RemoveAllContacts() : Remove all the existing contacts on the current model.

JPT.RemoveAllCoordinates() : Remove all the existing coordinates on the current model.

JPT.RemoveAllFieldTables() : Remove all the existing field data table on the current model.

JPT.RemoveAllLoadCases() : Remove all the existing load cases on the current model.

JPT.RemoveAllLoadsBCs() : Remove all the existing boundary conditions on the current model.

JPT.RemoveAllMaterials() : Remove all the existing material on the current model.

JPT.RemoveAllMeshSettings() : Remove all the existing mesh settings on the current model.

JPT.RemoveAllSolverjob() : Remove all the existing solver jobs on the current model.

JPT.RemoveWSProperties() : Remove all the existing properties on the current model.

📐 PSJ-GUI​

📝 API​

API commands related to selector, browser, pagectrl, table are added:

List of newly added commands

dlg.add_1delement_selector() : Add a 1D element selector to dialog and user can select 1D element only.

dlg.add_2delement_selector() : Add a 2D element selector to dialog and user can select 2D element only.

dlg.add_3delement_selector() : Add a 3D element selector to dialog and user can select 3D element only.

dlg.add_barpart_selector() : Add a bar part selector to dialog and user can select bar part only.

dlg.add_edge_selector() : Add an edge selector to dialog and user can select edge only.

dlg.add_elementedge_selector() : Add an element edge selector to dialog and user can select element edge only.

dlg.add_face_selector() : Add a face selector to dialog and user can select face only.

dlg.add_node_selector() : Add a node selector to dialog and user can select node only.

dlg.add_part_selector() : Add a part selector to dialog and user can select part only.

dlg.add_vertex_selector() : Add a vertex selector to dialog and user can select vertex only.

dlg.add_browser() : Add a file/folder browser component to dialog.

dlg.add_pagesctrl() : Add a pagesctrl component to dialog.

dlg.add_pagesctrl_page() : Add a new page window to an existed pagectrl.

dlg.add_table() : Add a table component to dialog.

📏 GUI Command Builder​

Add open a save database

Add advanced UI controls: Open File/Folder, Table, Wizard.
