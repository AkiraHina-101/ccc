# Release Note V5.1.0

Release Note V5.1.0

Highlight updates

Version 5.1 brings major updates focused on enhancing Post-processing functionality and strengthening visualization and automation features. Significant improvements have been made to PSJ Commands, macros, GUI operations, and PSJ Utilities-resulting in greater scripting control and more intuitive operation.

In detail:

Full PSJ Command Support for Post-processing

Enhanced Visualization and Drawing Capabilities

More Flexible Material Handling

Improved PSJ-GUI Interactivity

New APIs and DItemTypes for Result Handling

Enhanced Scripting and Automation

Updates to Macros and PSJ Commands

🚀 New Features​

📦 Data types​

PSJ-Command:

New types of DItemType are added.

List of newly added DItemType

 | INT NOTATION | TYPE OF DITEM

 | 167 | NASTRAN_OP2_POSTJOB

 | 169 | USER_RESULT

 | 170 | LBC_PRETENSION_ADVC

 | 171 | CONTACT_TSSOLVER

 | 172 | NASTRAN_HDF5_POSTJOB

 | 175 | PROPERTY_2D_RIGID_BODY

 | 176 | LBC_PRETENSION_SUNSHINE

 | 179 | CONTACT_PERMAS

 | 181 | FRONTISTRSTEP

 | 182 | UNV_POSTJOB

 | 185 | MARCSTEPS_STRUCT_STATIC

 | 186 | MARCSTEPS_STRUCT_FREQUENCY

 | 187 | MARCSTEPS_THERMAL_SS

 | 188 | MARCSTEPS_THERMAL_TRANSIENT

 | 194 | POST_RESULT_CURVE

 | 195 | POST_FREQ_ANALYSIS

 | 196 | POST_FREQ_RESULT_CURVE

 | 197 | POST_FREQ_LOAD

 | 198 | POST_FREQ_LOADCASE

 | 199 | POST_FREQ_RESPONSE

 | 200 | POST_FREQ_INTERACTIVE_LOAD_AND_RESPONSE

 | 201 | POST_FREQ_RESULT_MPF_CURVE

 | 202 | POST_TRANS_ANALYSIS

 | 203 | POST_TRANS_RESULT_CURVE

 | 204 | POST_TRANS_LOAD

 | 205 | POST_TRANS_LOADCASE

 | 206 | POST_TRANS_RESPONSE

 | 207 | POST_TRANS_RESULT_MPF_CURVE

 | 208 | POST_BTXBTA

 | 209 | POST_ACTRAN_ANALYSIS

 | 210 | POST_ACTRAN_DOMAIN_GROUP

 | 211 | POST_ACTRAN_DOMAIN

 | 212 | POST_ACTRAN_SURFACE_GROUP

 | 213 | POST_ACTRAN_SURFACE

 | 214 | POST_ACTRAN_POINT_GROUP

 | 215 | POST_ACTRAN_POINT

 | 216 | POST_ACTRAN_LOADCASE

 | 218 | POST_GURURI_RESPONSE

 | 219 | POST_GURURI_SWEEP

 | 220 | POST_FFT_CONDITION

 | 221 | POST_FREQ_ANALYSIS_SOLVER

 | 222 | POST_FREQ_LOAD_SOLVER

 | 223 | POST_FREQ_RESPONSE_SOLVER

 | 224 | POST_FREQ_INTERACTIVE_ANALYSIS

 | 225 | POST_MBD_FATIGUE_ANALYSIS

 | 226 | POST_MBD_FATIGUE_RESULT

 | 227 | POST_MBD_FATIGUE_THERMAL_STRESS

 | 228 | POST_MBD_FATIGUE_NODAL_TEMPERATURE

 | 229 | POST_MBD_FATIGUE_PROPERTY

 | 230 | POST_MBD_FATIGUE_CONDITION

 | 231 | CONNECT_LINEARGAP

 | 233 | POST_MBD_FATIGUE_STRESS_RECOVERY

 | 234 | CONTACT_FRONTISTR

 | 235 | POST_ACTRAN_CONTRIBUTION_RESULT_CURVE

 | 236 | POST_MAC_SENSOR

 | 237 | POST_MAC_SENSOR_COLLECTION

 | 238 | POST_SURFACE_DISTANCE

 | 240 | POST_ACOUSTIC_TRANSMISSION_LOSS

 | 241 | POST_ACOUSTIC_TL_PCH_RESULT

 | 242 | POST_ACOUSTIC_TL_CONDITION

 | 243 | POST_ACOUSTIC_TRANSMISSION_LOSS_CONDITION_CURVE

 | 246 | WAON_ANALYSIS_JOB

 | 247 | POST_MAC_DATA

 | 248 | POST_ROUGH_SURF

 | 249 | POST_MAC_FACTOR_CALCULATION

 | 259 | CONTACT_LSDYNA

 | 260 | ADVCPROCESS_RDNLK

 | 261 | WAON_STRUCTURE_MANAGER

 | 262 | WAON_SOUNDSOURCE_MANAGER

 | 263 | WAON_ABSORPTION_MANAGER

 | 264 | POST_FATIGUE_MATERIAL

 | 265 | WAON_FIELDCAL_MANAGER

 | 266 | WAON_TRANSFERFUNC_MANAGER

 | 267 | POST_RESULT_TREE_RENAME

 | 272 | POST_TRANS_ANALYSIS_SOLVER

 | 273 | POST_TRANS_LOAD_SOLVER

 | 274 | POST_TRANS_RESPONSE_SOLVER

 | 275 | LBC_ACCELERATION_LOAD_ACCEL

 | 276 | LBC_ACCELERATION_LOAD_ACCEL1

 | 277 | LBC_ENFORCED_RELATIVE_DISP

 | 283 | LBC_PRETENSION_MSC_NASTRAN

 | 284 | LBC_PRESCRIBED_MOTION

 | 285 | DAMPING_PART_STIFFNESS

 | 286 | CONNECT_RBC

 | 287 | POST_ERP

 | 288 | POST_PLOT_ERP

 | 289 | LBC_COIL

 | 290 | LBC_THERMAL_SHELL_CONVECTION

 | 291 | LBC_EXTERNAL_CURRENT_DENSITY

 | 292 | LBC_MAGNETIC_POTENTIAL

 | 293 | LBC_SURFACE_CURRENT_DENSITY

 | 294 | LBC_ELECTRIC_POTENTIAL

Add new data type Material Types for PSJ material.

Add new data type Material Unit Types for PSJ material.

Add new data types of Material Property for PSJ material

List of newly added data types of Material Property

 | PROPERTY | DESCRIPTION

 | Density | Structure > Density property.

 | Expansion | Structure > Expansion property.

 | Elastic | Structure > Elasticity > Elastic property.

 | HyperElastic | Structure > Elasticity > HyperElastic property.

 | LowDensityFoam | Structure > Elasticity > LowDensityFoam property.

 | ViscoElastic | Structure > Elasticity > ViscoElastic property.

 | Plastic | Structure > Plasticity > Plastic property.

 | Creep | Structure > Plasticity > Creep property.

 | Damping | Structure > Damping property.

 | Viscosity | Structure > Viscosity property.

 | Conductivity | Thermal > Conductivity property.

 | SpecificHeat | Thermal > SpecificHeat property.

 | HeatGenerateRate | Thermal > HeatGenerateRate property.

 | GasketMembraneElastic | Gasket > GasketMembraneElastic property.

 | GasketTransverseElastic | Gasket > GasketTransverseElastic property.

 | GasketThicknessBehavior | Gasket > GasketThicknessBehavior property.

 | GasketAdditionalBehavior | Gasket > GasketAdditionalBehavior property.

 | Resistivity | Electricity > Resistivity property.

 | LimitDiagram | Fatigue > LimitDiagram property.

Add new class type to work with Pre commands

List of newly added class types for Pre commands

 | Parameter Types

 | DCAD_ADVCCONTACTPARAM

 | SHAPE_SEARCH_OPTION

 | TCONTACTTABLEDATA_ADVC

Add new class types to work with Post commands

List of newly added class types for Post commands

 | Parameter Types

 | PEAKHOLD_SUBCASE_MAP

 | POST_CONTOUR_SETTING

 | POST_DATA_VIZ_OPT_ANIMATION

 | POST_DATA_VIZ_OPT_BDPP

 | POST_DATA_VIZ_OPT_CIRCLE

 | POST_DATA_VIZ_OPT_CONTOUR

 | POST_DATA_VIZ_OPT_CROSS_SECTION

 | POST_DATA_VIZ_OPT_DEFORM

 | POST_DATA_VIZ_OPT_DIAGRAM

 | POST_DATA_VIZ_OPT_MAXMIN

 | POST_DATA_VIZ_OPT_TITLE

 | POST_DATA_VIZ_OPT_TRANSPARENCY

 | POST_DATA_VIZ_OPT_VECTOR

 | POST_DATA_VIZ_OPT_VIEWPOINT

 | POST_RESULT_KEY

 | POST_STEP_ITEM

 | POST_TIME_STEP_INFO

 | PRETENSION_LOAD

 | RESULT_LOAD

 | RESULT_VARIABLE

 | SAFETY_ITEM.

PSJ-Utility:

Pre-Utility: Update and add some class types used for pre-processing.

A new attribute is added to DNode to access Local Coordinate assigned to the node.

Add new class type DSubGroup to access Sub Group Data.

Add new class type SubGroupVector to access SubGroup vector.

Add new class type DFieldData to access Field Data.

Add new class type CursorStr to get type and ID directly from a CursorStr.

Post-Utility: Add new classes to work with the response condition: DPostAnalysis, DPostResponse, DPostResultCurve.

⌘ PSJ-Command​

Add various new API commands for both pre-processing and post-processing at ribbons and windows.: Analysis, Assemble,  Assembly, Boundary Conditions, Calculation, Chart, Connections, Groups, Geometry, Home, Main Window, Mesh Cleanup, Mesh Edit, Meshing, Post, Report, Properties, Tools, Preferences.

List of new commands added to Analysis ribbon

 | Pre-Command

 | Analysis.Nastran.DirectFrequencyResponse

List of new commands added to Assemble ribbon

 | Pre-Command

 | Assemble.AddRibEx.Curve

 | Assemble.AddRibEx.FromEdge

 | Assemble.AddRibEx.General

List of new commands added to Assembly window

 | Pre-Command

 | Assembly.RightClick.ChangeEntityEdgeColor

List of new commands added to Boundary Conditions ribbon

 | Pre-Command

 | BoundaryConditions.Radiation

 | BoundaryConditions.ThermalAttributes

 | BoundaryConditions.VirtualFluidMass

List of new commands added to Calculation ribbon

 | Post-Command

 | Calculation.AcousticAnalysis.ACCombinedAnimation

 | Calculation.AcousticAnalysis.AcousticIntensity

 | Calculation.AcousticAnalysis.ActranPltImport

 | Calculation.AcousticAnalysis.PanelContribution

 | Calculation.AcousticAnalysis.TransmissionLoss.PCHResult

 | Calculation.AcousticAnalysis.TransmissionLoss.TransmissionLossCondition

 | Calculation.FFTAnalysis.CircleGraph

 | Calculation.FFTAnalysis.CirclePlot

 | Calculation.FFTAnalysis.CopyCondition

 | Calculation.FFTAnalysis.SectionGraph

 | Calculation.FFTAnalysis.SetCondition

 | 

 | Calculation.FFTAnalysis.XYPlot

 | Calculation.FreqResp.LoadCondition

 | Calculation.FreqResp.LoadCaseCondition

 | Calculation.FreqResp.ResponseCondition

 | Calculation.FreqResp.MPFMCFCalculation.AtFrequency

 | Calculation.FreqResp.MPFMCFCalculation.TotalMPC

 | Calculation.FreqResp.MPFMCFCalculation.SaveMPCResultToCSV

 | Calculation.FreqResp.SaveAnalysis

 | Calculation.FreqResp.OpenAnalysis

 | Calculation.FreqRespSolver.LoadCondition

 | Calculation.FreqRespSolver.ResponseCondition

 | Calculation.Gururi.LoadCase

 | Calculation.Gururi.LoadCondition

 | Calculation.Gururi.Response

 | Calculation.Gururi.Sweep

 | Calculation.RotateMapping

 | Calculation.RotateMappingExportUnv

 | Calculation.PeakSearch

 | Calculation.StrainGauge.AxisWithAngle

 | Calculation.StrainGauge.DirectionCosine

 | Calculation.StrainGauge.ExistingResult

 | Calculation.StrainGauge.MaxMinPrincipal

 | Calculation.StrainGauge.TangentProjection

 | Calculation.StrainGauge.TwoPoints

 | Calculation.Subcase.PeakHold

 | Calculation.Subcase.RelativeOffset

 | Calculation.Subcase.ShowSafety

 | Calculation.SurfaceDistance.DistanceCalculate

 | Calculation.TransResp.LoadCondition

 | Calculation.TransResp.LoadCaseCondition

 | Calculation.TransResp.ResponseCondition

 | Calculation.TransResp.MPFMCFCalculation.AtTime

 | Calculation.TransResp.MPFMCFCalculation.SaveMPCResultToCSV

 | Calculation.TransResp.MPFMCFCalculation.TotalMPC

 | Calculation.TransResp.OpenAnalysis

 | Calculation.TransResp.SaveAnalysis

 | Calculation.TransRespSolver.LoadCondition

 | Calculation.TransRespSolver.ResponseCondition

 | Calculation.UserResult

List of new commands added to Chart ribbon

 | Post-Command

 | Chart.CreateGraph

List of new commands added to Connections ribbon

 | Pre-Command

 | Connections.BoltConnections.AutoBoltConnection

 | Connections.Contacts.ADVC.FindContactPairs

 | Connections.RigidElements.RigidBodyConstraint.Nodes

 | Connections.RigidElements.RigidBodyConstraint.NodesToBody

 | Connections.SolidBoltModeling

List of new commands added to Geometry ribbon

 | Pre-Command

 | Geometry.Face.ExtendFace

 | Geometry.Face.SmoothFace

 | Geometry.Part.Frustum

 | Geometry.ShapeSearch

List of new commands added to Group ribbon

 | Pre-Command

 | Groups.RightClick.ChangeMarkerColor

 | Groups.RightClick.ExportGroup

 | Groups.RightClick.ExportSubGroup

 | Groups.RightClick.ImportGroup

List of new commands added to Home ribbon

 | Pre-Command

 | Home.Home.Preferences.Export

 | Home.Home.Preferences.Import

 | Home.RectangularCapture.Single

 | Home.RectangularCapture.Multiple

 | Home.Windows.FrameCancel

 | Home.Windows.TileVertical

 | Home.Windows.TileHorizontal

 | Home.Windows.TileBox

 | Home.Windows.ViewControl.ChangeMarkerColor

 | Home.Windows.ViewControl.FitToModel

 | Home.Windows.ViewControl.PanDown

 | Home.Windows.ViewControl.PanLeft

 | Home.Windows.ViewControl.PanRight

 | Home.Windows.ViewControl.PanUp

 | Home.Windows.ViewControl.Rotate

 | Home.Windows.ViewControl.SetCenter

 | Home.Windows.ViewControl.ZoomIn

 | Home.Windows.ViewControl.ZoomOut

 | Post-Command

 | Home.AddResults.Abaqus

 | Home.AddResults.Actran

 | Home.AddResults.ADVC

 | Home.AddResults.LSDyna

 | Home.AddResults.MappedMeshResult

 | Home.AddResults.Nastran

 | Home.AddResults.Permas

 | Home.AddResults.Sysnoise

 | Home.AddResults.Universal

 | Home.AddResults.UsersResult

 | Home.ExportGeometrySurface

 | Home.ExportPV

 | Home.ExportResultToTXT

 | Home.ExportVTFx

 | Home.ImportResults.Abaqus

 | Home.ImportResults.ADVC

 | Home.ImportResults.Ansys

 | Home.ImportResults.FrontISTR

 | Home.ImportResults.ImportMesh.Abaqus

 | Home.ImportResults.ImportMesh.ADVC

 | Home.ImportResults.ImportMesh.MappedMeshFile

 | Home.ImportResults.ImportMesh.Nastran

 | Home.ImportResults.LSDyna

 | Home.ImportResults.Marc

 | Home.ImportResults.MuxWeld

 | Home.ImportResults.Nastran

 | Home.ImportResults.OptishapeTS

 | Home.ImportResults.Permas

 | Home.ImportResults.Radioss

 | Home.ImportResults.STDFile

 | Home.ImportResults.SunShineUStar

 | Home.ImportResults.Universal

 | Home.ImportResults.WAON

List of new commands added to Main Window

 | PSJ-Command

 | MainWindow.RightClick.SetPartAppearance

 | MainWindow.RightClick.FlipElement

 | MainWindow.RightClick.InverseHide

 | MainWindow.RightClick.InverseHideAll

 | MainWindow.RightClick.SelectAll

 | MainWindow.RightClick.SelectAllParts

 | MainWindow.RightClick.SelectByAttached

 | MainWindow.RightClick.SelectByFace

 | MainWindow.RightClick.SelectByWindow

 | MainWindow.RightClick.SelectDisplayed

 | MainWindow.RightClick.SelectReverse

 | MainWindow.RightClick.ShowAll

 | MainWindow.RightClick.ShowAllHiddenFaces

 | MainWindow.RightClick.ShowHideAllToolbar

 | MainWindow.RightClick.ShowHideEntity

 | MainWindow.RightClick.ShowHideFlip

 | MainWindow.RightClick.ShowSettings

 | MainWindow.ViewPoint.SetUserViewPoint

List of new commands added to Mesh Cleanup ribbon

 | Pre-Command

 | MeshCleanup.AutoCheck.Quad

 | MeshCleanup.AutoCheck.Tet

 | MeshCleanup.AutoCheck.Tri

 | MeshCleanup.AutoCheck.TriQuad

 | MeshCleanup.Intersection

 | MeshCleanup.FreeEdges

 | MeshCleanup.ManualCheck.Hex

 | MeshCleanup.ManualCheck.Tri

 | MeshCleanup.ManualCheck.Quad

 | MeshCleanup.ManualCheck.Tet

 | MeshCleanup.ManualCheck.TriQuad

List of new commands added to Mesh Edit ribbon

 | Pre-Command

 | MeshEdit.FindDuplicatedNodes

List of new commands added to Meshing ribbon

 | Pre-Command

 | Meshing.LocalSettings.BoltEdge

List of new commands added to Post ribbon

 | Post-Command

 | Post.AreaMaxMin

 | Post.DisplayContour

 | Post.EnableMiddleNodes

 | Post.Note.Element

 | Post.Note.ElementSearchFromPoints

 | Post.Note.Node

 | Post.Note.NodeSearchFromPoints

 | Post.Note.Position

 | Post.Note.SearchPositions

 | Post.NStepsPlotForStrainGauge.AxisWithAngle

 | Post.NStepsPlotForStrainGauge.DirectionCosine

 | Post.NStepsPlotForStrainGauge.MaxMinPrincipal

 | Post.NStepsPlotForStrainGauge.TwoPoints

 | Post.OptimizationToolkit.OptimizedShape

 | Post.OptimizationToolkit.OptimizedShapeSmooth

 | Post.OptimizationToolkit.EnableOptimizationMode

 | Post.OptimizationToolkit.ExportSTLFile

 | Post.PartialContour

 | Post.Plot.DistancePlot

 | Post.Plot.MaxMinPlot

 | Post.Plot.NStepsPlot

 | Post.ResultSettings.Animation

 | Post.ResultSettings.Circle

 | Post.ResultSettings.Contour

 | Post.ResultSettings.Deformation

 | Post.ResultSettings.Diagram

 | Post.ResultSettings.FFT3DDisplay

 | Post.ResultSettings.MaxMin

 | Post.ResultSettings.Opacity

 | Post.ResultSettings.Title

 | Post.ResultSettings.Vector

 | Post.SetNote.ColorBackground

 | Post.SetNote.ColorLine

 | Post.SetNote.ColorText

 | Post.SetNote.ElementMatID

 | Post.SetNote.ElementNodeID

 | Post.SetNote.ElementPropID

 | Post.SetNote.ElementType

 | Post.SetNote.NumericDisplay

 | Post.SetNote.ResultData

 | Post.SetNote.ResultDisp

 | Post.SetNote.ResultElemNodeID

 | Post.SetNote.ResultPos

 | Post.SetNote.ResultPrnVector

 | Post.SetNote.ResultSubID

 | Post.SetNote.ResultTitle

 | Post.SetNote.ResultUnit

 | Post.ShowContour

 | Post.ShowDeformation

 | Post.ShowMaxMin

 | Post.Template.AttachAnimation

 | Post.Template.AttachCircle

 | Post.Template.AttachContour

 | Post.Template.AttachCrossSection

 | Post.Template.AttachDeformation

 | Post.Template.AttachDiagram

 | Post.Template.AttachVector

 | Post.Template.AttachViewPoint

 | Post.Template.Copy

 | Post.Template.Create

 | Post.Template.Delete

 | Post.Template.Export

 | Post.Template.Import

 | Post.Template.Load

 | Post.Template.Update

 | Post.UnloadContour

 | Post.UnloadDeformation

List of new commands added to Report ribbon

 | Post-Command

 | Report.LinearStatic

 | Report.Modal

 | Report.List

 | Report.PPTMultiShots

List of new commands added to Properties ribbon

 | Pre-Command

 | Properties.Material.ImportFromMLIB

List of new commands added to Tools ribbon

 | Pre-Command

 | Tools.DraftAngle

 | Tools.DraftAngleCreateGroup

 | Tools.DraftAngleHideContour

 | Tools.DraftAngleShowContour

 | Tools.Coordinates.ExportCoordinate

 | Tools.Coordinates.ImportCoordinate

 | Tools.Measure.Distance.FaceNode

 | Tools.ToPost

 | Post-Command

 | Tools.ContourCopy

 | Tools.Property

 | Tools.ResultToLoad

 | Tools.ToPre

List of new commands added to Preferences ribbon

 | Pre-Command

 | Home.Preferences.SaveLoad.CalculateTrescaStress

Correct some API command names to match the command names on ribbon.

 List of commands changed

 | Old PSJ-Command Name | New PSJ-Command Name

 | Home.ImportMesh.AbaqusINP | Home.ImportMesh.Abaqus

 | Home.ImportMesh.ADVCADX | Home.ImportMesh.ADVC

 | Home.ImportMesh.AnsysDat | Home.ImportMesh.Ansys

 | Home.ImportMesh.LSDYNA | Home.ImportMesh.LsDyna

 | Home.ImportMesh.NastranBdf | Home.ImportMesh.Nastran

 | Home.RectangularCapture | Home.RectangularCapture.Clipboard

 | Group.RightClick.AddSupGroup | Group.RightClick.AddSubGroup

Some commands are updated the return value as below:

List of commands changed

 | PSJ-Command | Old return value | New return value

 | Connections.RigidElements.RBar.OneToMany | True/False | A Cursor of the created entities

 | Connections.RigidElements.RBar.OneToOne | True/False | A Cursor of the created entities

 | Connections.RigidElements.RBar.OneToOneNodesWithTolerance | True/False | A Cursor of the created entities

 | Connections.RigidElements.RBE2.OneToMany | True/False | A Cursor of the created entities

 | Connections.RigidElements.RBE2.OneToOne | True/False | A Cursor of the created entities

 | Connections.RigidElements.RBE2.OneToOneNodesWithTolerance | True/False | A Cursor of the created entities

 | Connections.RigidElements.RBE2.ToCenter | True/False | A Cursor of the created entities

 | Geometry.Bar.Arc | True/False | A Cursor of the created entities

 | Geometry.Bar.Spline | True/False | A Cursor of the created entities

 | Geometry.Bar.TwoNodes | True/False | A Cursor of the created entities

 | Geometry.Edge.Angle | True/False | A Cursor of the created entities

 | Geometry.Edge.ClosedLine | True/False | A Cursor of the created entities

 | Geometry.Edge.ElementEdges | True/False | A Cursor of the created entities

 | Geometry.Edge.ExtendLine | True/False | A Cursor of the created entities

 | Geometry.Edge.Line | True/False | A Cursor of the created entities

 | Geometry.Edge.NodeShortestPath | True/False | A Cursor of the created entities

 | Geometry.Edge.OffsetLine | True/False | A Cursor of the created entities

 | Geometry.Edge.PerpendicularCylinderLine | True/False | A Cursor of the created entities

 | Geometry.Edge.PerpendicularLineOfEdge | True/False | A Cursor of the created entities

 | Geometry.Edge.PerpendicularLineToEdge | True/False | A Cursor of the created entities

 | Geometry.Edge.PlanarLine | True/False | A Cursor of the created entities

 | Geometry.Edge.ProjectLine | True/False | A Cursor of the created entities

 | Geometry.Edge.Spline | True/False | A Cursor of the created entities

 | Geometry.Face.Edge | True/False | A Cursor of the created entities

 | Geometry.Face.Element | True/False | A Cursor of the created entities

 | Geometry.Face.FourEdges | True/False | A Cursor of the created entities

 | Geometry.Face.FromMesh | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.Absolute | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.Between2Nodes | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.Between3Nodes | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.CenterOfCylinder | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.CenterOfGravity | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.CenterOfSphere | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.CircleCenter | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.Import | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.IntersectionNode | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.Node | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.Offset | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.Point | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.ProjectToLine | True/False | A Cursor of the created entities

 | MeshEdit.CreateNode.ProjectToPlane | True/False | A Cursor of the created entities

To improve consistency and clarity, parameter names were standardized and typos corrected. Some functions also had parameters added or removed to better align with their behavior.

List of commands changed

 | PSJ-Command | Content

 | BoundaryConditions.FieldData | New parameters added: bFrequencyPSDLogX and bFrequencyPSDLogY.

 | Analysis.TSSS.LinearBuckling | A new parameter added:  iRigidMethod.

 | Analysis.TSSS.LinearStatic | A new parameter added: iRigidMethod.

 | Analysis.TSSS.ModalFrequencyResponse | A new parameter added: iRigidMethod.

 | Analysis.TSSS.NonlinearStatic | New parameters added: iRigidMethod, and iLGDISP.

 | Analysis.TSSS.NormalModes | A new parameter added: iRigidMethod.

 | Connection.RBE2.OnetoOne | Renamed parameter: iEnableCheckDulplicate to iEnableCheckDuplicate

 | Connection.RBE2.OneToMany | Renamed parameter: iEnableCheckDulplicate to iEnableCheckDuplicate

 | Connection.RBE2.OneToOneNodesWithTolerance | Renamed parameter: iEnableCheckDulplicate to iEnableCheckDuplicate

 | Connection.RBE2.ToCenter | Renamed parameter: iEnableCheckDulplicate to  iEnableCheckDuplicate

 | Geometry.Transform.Mirror | Renamed parameter: bCopyRef to bCopyReference

 | Geometry.Transform.MatingFace | Renamed parameter: bCopyRef to bCopyReference

 | Geometry.Transform.Rotation | Renamed parameter: bCopyRef to bCopyReference

 | Geometry.Transform.Scaling | Renamed parameter: bCopyRef to bCopyReference

 | Group.RightClick.AddSubGroup | Renamed parameter: crSupGroupSelected to crSubGroupSelected

 | Group.RightClick.ExportSubGroup | Renamed parameter: crlSupGroups to  crlSubGroups

 | Group.RightClick.CopyGroup | Renamed parameter: crSupperGroup to  crSubGroup

 | Home.ImportMesh.Nastran | iImportType extended enables to accept a new option: Read NX-Nastran Comments.

 | MeshEdit.CreateNode.Absolute | Renamed parameters: veclNodeCoord to dlCoordinate, ilNewNodeID to iNewNodeID.

 | MeshEdit.CreateNode.Between2Nodes | Renamed parameters: iNodeID to iNewNodeID, iNumberofNodes to iNumberOfNodes, crFace to crlFaces. Removed parameters: dX,dY,dZ

 | MeshEdit.CreateNode.Between3Nodes | Renamed parameters: iNodeID to iNewNodeID, iNumberofNodes to iNumberOfNodes, crFace to crlFaces. Removed parameters: dX,dY,dZ

 | MeshEdit.CreateNode.CenterOfCylinder | Renamed parameters: iNodeID to iNewNodeID

 | MeshEdit.CreateNode.CenterOfGravity | Renamed parameters: iNodeID to iNewNodeID. Removed parameters: dX,dY,dZ

 | MeshEdit.CreateNode.CenterOfSphere | Renamed parameters: iNodeID to iNewNodeID, crlNodesOrFace to crlTargets.

 | MeshEdit.CreateNode.CircleCenter | Renamed parameters: iNodeID to iNewNodeID.

 | MeshEdit.CreateNode.Import | Renamed parameters: strCSVFilePath to strFilePath

 | MeshEdit.CreateNode.IntersectionNode | Renamed parameters: crlEdges to crEdge.

 | MeshEdit.CreateNode.Offset | Renamed parameters: iRep to iRepeat

 | MeshEdit.CreateNode.Point | Renamed parameters: iNodeID to iNewNodeID,crShape to crTarget.

 | MeshEdit.CreateNode.ProjectToLine | Renamed parameters: crlTa to crlNodes

 | MeshEdit.CreateNode.ProjectToPlane | Renamed parameters: crFace to crlFaces. Removed parameters: dX,dY,dZ

 | MeshEdit.CreateNode.Node | Renamed parameters: veclNodeCoord                        to crTarget

 | Meshing.LocalSettings.Part | New parameters added : bUseNode                          and ilNodeID  .

 | Properties.Section.AddGeneral | Add new argument iDirType to specify the element Y-axis direction.

 | Properties.Shell | Renamed parameters: iTempVaraitation to iTempVariation

 | Tools.Coordinates.Rotate | A new argument posCenterRot is added.

🛠 PSJ-Utility​

📝 API​

It is now possible to concatenate entity lists using the "+" operator.

Current

const_ditem = JPT.GetAllByTypeID(JPT.EntityType.LBC_CONSTRAINT) 
pressure_ditem = JPT.GetAllByTypeID(JPT.EntityType.LBC_G_PRESSURE) 
connect_ditem = JPT.GetAllByTypeID(JPT.EntityType.CONNECT_MPC)

ditem_list = const_ditem + pressure_ditem + connect_ditem

New API commands are added:

List of newly added command

JPT.CastDItemToDSubGroup: Cast DItem to DSubGroup.

JPT.ClearDraw: Clear all the drawings in Main Window.

JPT.ClearMacroLog : Clear all the text existing in the Macro Window.

JPT.ClearOutputLog : Clear all the text existing in the Output Window.

JPT.DrawArrow: Draw an arrow in Main Window.

JPT.DrawLine: Draw a line in Main Window.

JPT.DrawPoint: Draw a point in Main Window.

JPT.DrawRect: Draw a rectangle on Main Window by window coordinate.

JPT.GetAllFieldData : Get all the field data inside a document.

JPT.GetAllLibraryMaterials : Get the material in current library (library data base).

JPT.GetAllMaterials : Get all materials in current document (user data base).

JPT.GetAllPostFreqResponses: Get all Frequency responses.

JPT.GetAllPostFreqResponseSolvers: Get all Frequency responses (Solver).

JPT.GetAllPostGururiResponses: Get all Gururi responses.

JPT.GetAllPostResultCurve: Get all Post result curves.

JPT.GetAllPostTransResponses: Get all Transient responses.

JPT.GetAllPostTransResponseSolvers: Get all Transient responses (Solver).

JPT.GetAllSubGroups : Get all subgroups in current document.

JPT.GetPostSolverType : Get the result type of the current importing result file.

JPT.RunSunShine: Run SunShine to solve an analysis problem.

JPT.SaveToMLIB : Save materials in database to .mlib file.

JPT.ShowMappingData : Show Mapping Display by PSJ

Additionally, some commands are modified as below:

List of commands changed and modified

JPT.GetAssemblyEntityData : Automatically trim whitespaces contained in the retrieved key.

JPT.GetAllNodes, JPT.GetAllElems, JPT.GetAllByTypeID(JPT.DItemType.NODE) : Modified to return a count of 0 when executed on Post documents.

JPT.GetAllPostNodes, JPT.GetAllPostElems, JPT.GetAllByTypeID(JPT.DItemType.POST_NODE) : Modified to return a count of 0 when executed on Pre documents.

📐 PSJ-GUI​

📅 GUI Command Builder​

Add the Enable Drag Row option to enable to drag table rows to upward/downward.

Add the Enable Swap Tab option to swap TabItems in a TabWnd.

Add the Align option to align the text of PageItem.

📏 File Launcher​

The encoding format of registered Python files has been standardized to UTF-8. With the UTF-8 format, wide characters can be read without errors.

An S-JIS encoding option has been added to allow S-JIS files to be read without character corruption.

📝 API​

New API commands are added:

List of newly added commands

dlg.enable_drag_table_row: Set to enable/disable drag table rows to upward/downward.

dlg.enable_tabwnd_swap_tab: Set to enable/disable swap the tab items in a tabwnd.

dlg.enable_table_cell: Set to enable/disable the cell in the table.

dlg.fill_table_by_file: Write data to Table by CSV file.

dlg.on_textbox_input: Bind a created function to a textbox component when its text is changed and validate the textbox data.

dlg.on_activate_selector: Executes a function when a selector is activated.

dlg.activate_selector: Allows programmatic activation of a selector by ID.

Support writing desired labels for 13 selectors by a new argument text.

List of supported selector

dlg.add_1delement_selector

dlg.add_2delement_selector

dlg.add_3delement_selector

dlg.add_vertex_selector

dlg.add_node_selector

dlg.add_edge_selector

dlg.add_elementedge_selector

dlg.add_barpart_selector

dlg.add_face_selector

dlg.add_part_selector

dlg.add_condition_selector

dlg.add_coordinate_selector

dlg.add_group_selector

Additionally, some APIs are modified separately as below:

List of APIs changed and modified

dlg.set_cell_value: enabled to specify the default option on the option list by a new argument index.

add_pagesctrl: enabled to align texts by a new argument text_align.

⚙ Macro​

New macros are added:

List of newly added macros

AddResultsAbaqus : Add Abaqus results to the current Jupiter Database.

AddResultsActran : Add Actran results to the current Jupiter Database.

AddResultsADVC : Add ADVC results to the current Jupiter Database.

AddResultsLSDyna : Add LS-Dyna results to the current Jupiter Database.

AddResultsMappedMeshFile : Add retults written in Mapped Mesh File to the current Jupiter Database.

AddResultsNastran : Add Nastran results to the current Jupiter Database.

AddResultsPermas : Add Permas results to the current Jupiter Database.

AddResultsSysnoise: Add SysNoise results to the current Jupiter Database.

AddResultsUniversal : Add Universal results to the current Jupiter Database.

AddUserResultDefine : Add user defined results to the current Jupiter Database.

Capture_CopyToClipboardTileWindow : Copy tiled image of Main Window to clipboard.

CmdPostAnimationExportMovieToFile: Export movie. This macro is replaced from CmdPostAnimationExportMovie.

CreateGroupDraftAngle: Create the nodal groups for each draft angle.

DRAFT_ANGLE: Measures the draft angle of the mesh in the mold model to verify the draft angle.

ExportPreferenceSettings: Export settings of Preferences (.json file).

HideContourDraftAngle: Hide result contour of Draft Angle function.

ImportAbaqus : Import Abaqus result.

ImportADVC : Import ADVC result.

ImportAnsys : Import Ansys result.

ImportFrontISTR : Import Front ISTR result.

ImportLsDyna : Import LS-Dyna result.

ImportMappedMeshFileDat : Import result written in Mapped Mesh File.

ImportMarc : Import Marc result.

ImportMarcMesh : Import Marc Mesh as a Post document.

ImportMuxWeld : Import MuxWeld result.

ImportNastran  : Import Nastran result.

ImportOptishapeTS : Import Optishape-TS result.

ImportPermas : Import Permas result.

ImportPreferenceSettings: Import settings of Preferences (.json file).

ImportRadioss : Import Radioss result.

ImportSTDFile : Import STD file.

ImportSunShineUStar : Import SunShine (UStar) result.

ImportUniversal : Import Universal result.

ImportUniversalMesh : Import Universal mesh as a Post document.

ShowContourDraftAngle: Display result contour of Draft Angle function.

ViewShowLocalCoordinate: Turn on/off local coordinate display.

Additionally, some macro are modified as below:

List of marcos changed and modified

CmdPostAnimationExportMovie: this macro is replaced with CmdPostAnimationExportMovieToFile. It cannot use from V5.1.

note

For macros that have PSJ Command implementation, when argument updates are made on the PSJ Command side, the macros are updated simultaneously. Therefore, such changes are not listed here. Only macro-specific changes or changes to macros without PSJ implementation are documented in this list.

🚅 Sample​

Add sample Execute *.pyc Files in the PSJ Environment to instruct user how to execute *.pyc files in the PSJ environment.

🐛 Bug Fix​

🗔 Customized Shell​

Support saving PythonAPI.log file to Temp folder when running PSJ script in background mode.

Fixed an issue where, when using multiple monitors, the Python IDE window would open on the incorrect monitor. Now, if Jupiter is moved to a secondary (non-main) monitor and the Python IDE is launched, the IDE window will correctly appear on the same monitor as Jupiter.

⌘ PSJ-Command​

Fix the bug where the copy and cut operations (controlled by argument bEnableCutOperation) are inverted in the Assembly.RightClick.TransferDocumentData command.

Fix the bug where Assembly.RightClick.TransferDocumentData could not copy data under specified sub-assembly.

Fix the bug where the Properties.Shell() sets unnecessary extra data when running the PSJ command.

Fix an intermittent issue where the command BoundaryConditions.InitialTemperature.WholeMapping could cause a freeze when called repeatedly from a Python script.

Fix the bug of the argument name being incorrectly displayed as posVirtualNodePos instead of dlVirtualNodePos in the Connections.RigidElements.RBE3.ToCenter command.

Fixed inconsistency between displayed argument names and actual function parameter names that caused errors when using the displayed names in the Connections.RigidElements.RBE3.ToCenter,  Connections.RigidElements.RBE3.OneToMany  and  Connections.RigidElements.RBE3.OneToOne commands.

Fix the bug where MidPlane.FindMidPlane does not accept any arguments.

Fix the bug where Properties.Section.AddGeneral cannot set Elem Y direction type.

Fix the bug where Properties.Section.ModifyGeneral cannot modify Elem Y direction type.

Fixed a bug where arguments were missing in the macro/PSJ when specifying a floating node as a hard point in the Meshing.LocalSettings.Part command.

Fix the bug of the PSJ commands Geometry.Transform.Scaling, Geometry.Transform.Rotation, Geometry.Transform.Mirror, Geometry.Transform.MatingFace miss 1 argument bCopyReference compare to Macro that cause the problem not display the PSJ command when excecute the function.

Fix the bug of the PSJ command Tools.Coordinates.Rotate misses 1 argument posCenterRot compare to Macro that cause the problem not display the PSJ command when excecute the function.

Fixed a bug where an argument for Tiny Clinder Meshing in Meshing.SurfaceMeshing

Fixed a bug where crCoord could not correctly refer to the local coordinate system when creating an RBar using the Connections.RigidElements.RBar.OneToOne command.

📐 PSJ-GUI​

📝 API​

The issue where some Slider Bar commands did not work has been resolved. The following commands now function properly:

dlg.set_slider_bothtics()

dlg.set_slider_show_border()

dlg.set_slider_show_tics()

dlg.set_slider_vertical()

🛠 PSJ-Utility​

📝 API​

Fix the bug where the vertex attribute of DBody returns an ID of "-1" when querying the vertex information from part; it now correctly returns the proper vertex ID.

The issue where the return value of JPT.MacroListTCursorToListDItem may differ from the expected result has been resolved.

The issue where JPT.MacroListTCursorToListDItem can not correctly find entity in DTABLE_SHAPE has been resolved.

The issue where JPT.SetNameWithAnalysisID could not get result names for User Results has been resolved.

Fix the bug where JPT.GetResultIncrements returns the Result Increment ID incorrectly.

Correct the description of JPT.GetMinResultValue() and JPT.GetMaxResultValue().

Fix the bug where JPT.GetInternalIDRefItem returned 0 when ID duplication occured across different entities.
