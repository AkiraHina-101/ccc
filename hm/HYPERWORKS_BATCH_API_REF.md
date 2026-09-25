# HyperWorks Batch API Reference

Purpose: AI-readable reference for what can be automated in batch mode for
HyperMesh and HyperView/HyperWorks Desktop, especially for Nastran model
control scripts.

This file focuses on observed local install/workspace evidence. It separates
true no-GUI batch work from operations that still need a graphics-capable
HyperWorks session.

Verification status:

```text
OFFICIAL:
  `hw.exe -b`, `hw.exe -tcl`, `hmbatch -tcl`, no-GUI batch behavior, and HWI
  Tcl handle syntax are confirmed by Altair help.

LOCAL-INSTALL:
  HvTrans Tcl command layer, report-batch scripts, `CaptureWindow`,
  `CaptureAnimation AVI`, `CaptureAnimationByAreaPercentage`, and AVI export
  options were found in the installed Altair scripts/configs.

RUNTIME-TEST-NEEDED:
  Viewport capture from true no-GUI batch, direct scripted GIF capture, and
  direct `hvtrans.exe` command-line operation.

See:
  _clean/docs/OFFICIAL_ALTAIR_2022_3_VERIFICATION.md
```

Sources inspected:

```text
<ALTAIR_INSTALL_DIR>/hm/bin/win64/hmbatch.exe
<ALTAIR_INSTALL_DIR>/hw/bin/win64/hmbatch.exe
<ALTAIR_INSTALL_DIR>/hw/bin/win64/hw.exe
<ALTAIR_INSTALL_DIR>/hw/bin/win64/hvp.exe
<ALTAIR_INSTALL_DIR>/hwx/bin/win64/hwx.exe
<ALTAIR_INSTALL_DIR>/hwx/bin/win64/runhwx.exe
<ALTAIR_INSTALL_DIR>/io/result_readers/bin/win64/hvtrans.exe
<ALTAIR_INSTALL_DIR>/io/result_readers/bin/win64/hvtranstcl.dll
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransOpenResult.tcl
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransSaveConfig.tcl
<ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransOpenConfig.tcl
<ALTAIR_INSTALL_DIR>/demos/report/tcl/batch/report_batch.tcl
<ALTAIR_INSTALL_DIR>/mv/scripts/tcl/report/main_batch.tcl
<ALTAIR_INSTALL_DIR>/hst/scripts/python/python3.5/win64/alt/hst/eac/cmd/hstupdate_hwd.tcl
<ALTAIR_INSTALL_DIR>/hst/scripts/python/python3.5/win64/alt/hst/eac/cmd/hstupdate_hv.tcl
<ALTAIR_INSTALL_DIR>/hst/bin/win64/hw_hstbatch.bat
<ALTAIR_INSTALL_DIR>/hm/batchmesh/hw_batchmesh.bat
<ALTAIR_INSTALL_DIR>/hm/scripts/batchmesh/hw_batchmesh.tcl
<ALTAIR_INSTALL_DIR>/hm/batchmesh/NastranOutput.tcl
<ALTAIR_INSTALL_DIR>/hm/batchmesh/PostRunExample.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/br/views/modules/batch/script.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/EngineeringSolutions/Crash/ResultsInitialization/batch/ResultsInitializer.bat
<ALTAIR_INSTALL_DIR>/hm/scripts/hyperform/process_optimizer/incremental/HF_Opti_Incremental_Opti.bat
<ALTAIR_INSTALL_DIR>/io/translators/bin/win64/mdl_batch.bat
<ALTAIR_INSTALL_DIR>/io/translators/bin/win64/fmu_batch.bat
<ALTAIR_INSTALL_DIR>/utility/mdc/batch/MDC.bat
<ALTAIR_INSTALL_DIR>/utility/mdc/batch/MDC_batch.tcl
<ALTAIR_INSTALL_DIR>/utility/mbd/custom_wizards/postprocess_batch.tcl
<ALTAIR_INSTALL_DIR>/utility/scripts/plotting/mit/batch/mit_batch.bat
<ALTAIR_INSTALL_DIR>/utility/scripts/plotting/mit/batch/mit_batch.py
<ALTAIR_INSTALL_DIR>/hm/scripts/HyperStudy/hsimportvariables.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/mvhm/api/mdltoudmconverter.py
_clean/nastran_control.tcl
_clean/docs/API_VERIFIED.md
_clean/docs/GUI_VERIFY_CHECKLIST.md
_ref/Nastran_Control_Tool_codex/HANDOFF.md
```

Related refs:

```text
_clean/docs/HYPERMESH_GUI_API_REF.md
_clean/docs/HYPERMESH_ENTITY_MODEL_API_REF.md
_clean/docs/HYPERMESH_COLOR_RENDER_API_REF.md
_clean/docs/HYPERMESH_PYTHON_EMBEDDING_API_REF.md
_clean/docs/HYPERWORKS_PYTHON_VIEW_CAPTURE_API_REF.md
```

## Bottom Line

HyperMesh batch is strong for model database automation. It can load a model,
scan entities, edit many model/card fields, export CSV/report files, validate
data, run performance probes, and write solver decks without the interactive
table/dialog layer.

HyperView batch is more session-oriented. Installed examples use HWI to load
`.mvw` sessions, inspect HyperView `Animation` clients, query result values,
drive report export, and optionally capture window images. This means many
HyperView workflows can be automated, but graphics capture/view rendering still
depends on having a graphics-capable HyperWorks session.

Result translation is a separate non-viewport route. `hvtrans` can read result
metadata, select subcases/data types/layers/components, save/load configs, and
translate to H3D-style output without being the same thing as HyperView camera
capture.

Batch is not a replacement for GUI widget testing. Dialogs, `tktable`, `hwtk`
visual behavior, viewport capture, and manual panels must either be bypassed or
run in HyperMesh/HyperView GUI.

## Executables

Observed relevant executables:

```text
HyperMesh batch:
  <ALTAIR_INSTALL_DIR>/hm/bin/win64/hmbatch.exe
  <ALTAIR_INSTALL_DIR>/hw/bin/win64/hmbatch.exe

HyperWorks Desktop / HyperView session:
  <ALTAIR_INSTALL_DIR>/hw/bin/win64/hw.exe
  <ALTAIR_INSTALL_DIR>/hw/bin/win64/hvp.exe

HWX profile shell:
  <ALTAIR_INSTALL_DIR>/hwx/bin/win64/hwx.exe
  <ALTAIR_INSTALL_DIR>/hwx/bin/win64/runhwx.exe

HyperView/result translation:
  <ALTAIR_INSTALL_DIR>/io/result_readers/bin/win64/hvtrans.exe
  <ALTAIR_INSTALL_DIR>/io/result_readers/bin/win64/hvtranstcl.dll

HyperStudy batch wrapper:
  <ALTAIR_INSTALL_DIR>/hst/bin/win64/hw_hstbatch.bat
  <ALTAIR_INSTALL_DIR>/hst/bin/win64/hstbatch.exe
```

Typical verified Tcl launch shape:

```powershell
& "<ALTAIR_INSTALL_DIR>\hm\bin\win64\hmbatch.exe" -tcl "script.tcl"
```

In scripts launched this way, command-line arguments are visible through Tcl
`argv`. Some installed scripts assume their mode arguments start at later argv
positions because `-tcl` and the script path are included before user arguments.

## Launch Patterns

Observed launch families:

```text
HyperMesh no-command Tcl batch:
  hmbatch.exe -nobg -nocommand -tcl script.tcl

HyperMesh Tcl batch:
  hmbatch.exe -tcl script.tcl
  hmbatch.exe -b -wait -tcl script.tcl args...

HyperMesh command-file batch:
  hmopengl.exe -batchmesher -noconsole -c<command.cmf>
  hmopengl.exe -batch -noconsole -c<command.cmf>

HyperWorks Desktop post client:
  hw.exe /clientconfig hwpost.dat -b -tcl script.tcl

HyperGraph/plot client:
  hw.exe /clientconfig hwplot.dat -b -ql -tcl script.tcl
  hw.exe /clientconfig hwplot.dat -tcl script.tcl

MotionView/model client:
  hw.exe -clientconfig hwmbdmodel.dat -b -tcl script.tcl
  hw.exe -clientconfig hwmbdmodel.dat -b -wait -tcl script.tcl

FE pre client:
  hw.exe -clientconfig hwfepre.dat -nouserprofiledialog -tcl script.tcl

HWX HyperWorks Post profile:
  runhwx.exe -client HyperWorksDesktop -plugin HyperworksPost -profile HyperworksPost -clientconfig hwpost.dat

Report/ARD batch:
  hw.exe -tcl main_batch.tcl -tplFile template.tpl -outputFileName report.docx -tplParams ...

HyperStudy batch:
  hw_hstbatch.bat ...
```

Observed option meanings from installed scripts:

```text
-tcl <file>              load and execute Tcl file.
-b                       batch/background mode for hw.exe workflows.
-wait                    keep caller waiting until the process/script exits.
-ql                      quiet launch in several hw.exe scripts.
-nobg                    foreground/no-background variant, mostly Linux or HM batch wrappers.
-nocommand               suppress interactive command window/prompt behavior in HM workflows.
-noexit                  keep HyperWorks open after script execution.
-nouserprofiledialog     avoid user profile dialog in HyperStudy/FE-pre integration.
-clientconfig <dat>      select Desktop client/profile: hwpost, hwplot, hwmbdmodel, hwfepre.
-c<file.cmf>             execute a HyperMesh command file.
-batchmesher             specialized HM/BatchMesher mode.
```

Practical rule:

```text
Use hmbatch for HM database/model scripts.
Use hw.exe + clientconfig when the script needs a Desktop client such as Post, Plot, MotionView, or FE-pre.
Use runhwx/hwx for newer HWX profile loading, not for classic hmbatch model mutation.
Use hvtrans for result/model translation to H3D/config without viewport rendering.
Use hstbatch/hw_hstbatch only for HyperStudy orchestration, not direct HM/HV GUI APIs.
```

## HyperMesh Batch Capability

Strong batch use cases:

```text
Load/import/save model files
Read entity lists and metadata
Read components/properties/materials/sets/parameters/shapes
Read Nastran card image and card fields when solver template/profile is loaded
Mutate supported model fields
Create/duplicate/delete supported entities
Apply morph shapes/parameters in automated workflows
Export solver deck with template commands
Export/import CSV
Validate entity relationships and material/property warnings
Generate audit/report CSVs
Run performance probes and regression smoke tests
Batch meshing through Altair batchmesh scripts
```

Observed APIs used successfully or intended for batch-safe logic:

```tcl
hm_info hmfilename
hm_info -appinfo ALTAIR_HOME
hm_gethmfileuserprofile $hm_filename

hm_createmark parameters 1 "advanced" "all"
hm_createmark shapes 1 "advanced" "all"
hm_getmark parameters 1
hm_getmark shapes 1

hm_getvalue comps id=$id dataname=...
hm_getvalue props id=$id dataname=...
hm_getvalue mats  id=$id dataname=...
hm_getentityvalue parameters "$name" "id" 0 -byname
hm_getentityvalue parameters $id "type" 0 -byid
hm_getentityvalue parameters $id "name" 1 -byid
hm_getentityvalue shapes "$name" "id" 0 -byname

*setvalue parameters id=$id valuedouble=$value
*createmark shapes 1 $shape_name
*morphshapeapply shapes 1 $value
*morphdoshape 3

*createstringarray 1 "HM_NODEELEMS_SET_COMPRESS_SKIP "
hm_answernext yes
*feoutputwithdata "$templateFile" "$outputDeck" 0 0 1 1 1
```

For this project, hmbatch has already been used as the guardrail for:

```text
batch_action=export
batch_action=validate
batch_action=capture smoke of session logic
validation_general.csv
validation_component.csv
validation_properties.csv
validation_materials.csv
validation_summary.csv
material_audit.csv
material_attribute_audit.csv
schema probes on full models
performance probes on model scan/cache paths
```

Important behavior from workspace probes:

```text
Batch export refuses to overwrite CSVs when no model entities are loaded.
Batch validate refuses to write empty reports when no model entities are loaded.
Batch validate writes reports when a model is loaded.
Batch capture can test path/session logic, but captures zero images if graphics APIs are unavailable.
```

## HyperMesh BatchMesher

BatchMesher is a separate production-style batch framework, not just a simple
`hmbatch -tcl` script.

Wrapper:

```text
<ALTAIR_INSTALL_DIR>/hm/batchmesh/hw_batchmesh.bat
```

The wrapper sets:

```text
ALTAIR_TCL_EXEC = hw/tcl/tcl8.5.9/.../tclsh85t.exe
HMBATCH_EXEC    = hw/bin/win64/hmopengl.exe
BATCHMESH_TCL_SCRIPT = hm/scripts/batchmesh/hw_batchmesh.tcl
```

No-GUI mode launches the Tcl coordinator:

```text
hw_batchmesh.bat -nogui ...
  -> tclsh85t.exe hm/scripts/batchmesh/hw_batchmesh.tcl ...
```

The coordinator writes a HyperMesh command file and starts HM:

```text
hmopengl.exe -batchmesher -noconsole -c<generated.cmf>
```

The generated command file uses macro/Tcl bridge commands such as:

```tcl
*evaltclstring("::hmbm::SetGlobalArgs ...",0)
*evaltclstring("::hmbm::RegisterUserProc PRE_BATCHMESH ...",0)
*evaltclstring("::hmbm::BatchMesh {$geomFile} $fileType {$critFile} {$paramFile}",0)
```

No-GUI BatchMesher options observed:

```text
-nogui
-cad_model_file <path>
-cad_model_dir <directory>
-cad_model_ext <extension>
-cad_translator <type>
-cad_import_opt <import_options>
-criteria_file <path>
-param_file <path>
-work_dir <path>
-recurse <true|false>
-qi_post_procedure <true|false>
-run_results <path>
-run_tcl_file <path>
-run_tcl_proc <proc>
-run_tcl_param <args>
-timeout_scale <scale>
-time_limit_default <minutes>
-file_wait_timeout <minutes>
-total_timeout <minutes>
-user_procedure <type> <path> <proc> <args>
-relocate_to_input <1|0|true|false|yes|no>
-finalmodelname <name>
-with_fe_geometry <value>
-args_file <path>
```

Supported CAD/model translator names from config include:

```text
acis, aveva, catia, catiav6, ct-ug, dxf, foran, hm, iges, intergraph,
jt, ocx, pdgs, parasolid-parasolid, proe, rhino, step, solidworks, ug,
vdafs, inventor, inspire, Detect
```

User hook points:

```text
PRE_GEOMETRY_LOAD
POST_GEOMETRY_LOAD
PRE_BATCHMESH
QI_BATCHMESH
POST_BATCHMESH
POST_RUN
```

BatchMesher has robust supervision:

```text
checks required files and environment variables
creates per-run result/log files
watches `time_limit.txt`, `batchres.txt`, `LOG_FILE`, `HMBMDONE`
detects license errors, crashes, hangs, frozen message-box-like states
can retry failed HM runs up to a configured iteration count
can run multiple criteria/parameter pairs in sequence
can recurse input directories and create work subfolders
```

Nastran output hook:

```tcl
set template_dir [hm_info -appinfo SPECIFIEDPATH TEMPLATES_DIR]
set template [file join $template_dir "feoutput" "nastran" "general"]
*feoutputwithdata "$template" ${modelName}.dat 0 0 1 1 0
```

Meaning for this project:

```text
BatchMesher is useful as a reference for robust batch orchestration and solver-deck export.
Its generated `.cmf` pattern is useful when a workflow must drive macro commands, not only pure Tcl.
Its watchdog/retry/log approach is worth copying for long model scans or capture queues.
It is not needed for ordinary component/property/material CSV edits unless meshing/CAD import is part of the task.
```

## HyperMesh Batch Limits

These are poor batch targets:

```text
Tk/hwtk dialog rendering
tktable visual layout, manual resize, cell image drawing
interactive HyperMesh panels and mouse selections
macro page include commands as Tcl commands
viewport screenshots in a no-graphics hmbatch process
manual confirmation dialogs
```

Specific cautions observed:

```text
*includemacrofile is macro-page syntax, not normal Tcl batch syntax.
hm_getcardimagename/card field probing can return empty data if no solver template/profile is loaded.
hwi was unavailable in the tested hmbatch environment for capture, so HWI graphics capture failed there.
hmbatch may hit Altair LM-X lock-file errors if another process holds license/client locks.
Some win64 hmbatch stdout/stderr behavior can be unreliable; installed scripts log to files as a workaround.
```

HyperStudy/FE-pre integration adds another caution:

```text
hw.exe -clientconfig hwfepre.dat -nouserprofiledialog -tcl script.tcl
```

The inspected HyperStudy script notes that passing command-line arguments after
`hw.exe -tcl file.tcl myarg...` did not work reliably there. It passes task data
through environment variables such as `HST_TASK_INPUT` and XML files instead.

For robust batch APIs, prefer one of:

```text
environment variable -> XML/JSON/Tcl reads file
argv -> only after verifying index/quoting in the target launch mode
args_file -> one argument file parsed by the script
session/output directory convention -> stable file names
```

Batch-friendly script design:

```tcl
set ::batch_mode 1
set ::batch_action export
set ::batch_dir "C:/path/to/session"
set ::batch_log "C:/path/to/log.txt"
source "tool_entry.tcl"
```

Recommended design rules:

```text
Use argv/env/namespace variables for inputs.
Never require a modal dialog in batch.
Guard every file write against no-model/no-entity state.
Log to files as well as stdout.
Keep GUI widget creation behind a no-GUI fallback.
Use marks/IDs/files instead of interactive selection panels.
Load the correct solver template/profile before card-field probing.
Treat viewport/capture output as graphics-session-only until verified.
```

## HyperView Batch Capability

HyperView automation in the inspected install is mostly HWI/session based.
The basic handle chain is:

```tcl
hwi OpenStack
hwi GetSessionHandle sessionHandle
sessionHandle LoadSessionFile $mvwFile false
sessionHandle GetProjectHandle projectHandle
projectHandle GetPageHandle pageHandle $pageIndex
pageHandle GetWindowHandle windowHandle $windowIndex
set clientType [$windowHandle GetClientType]
if {$clientType eq "Animation"} {
    set clientHandle [$windowHandle GetClientHandle clientHandle]
}
hwi CloseStack
```

No dedicated `hvbatch.exe` was found in the inspected install tree. HyperView
automation routes observed are:

```text
hw.exe /clientconfig hwpost.dat -b -tcl <script>
hw.exe -tcl <report/session script>
runhwx.exe -client HyperWorksDesktop -plugin HyperworksPost -profile HyperworksPost ...
hvtrans command layer for result translation
```

Observed HyperView batch/session APIs:

```tcl
sessionHandle LoadSessionFile $mvwFile false
sessionHandle CaptureWindow $zeroBasedWindow jpeg output.jpeg pixels 1280 960
sessionHandle CaptureScreen PNG $fileName
sessionHandle CaptureAnimation AVI $aviFile
sessionHandle CaptureAnimationByAreaPercentage AVI $aviFile $x $y $w $h
sessionHandle GetAVIExportOptionsHandle aviOptions
sessionHandle GetSystemVariable VERSION
sessionHandle GetClientManagerHandle clientManagerHandle Animation

projectHandle GetNumberOfPages
projectHandle GetPageHandle pageHandle $page
projectHandle SetActivePage $page

pageHandle GetNumberOfWindows
pageHandle GetWindowHandle windowHandle $window

windowHandle GetClientType
windowHandle SetClientType Animation
windowHandle GetClientHandle clientHandle

clientManagerHandle GetResultMathState
clientManagerHandle SetResultMathState true
clientManagerHandle GetResultMathTemplate
clientManagerHandle SetResultMathTemplate "MDC"

clientHandle GetAdvancedQueryList
clientHandle GetAdvancedQueryHandle queryHandle $queryId
queryHandle GetLabel
queryHandle SetNumericFormat "fixed"
queryHandle SetNumericPrecision 12
queryHandle SetQuery "entity.value"
queryHandle GetValueList

clientHandle GetModelHandle modelHandle [clientHandle GetActiveModel]
clientHandle RemoveAllModels
clientHandle AddResultMathAnalysis "MDC" "$modelFile" "$resultFile"
modelHandle GetFileName
modelHandle GetSelectionSetList
modelHandle GetSelectionSetHandle setHandle $setId
modelHandle GetResultCtrlHandle resultHandle

resultHandle GetContourCtrlHandle contourHandle
resultHandle GetNumberOfSimulations $subcaseId
resultHandle GetSimulationList $subcaseId
resultHandle SetCurrentSimulation $simulationIndex
resultHandle GetCurrentSubcase
resultHandle GetSubcaseLabel $subcaseId
resultHandle GetDataTypeBinding $subcaseId $dataType

contourHandle GetDataType
contourHandle GetDataComponent
contourHandle GetCornerDataEnabled
contourHandle GetAverageMode
contourHandle GetValueList $selectionSetId

::post::Draw $overlay
```

Animation/capture notes from installed scripts:

```tcl
hwi GetSessionHandle sess
sess GetAVIExportOptionsHandle aviopt
aviopt SetFrameRate $fps
sess CaptureAnimation AVI $aviFile
```

Direct AVI capture is the best locally evidenced script route. GUI/report/test
metadata includes GIF as an animation format, but inspected production-style Tcl
uses AVI and the inspected animation test stub does not implement GIF generation.
For robust automation, capture PNG frames or AVI first, then build GIF outside
HyperView unless direct `CaptureAnimation GIF` is verified on the target
machine.

For area animation capture, installed scripts schedule capture with `after idle`
because immediate capture can interfere with drawing. Apply the same idea to
large mode-shape scripts: set mode/frame/view, call Draw, let the UI idle if
needed, then capture.

This supports:

```text
Load a HyperWorks `.mvw` session.
Find pages/windows that contain HyperView/Animation clients.
Find advanced queries/hotspots.
Extract entity-value query results.
Extract contour result values for selection sets.
Loop subcases/simulations.
Set active window/client to Animation.
Enable Result Math and choose a result math template.
Add model/result analyses to the active Animation client.
Write response XML/HSTP files for optimization/report workflows.
Capture a window image when the session has graphics support.
```

The HyperStudy bridge example uses modes:

```text
hstupdate_hwd.tcl:
  -q  query HyperMesh variables and HyperView responses from a session
  -w  write parameter/shape values back and export a solver deck
  -e  extract HyperView response values

hstupdate_hv.tcl:
  -import   read HyperView advanced queries from a `.mvw`
  -execute  evaluate saved queries from a `.mvw`
  -image    additionally capture JPEG images with CaptureWindow
```

## HyperWorks Desktop Client Batch

Many installed batch workflows use `hw.exe` with a selected client profile.
This is the practical route when a script needs HyperView, HyperGraph, MotionView,
or FE-pre handles rather than only the HyperMesh database.

Observed profile launches:

```text
Post / HyperView:
  hw.exe /clientconfig hwpost.dat -b -tcl script.tcl

Plot / HyperGraph:
  hw.exe /clientconfig hwplot.dat -b -ql -tcl script.tcl
  hw.exe /clientconfig hwplot.dat -tcl script.tcl

MotionView/model:
  hw.exe -clientconfig hwmbdmodel.dat -b -tcl script.tcl
  hw.exe -clientconfig hwmbdmodel.dat -b -wait -tcl script.tcl

FE-pre:
  hw.exe -clientconfig hwfepre.dat -nouserprofiledialog -tcl script.tcl
```

Observed workflows:

```text
HF_Opti_Incremental_Opti.bat:
  runs hmbatch when the input is `.tcl`
  runs a solver for `.rad`/`.key`
  then launches `hw.exe /clientconfig hwpost.dat -b -tcl <post_script>`

mdl_batch.bat:
  launches MotionView model export through `hwmbdmodel.dat`
  supports solver names such as MotionSolve, ADAMS, ABAQUS
  supports options like -ANALYSIS, -SCRIPT, -CHECKMODEL, -OPTIMIZE

fmu_batch.bat:
  launches `utility/mbd/fmu/fmu_batch.tcl` through `hwmbdmodel.dat`

MDC.bat/MDC_batch.tcl:
  launches `hw.exe -b -tcl MDC_batch.tcl`
  switches active window to `Animation`
  enables result math template `MDC`
  loads model/result files
  computes criteria
  exports CSV and captures images

MIT batch:
  Python builds XML input, then calls `hw.exe /clientconfig hwplot.dat -b -ql -tcl TriggerMITBatch.tbc`
  reads MIT_ReturnCode.txt for the final status
```

Desktop-client batch can do more graphics/result work than `hmbatch`, but it is
still not the same as pure headless computation. If a script calls `Draw`,
`CaptureWindow`, `CaptureScreen`, `CaptureImage`, or export-preview logic, test
it in the exact target environment.

## Additional Installed Batch Workflows

The install tree contains several internal batch-style workflows that are useful
as references for robust automation patterns.

Modular Modeling / BOM batch:

```text
hm/scripts/br/views/modules/batch/script.tcl
  launch: hmbatch.exe -tcl script.tcl <bom file> ?-option value? ...
  options:
    -blShowBMUI
    -blSaveMonolithic
    -blExportSubsystem
    -blImportSubsystem
    -blSaveToLibrary
    -blSyncMetadataToPDM
    -createRepresentations
    -exportFile
    -fileType
    -logFile
    -parts
  operations:
    BOMImport "Auto Detect" <file> "Child"
    Representations:Create <parts> <representation names>
    BOMExport <fileType> <exportFile>
```

Internal deck/geometry/material parsers:

```text
hw/tcl/hweDataMgr/profiles/cae/CaeParsers1.0/*
hw/tcl/hweDataMgr/profiles/mat/MatParsers1.0/*
hw/hwe/config/udm/librarymanager/hsmParsers/*
hm/scripts/hwct/matlib/parsers/MatParsers1.0/*
```

These parsers launch `hmbatch` from a parent Desktop/Data Manager process:

```tcl
set hmbatch_args [GetHMBatchArgs]
exec "$hmExe" {*}$hmbatch_args -tcl "$script" "$filen" "$FE_type" "$tmpFile" ...
```

Practical meaning: Altair itself uses `hmbatch` as a background parser for
solver decks, geometry files, material decks, and library previews. This is good
evidence that `hmbatch` is the right primitive for non-visual model/file
extraction, provided the script writes explicit result files and does not depend
on a live widget.

HyperStudy batch wrapper:

```text
hst/bin/win64/hw_hstbatch.bat
  sets ALTAIR_HOME/HW_ROOTDIR/HW_BIN_DIR
  prepends hw/bin/win64 and hwx/bin/win64 to PATH
  launches hst/bin/win64/hstbatch.exe %*
```

This belongs to study orchestration. It can drive study runs around HM/HV tasks,
but it is not itself the API layer for editing HyperMesh entities or rendering
HyperView windows.

`hvp.exe` observation:

```text
Observed uses are registration/player style workflows such as /register,
/unregister, or file association/viewer launch. The inspected scripts did not
show `hvp.exe` as the primary batch scripting route for HyperView automation.
Use `hw.exe /clientconfig hwpost.dat -b -tcl ...` or `hvtrans` instead.
```

## HVTrans Result Translation Batch

`hvtrans.exe` and `hvtranstcl.dll` expose a separate result/model translation
layer used by HyperView's HvTrans GUI. It is not a viewport renderer. It is a
batch-relevant API for reading result/model metadata, selecting result content,
saving/loading translation configs, and exporting translated output such as H3D.

Observed GUI/menu entrypoints:

```text
Run HvTrans menu command: tcl: ::hw::RunHVTrans
Application finder command: ::hw::RunHVTrans
```

Core control commands observed:

```tcl
hvtrans control GetResultReaders $resultFile
hvtrans control SetResultReader $reader
hvtrans control GetModelReaders $modelFile
hvtrans control SetModelReader $reader
hvtrans control SetResultFile $resultFile
hvtrans control LoadResults
hvtrans control SetModelFile $modelFile
hvtrans control LoadModel
hvtrans control SetOutputFile $h3dFile
hvtrans control StartTranslation
hvtrans control SetConfigFile $cfgFile
hvtrans control LoadConfig
hvtrans control SaveConfig
hvtrans control SetCompressionLevel 7
hvtrans control SetCompressionTolerance $tol
hvtrans control SetCallback progress ::callback
hvtrans control SetCallback errormsg ::errorCallback
hvtrans control GetSystemVariables
hvtrans control GetResultFilters
```

Result inspection commands observed:

```tcl
hvtrans result GetSubcases
hvtrans result GetSubcaseLabel $subcaseId
hvtrans result GetSubcaseType $subcaseId
hvtrans result GetSimulations $subcaseId
hvtrans result GetDataTypes $subcaseId
hvtrans result GetDataTypeCorners $subcaseId $dataType
hvtrans result GetDataTypeLayers $subcaseId $dataType
hvtrans result GetDataTypeComponents $subcaseId $dataType
hvtrans result GetDataTypePools $subcaseId $dataType
hvtrans result GetDataTypeFormat $subcaseId $dataType
hvtrans result GetDataTypeBinding $subcaseId $dataType
```

Model/config/request commands observed:

```tcl
hvtrans model GetPools PARTS
hvtrans model GetParts $pool

hvtrans config Reset
hvtrans config AddItem Parts
hvtrans config AddItem Parts/Pool<$pool>/$partId
hvtrans config AddItem Subcase<$id>/Simulation<$simulation>/(All)
hvtrans config AddItem Subcase<$id>/Simulation<$simulation>/$dataType
hvtrans config AddItem Subcase<$id>/Simulation<$simulation>/{$dataType$separator(corners)}
hvtrans config AddItem Subcase<$id>/Simulation<$simulation>/"$dataType$separator$shellLayer"
hvtrans config AddItem Subcase<$id>/Simulation<$simulation>/"$dataType$separator$component"
hvtrans config AddItem "Config<H3D>/options<1>"
hvtrans config ListItems
hvtrans config GetItemValue $path

hvtrans request GetTypes $subcaseId $request
hvtrans request GetLayers $subcaseId $request
hvtrans request GetComponents $subcaseId $request
```

Practical batch capabilities:

```text
Load a result file and pick a reader.
Optionally load a model file and pick a model reader.
List subcases, simulation steps, result data types, layers, components, pools,
corner availability, data binding, and data format.
Select all result content or specific subsets through config AddItem paths.
Save a reusable translation config file.
Load a translation config file and validate it against available result content.
Export/translate selected content to an output file such as H3D.
Set compression level/tolerance.
Capture progress and error messages through callbacks.
```

The installed GUI's `Translate...` button calls the same engine:

```tcl
::post::HvTrans::saveProc
hvtrans control SetOutputFile $saveH3DFName
hvtrans control StartTranslation
```

This means a custom no-dialog batch wrapper can follow the same order after a
GUI-proven config exists: set readers/files, load result metadata, load model if
needed, load or build config items, set output path, then call
`StartTranslation`.

Headless caution:

```text
The installed HvTrans Tcl files are GUI-backed and contain file dialogs,
tree widgets, checkbuttons, and message boxes. The useful batch layer is the
underlying `hvtrans ...` command set. For no-GUI automation, write a custom Tcl
wrapper that supplies explicit file paths, readers, config items, output path,
and callbacks; do not reuse GUI procedures that call hwt dialogs.
```

For Nastran/OptiStruct result automation, `hvtrans` is a good candidate when the
goal is "convert or inspect result content" rather than "show a viewport and
capture a camera angle".

## HyperWorks Report Batch

The installed report batch demo starts the ARD/report framework in mute mode:

```tcl
package require ardapi
package require hwtk
::ardi::frwk start -mode mute -name _hwreport
```

It parses command-line options:

```tcl
hwtk::parseargs {-tcl "" -tpl "" -mvw "" -filelist "" -opt "export" -outputfile ""} $cmdargs -merge 1
```

Then it can:

```tcl
::ard::api_exports_impl::loadmvw -file $mvwfile
::ardi::frwk loadtemplate -file $tplfile
::ardi::frwk loadtemplate -file $tplfile -filelist $filelist
::ardi::frwk execute
::ardi::frwk sync
::ardi::frwk export -file $outputfile
```

Another installed ARD batch entry accepts explicit template/output arguments:

```text
hw.exe -tcl mv/scripts/tcl/report/main_batch.tcl \
  -tplFile <template.tpl> \
  -outputFileName <output.docx|output.pptx> \
  -masterDocument <master template> \
  -workingDir <folder> \
  -tplParams <param/file1> <param/file2> ...
```

That script disables the report GUI when `-b` is present, sources the report
framework, parses arguments after `-tcl`, and runs:

```tcl
ardapp batchRun $tplFile $outputFileName $tplParams 0 $masterDocument $workingDir
```

Related report item APIs from demos include:

```tcl
::ardi::item::text create
::ardi::item::image create -config "HWCaptureImage"
::ardi::item::image create -config "ArdImageFromFile"
::ardi::item::table create
::ardi::item::table set
::ardi::item::table setheader
::ardi::item::table setcell
::ardi::item::slide create
::ardi::item::chapter create
::ardi::item apply
```

Practical meaning: report generation can be batch-driven from template/session
data, including tables and images. Image capture items that use
`HWCaptureImage` still depend on a valid HyperWorks graphics/session state.
Image-from-file items are safer for pure batch report assembly.

## Python In Batch

Python can participate in batch workflows in two ways:

```text
1. Tcl hmbatch loads embedded Python with `package require Python`, then calls
   `python::eval`, `python::exec`, or `python::execfile`.
2. Python launched inside HyperWorks uses `Tclinter.tcl.call/eval` to call the
   same Tcl/HM/HWI APIs.
```

Batch-safe Python roles:

```text
CSV/Excel parsing and normalization
large table/data transforms
JSON/XML/report generation
numeric preprocessing
file path/session orchestration
calling Tcl procs that perform verified model reads/writes
```

Riskier Python roles:

```text
direct unverified HyperMesh entity mutation through guessed Python objects
GUI widget creation in a no-GUI batch run
viewport capture in hmbatch without graphics/HWI availability
```

Recommended pattern:

```tcl
package require Python
python::execfile "prepare_data.py"
set csv_path [python::eval "make_batch_csv(...)"]
source "verified_hm_mutation_layer.tcl"
::tool::batch_import_csv $csv_path
```

Or from embedded Python:

```python
import Tclinter
Tclinter.tcl.eval('source "verified_hm_mutation_layer.tcl"')
Tclinter.tcl.call('::tool::batch_validate')
```

## Capture And Render In Batch

Use this decision table:

```text
Task                                  hmbatch no-GUI     hw.exe client batch     GUI/graphics session
------------------------------------  ----------------  ----------------------  --------------------
Scan model and generate file paths    good              good                    good
Isolate/display component logically   partial           client-dependent        good
HyperMesh native JPEG capture         not reliable      client-dependent        good after verification
HWI CaptureScreen/ToSize              no in tested HM    client-dependent        good
HyperView CaptureWindow               no                needs graphics          good
HvTrans result translation            no                separate hvtrans route  GUI wrapper exists
Report image from existing file       good              good                    good
Report image from HW viewport         no                needs graphics          good
```

For reliable automated images:

```text
Use GUI/graphics HyperMesh or HyperView session for viewport capture.
Use hmbatch to prepare lists, session folders, validation, and metadata.
For reports, prefer already-captured image files in pure batch.
Use ARD `HWCaptureImage` only when the loaded session/window can render.
```

## Practical Capability Matrix

```text
Area                         HyperMesh hmbatch             hw.exe client batch                 GUI/graphics session
---------------------------  -----------------------------  ----------------------------------  --------------------
Open model/session           yes                            yes, profile-dependent              yes
Read component/property/mat  yes                            yes in FE-pre/HM contexts           yes
Edit component/property/mat  yes, when field API verified   possible in FE-pre/HM contexts      yes
Read Nastran card fields     yes, with template/profile     possible in FE-pre/HM contexts      yes
Export solver deck           yes                            yes in linked HM/HWD workflows      yes
BatchMesh/CAD import         yes through BatchMesher        not primary route                   GUI BatchMesher
Run validation/audits        yes                            yes for result/model workflows      yes
CSV/report data files        yes                            yes                                 yes
Report generation            limited direct, good via ARD   yes via ARD/report framework        yes
Result translation/H3D       not primary route              yes via hvtrans or Post workflows   yes via HvTrans GUI
List result subcases/types   no                             yes via hvtrans/HWI                 yes
Query result contour values  no, unless in HWD session      yes in Post/Animation client        yes
Plot/curve batch             no                             yes via hwplot.dat                  yes
MotionView model export      no                             yes via hwmbdmodel.dat              yes
Capture viewport image       not reliable no-GUI            needs graphics/client support       yes
GUI dialogs/buttons/tables   no                             only if launched as UI/noexit       yes
HyperStudy orchestration     indirect                       yes through hstbatch wrappers       yes
Regression smoke tests       yes                            yes if session dependencies exist   yes
```

## For Nastran Control Tool

Best division of labor:

```text
hmbatch:
  scan model
  export/import CSV
  validate component/property/material links
  audit raw card fields
  run schema/performance probes
  apply safe model edits by ID
  export solver decks

HyperMesh GUI:
  table UX
  buttons/checkboxes/dialogs
  manual preview/confirm
  viewport isolate/display/capture
  visual verification

HyperView/HyperWorks session:
  load `.mvw`
  run `hw.exe -clientconfig hwpost.dat/hwplot.dat/hwmbdmodel.dat`
  query result values
  manipulate result display/view
  capture images from result windows
  generate Word/PPT reports through ARD
```

Implementation checklist for any new batch command:

```text
Define explicit `batch_action`.
Validate model/session exists before writes.
Validate entity count before export/validate output.
Keep all output inside a requested session/output directory.
Log command arguments and summary counts.
Return nonzero/error text on missing model, missing template, unsupported field, or capture unavailable.
Keep GUI-only callbacks callable only through GUI buttons.
Mirror every model mutation with a no-mutation validate/dry-run path.
```
