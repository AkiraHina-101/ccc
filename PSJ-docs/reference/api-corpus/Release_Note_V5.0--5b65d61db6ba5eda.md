# Release Note V5.0

Release Note V5.0

Highlight updates

This release introduces PSJ-Command and new PSJ web document. In addition:

Upgrade Python core and its dependencies from version 3.6.3 to 3.9.0

Add more tutorials to get acquainted to PSJ

Add new PSJ-Utility commands (API)

Add new features to GUI Command Builder, Customized Shell and Customized IDE

Fix crash problem while using PSJ custom dialog

🚀 New Features​

⌘ PSJ-Command​

Replace current macro with PSJ-Command, and introduce its scripting API manual.

🛠 PSJ-Utility​

📝 API​

API commands related to database query, casting and selection are added:

List of newly added commands

JPT.BeginDatabaseTransaction : Disable screen animation, screen update and status bar update information to improve Jupiter's performance.

JPT.CastDItemToDConnect : Convert DItem object to DConnect object to get the information of the selected coordinate system.

JPT.CastDItemToDCoord : Convert DItem object to DCoord object to get the information of the selected coordinate system.

JPT.CastDItemToDLoadBC : Convert DItem object to DLoadBC object to get the information of the selected coordinate system.

JPT.ClearAllSelection : Clear all the selected entities.

JPT.CollapseAssemblyTree : Collapse all the items existing on the Assembly window.

JPT.DisableOutputMessage : Disable all the output messages which will be written to the Python API window.

JPT.DisableScreenAnimation : Disable screen animation effect.

JPT.EnableLicenseFeature : Enable/Disable a license feature which is existing in the current Jupiter.

JPT.EnableOutputMessage : Enable the output message which will be written to the Python API window.

JPT.EnableScreenAnimation : Enable screen animation effect.

JPT.EndDatabaseTransaction : Enable data transaction again, after using JPT.BeginDatabaseTransaction().

JPT.ExpandAssemblyTree : Expand all the items existing on the Assembly window.

JPT.GetAllConnections : Get all the information of all existing connections.

JPT.GetAllCoordinates : Get the information of all the created coordinate systems.

JPT.GetAllLoadBoundaryConditions : Get all the information of all existing loads and boundary conditions.

JPT.GetAvailableResultOption : Get all available result options of the inputted result type.

JPT.GetDefaultResultOption : Get all default result options of the inputted result type.

JPT.GetElemsByType : Get a List of Elements by inputting their type (Tri3, Hex8, Tet10, etc.).

JPT.GetGroupFromSubGroup : Get the list of groups under the specified group's name.

JPT.GetMaterialFromProperty : Get the used material information (Name, ID, etc.) from the inputted property ID if it's existed.

JPT.GetMaxResultCoord : Get coordinate of the node/center node of the element having the maximum value of the plotting result.

JPT.GetMaxResultId : Select all the existing entities by type.

JPT.GetMaxResultValue : Get the maximum value of the current plotting result.

JPT.GetMinResultCoord : Get coordinate of the node/center node of the element having the minimum value of the plotting result.

JPT.GetMinResultId : Get the ID of the node/element having the minimum value of the plotting result.

JPT.GetMinResultValue : Get the minimum value of the current plotting result.

JPT.GetResultComponentNames : Get all the available data location existing on the inputted result type and direction.

JPT.GetResultIncrements : Get all the existing increments of the inputted result step.

JPT.GetResultLocations : Get all the available data location existing on the inputted result type and direction.

JPT.GetResultNames : Get all the available result type existing on the model.

JPT.GetResultSteps : Get all the existing result types and their time steps of the current result.

JPT.GetResultTimeStepInfo : Get the relating information of the inputted result step with it's time step.

JPT.GetResultUseIncrement : Get all the existing increments of the inputted result step.

JPT.GetThicknessOfEntity : Get thickness of the inputted entity ID (Available for Part/Face/Element only).

JPT.MessageBoxPSJ : Show a Jupiter dialog (Information, Warning).

JPT.SelectionByID : Select an entity by using its ID.

JPT.SelectionByType : Select all the existing entities having the inputted type.

JPT.SetSelectMethod : Change the selection method in Jupiter to the specified one.

JPT.UpdateCheckboxWatchSelected : Change checkbox state ON or OFF in Watch Selected window by specifying the entity's ID and type.

📐 PSJ-GUI​

📏 GUI Command Builder​

Support Tab key in Table to navigate to the next cell.

Add Group Name in "Save dialog to customer folder" dialog, to make group in customized ribbon.

📟 Customized Shell​

Double click on error line/warning line in Python API window then go to specific line in opened IDE.

Add "Copy As Python Execution" option to right click menu, to copy Macro as PSJ script and paste into IDE.

🗒 Customized IDE​

Add space (tab) automatically while editing code in IDE.

Add PSJ auto-complete suggestion after entering a first character.

Add initial search value with selected word for "Find" and "Find And Replace" dialogs.

Add "Convert To Upper Case", "Convert To Lower Case", "Insert Tab" and "Duplicate Selection/Line" options to Edit menu.

Support dragging input file to IDE into.

Support shortcut keys.

📦 Extra features​

Upgrade Python core and its dependencies from version 3.6.3 to 3.9.0.

Add Python-pptx and Numba libraries.

Add Visual Studio Code extension for PSJ (beta).

🐛 Bug Fix​

📐 PSJ-GUI​

Jupiter crashes if run JPT-GUI and Jupiter's functions simultaneously.

Open File/Folder component has limited character.
