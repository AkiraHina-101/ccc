# Release Note V4.1.4

Release Note V4.1.4

Highlight updates

This release mainly focuses on PSJ-Utility improvements along with few enhancements and bug fixes.

Add new data types

Add new PSJ-Utility commands (API) and samples

🚀 New Feature​

📦 Data types​

Add some new properties to DBody (vertexs, colorMesh, transparance), DEdge (color), DFace (color), DNode (isFloating), DElem (kind, color).

Add new Associate types, Bool types, Entity types, Path types.

Add new list classes DItemVector, BodyVector, FaceVector, ElemVector, GroupVector, NodeVector, EdgeVector

🛠 PSJ-Utility​

📝 API​

API commands related to database query, casting and visibility are added:
List of newly added commands

addObj() : Append a value to the current list.

clearVec() : Clear all the list → The size of the list after using clearVec is equal to 0.

deleteObj() : Delete an object of a list by inputting its index.

extendVec() : Append another list to the selected list.

isContainObj() : Check whether the inputted object is existing in the current list or not.

JPT.CastDItemToDBody() : Convert DItem to DBody to get the information of the selected body.

JPT.CastDItemToDEdge() : Convert DItem to DEdge to get the information of the selected Edge.

JPT.CastDItemToDElem() : Convert DItem to DElement to get the information of the selected Element.

JPT.CastDItemToDFace() : Convert DItem to DFace to get the information of the selected Face.

JPT.CastDItemToDGroup() : Convert DItem to DGroup to get the information of the selected DGroup.

JPT.CastDItemToDNode() : Convert DItem to DNode to get the information of the selected DNode.

JPT.CastToDItem() : Convert the selected one to DItem to get all the related information.

JPT.ClearLog() : Clear all the text existing in the Python API window.

JPT.ConvertJPTColorToRGB() : Convert color code in Jupiter to RBG values.

JPT.ConvertRGBToJPTColor() : Convert RBG values to Jupiter color code.

JPT.Debugger() : Show all the related information of the inputted parameter (value, class, etc.) in the Python API window.

JPT.DItemListToMacroListTCursor() : Convert DItem list to the macro list cursor.

JPT.GetAppPathInfo() : Get the information of the selected path type.

JPT.GetElemsByKind() : Get all the related information of the inputted element type.

JPT.GetEntitiesByAdjacent() : Get all the entities (Faces/Elements) relating to the inputted entity with the inputted condition (Angle).

JPT.GetEntitiesByAssociation() : Get all the entities relating to the inputted target with the inputted conditions.

JPT.GetEntitiesByID() : Get all the related information of the inputted entity and its ID.

JPT.GetEntitiesByName() : Get all the related information of the entities which are having the name similar (Option = 0) or exactly the same (Option = 1) to the inputted conditions.

JPT.GetEntitiesByPosition() : Get all the related information of the entities which are having the coordinate equal or same to the inputted conditions.

JPT.GetMaxIDEntity() : Get the maximum ID of the inputted entity type.

JPT.GetMinIDEntity() : Get the minimum ID of the inputted entity type.

JPT.GetPythonAPILog() : Get the text which is existing on the Python API window.

JPT.GetRandomJPTColor() Get a random color code in Jupiter (Integer value).

JPT.InverseHideBodies() : Show the inputted item only on the display window.

JPT.ListDoubleToMacroVector() : Convert list of values to a string of macro type.

JPT.MacroListTCursorToListDItem() : Convert a string of macro type to DItemVector type.

JPT.PrintAppPathInfo() : Show all the related information of the current model file on the Python API window, including program path, temp path, appdata path, document path (jtdb path).

JPT.PrintPSJUtilityManual() : Show all the existing Python API function with its information on the Python API window.

JPT.QuitApplication() : Close Jupiter

JPT.RemoveEntitiesByID() : Remove an inputted entity type and its ID

JPT.RemoveEntitiesByName() : Remove all the entities which are containing the name is similar (Option 3 = 0) or exactly the same (Option 3 = 1) to the inputted value

JPT.ShowHideAllParts() : Show/Hide all the existing parts on the model

JPT.ShowHideEntitiesByID() : Show/Hide the inputted item id

JPT.ViewFitToModel() : Change the current view to fit to the model

🚅 Sample​

Add 26 samples to \SampleData\PSJ\PSJ-Utility folder, instruct user how to make use of PSJ-Utility effectively.
