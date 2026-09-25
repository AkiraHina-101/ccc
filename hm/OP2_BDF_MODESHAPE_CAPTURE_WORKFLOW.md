# OP2/BDF To Mode Shape Capture Workflow

Purpose: proposed workflow for going from a large Nastran `.bdf` model and a
large `.op2` result file to still images or animated GIFs of mode shapes in
HyperView/HyperWorks.

This is not an API reference. It is an operating strategy based on locally
inspected HyperWorks scripts and the current project notes. Use it as the
recommended direction for building a robust tool.

Verification status:

```text
PROPOSED-WORKFLOW:
  The recommended OP2/BDF -> filtered H3D -> HyperView capture pipeline is a
  proposed operating strategy, not an Altair API guarantee.

OFFICIAL:
  Batch Mode, HWI Tcl object handles, HyperView view-control classes, and the
  general translator category are confirmed by Altair help.

LOCAL-INSTALL:
  Exact HvTrans flow and AVI capture commands are from installed Altair Tcl
  scripts.

RUNTIME-TEST-NEEDED:
  End-to-end PNG/AVI/GIF capture on a small OP2/BDF first, then on the real
  1.5 GB BDF and 40-80 GB OP2.
```

Target context:

```text
Input model:  Nastran BDF, around 1.5 GB
Input result: OP2, around 40-80 GB
Goal:         capture selected mode shapes as PNG/JPEG frames and/or GIF
Main risk:    waiting too long while HyperView reloads huge BDF/OP2 data
```

## Main Recommendation

Do not capture directly from the raw `.bdf + .op2` pair repeatedly.

Recommended pipeline:

```text
1. OP2 + BDF
   -> use HvTrans GUI or hvtrans script once
   -> create smaller H3D containing only needed modal content

2. H3D
   -> open in HyperView GUI once
   -> set view, style, deformation, legend, background
   -> save MVW template/session

3. MVW/H3D
   -> run capture script
   -> loop selected modes without reloading the OP2
   -> write PNG frames

4. PNG frames
   -> make GIF using ffmpeg/ImageMagick/Python
```

Why: with a 40-80 GB OP2, the expensive part is result loading and metadata
parsing. Pay that cost once during conversion/filtering, then capture from a
smaller H3D/session.

## What Is Best Done In GUI

Use GUI for the work that benefits from visual inspection:

```text
HvTrans GUI:
  - confirm OP2 reader works
  - confirm BDF/model source is correct
  - choose modal subcase
  - choose mode range using By Step or individual modes using By List
  - choose only necessary result data types
  - export H3D

HyperView GUI:
  - check H3D loads faster than OP2
  - set model orientation
  - set deformed/mode-shape display
  - set scale factor
  - set contour, legend, background, mesh/shaded style
  - choose visible parts
  - save an MVW template
```

Do not use GUI for repetitive capture of many modes. It is too easy to lose
consistency, and the software may appear unresponsive during long operations.

## What Is Best Done By Code

Use code for repeatable work:

```text
HvTrans script or saved HvTrans config:
  - repeat conversion for many OP2/BDF pairs
  - use the same mode range/data type rules
  - log failures

HyperView/HWI capture script:
  - open one MVW/H3D once
  - loop modes/simulations
  - wait/draw after each mode switch
  - capture PNG/JPEG with deterministic names
  - skip already captured modes
  - retry failed captures

External GIF build:
  - combine PNG frames into GIF
  - control FPS, size, palette, compression
```

## Verified Local Evidence

The following local files/scripts informed this workflow:

```text
HvTrans GUI and config:
  <ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransgui.tcl
  <ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransOpenResult.tcl
  <ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransSaveConfig.tcl
  <ALTAIR_INSTALL_DIR>/io/result_readers/tcl/hvtransOpenConfig.tcl

HyperView capture/animation:
  <ALTAIR_INSTALL_DIR>/utility/scripts/function_keys.tcl
  <ALTAIR_INSTALL_DIR>/hw/tcl/postquery/hwpGet_functions.tcl
  <ALTAIR_INSTALL_DIR>/hw/tcl/hw/tests/framework/AnimationCapture.tst.tcl
  <ALTAIR_INSTALL_DIR>/hw/tcl/hw/tests/framework/ImageTestCommon.tst.tcl

Project refs:
  _clean/docs/HYPERWORKS_BATCH_API_REF.md
  _clean/docs/HYPERWORKS_PYTHON_VIEW_CAPTURE_API_REF.md
  _clean/docs/HYPERMESH_COLOR_RENDER_API_REF.md
```

Important confidence notes:

```text
CaptureScreen/CaptureWindow PNG/JPEG is strongly supported by inspected scripts.
CaptureAnimation AVI is used in installed function-key scripts and CFD profile
code; AVI FPS can be set through GetAVIExportOptionsHandle.
GIF appears in report/test metadata and in the GUI, but the inspected function
key and production-style scripts use AVI. Treat direct GIF export from code as
optional until verified on the target machine.
PNG frames -> GIF is the safest GIF path.
```

## Stage 1: Convert OP2/BDF To H3D

### GUI Route

Use this route first for a new solver/model family.

1. Start HyperView or HyperWorks Post.
2. Open HvTrans.
3. Open the `.op2` result file.
4. If prompted, choose the correct result reader.
5. Enable `Include model with translated results` if the output H3D should
   later load without the original BDF.
6. Choose model source:

```text
From result file:
  Use if the result file already carries enough model/geometry information.

From input deck:
  Use if the OP2 does not contain sufficient model geometry or if the BDF must
  define the model. Select the `.bdf`.
```

7. In the Simulation section choose either:

```text
By List:
  Select individual modes/simulations.
  Use All / None / Reverse as needed.

By Step:
  Select a mode range:
    From: first mode/simulation
    To:   last mode/simulation
    By Step: increment
  Example: From mode 1, To mode 50, By Step 1.
  Example: From mode 1, To mode 100, By Step 5.
```

8. Choose only the result data needed for mode-shape capture.

Recommended for mode-shape display:

```text
Keep:
  displacement/eigenvector/mode-shape data needed for deformation

Avoid unless needed:
  stress
  strain
  force
  contact
  every elemental layer/component
```

9. Choose model parts if the GUI exposes part selection and only a subset is
   needed for capture.
10. Use compression if it reduces size acceptably. Validate visually after the
    first conversion.
11. Save the translated output as H3D.

Optional setting observed in the GUI:

```text
Output H3D for every step
```

Use this only if one-H3D-per-mode is useful for parallel capture or debugging.
For a normal capture pipeline, one H3D containing selected modes is usually
easier to manage.

### Code Route

Use this after the GUI route is proven.

The underlying command layer can do the same work:

```tcl
hvtrans control SetResultReader $reader
hvtrans control SetResultFile $op2
hvtrans control LoadResults

hvtrans control SetModelReader $model_reader
hvtrans control SetModelFile $bdf
hvtrans control LoadModel

hvtrans config Reset
hvtrans config AddItem Parts
hvtrans config AddItem Subcase<$subcase>/Simulation<$mode>/...

hvtrans control SetOutputFile $h3d
hvtrans control StartTranslation
```

This mirrors the installed GUI flow: the `Translate...` button calls `saveProc`,
sets the output H3D path with `hvtrans control SetOutputFile`, then starts the
conversion with `hvtrans control StartTranslation`.

For large files, prefer a saved HvTrans config from the GUI, then use script to
adjust file paths and run translation. This is less error-prone than building
all config paths by hand on day one.

## Stage 2: Build A HyperView Capture Template

Do this in GUI once per report/capture style.

1. Open the converted H3D in HyperView.
2. Confirm load time is acceptable.
3. Set client/window to Animation if needed.
4. Set modal/deformed display.
5. Set deformation scale.
6. Set view orientation and fit.
7. Set shaded/mesh display style.
8. Set legend, background, annotations, and units.
9. Hide parts that should not appear.
10. Save as an `.mvw` template.

The template should contain visual state, not the raw OP2/BDF dependency if
possible. The goal is that the capture script opens a prepared MVW/H3D and does
not repeatedly parse the giant OP2.

## Stage 3: Capture Still Frames With Code

Use HyperView/HWI, not pure `hmbatch`, for rendered captures.

Launch shape:

```text
hw.exe /clientconfig hwpost.dat -b -tcl capture_modes.tcl <template.mvw> <out_dir> <mode_list>
```

Conceptual capture loop:

```tcl
hwi OpenStack
hwi GetSessionHandle sess
sess LoadSessionFile $mvw false
sess GetProjectHandle proj
proj GetPageHandle page [proj GetActivePage]
page GetWindowHandle win [page GetActiveWindow]
win GetClientHandle client
client GetModelHandle model [client GetActiveModel]
model GetResultCtrlHandle result

foreach mode $modes {
    result SetCurrentSimulation $mode
    client Draw
    after 500
    sess CaptureWindow 0 png "$out_dir/mode_[format %04d $mode].png" pixels 1280 960
}

hwi CloseStack
```

Actual handle names and zero/one-based indices should be verified on a small
H3D first. Keep the same HyperView session open for the whole loop.

For modal phase animation rather than one image per mode, use animator controls:

```tcl
page SetAnimationMode modal
page GetAnimatorHandle anim
anim SetIncrementBy angle
anim SetNumberOfFrames $n
anim SetIncrement $angle_increment
anim SetCurrentFrame $frame
client Draw
sess CaptureScreenToSize PNG "$frame_png" 1280 960 100
```

This is a safer way to build GIF frames than relying on direct GIF capture.

Important draw/wait rule: after changing the current mode, phase frame, scale,
camera, or contour, force a client/page draw before capture. Installed scripts
use patterns such as `client Draw`, `page Draw`, and `after idle` before area
animation capture because immediate capture can stop drawing or capture a stale
frame.

## Stage 4: Create GIF

### Recommended: PNG Frames To GIF

Capture PNG frames first. Then combine them into GIF outside HyperView.

Example with ffmpeg:

```powershell
ffmpeg -framerate 8 -i mode_%04d.png -vf "scale=1280:-1:flags=lanczos,palettegen" palette.png
ffmpeg -framerate 8 -i mode_%04d.png -i palette.png -lavfi "scale=1280:-1:flags=lanczos[x];[x][1:v]paletteuse=dither=bayer" mode_shapes.gif
```

If ImageMagick is available:

```powershell
magick -delay 12 -loop 0 mode_*.png mode_shapes.gif
```

If neither is available, a Python tool can be added later using Pillow or
imageio. The capture design should still write PNG frames first.

### Alternative: Capture AVI Then Convert

Installed HyperWorks scripts use:

```tcl
hwi OpenStack
hwi GetSessionHandle capture_sess
capture_sess CaptureAnimation AVI $filename
hwi CloseStack
```

FPS/quality/size options are exposed through AVI export options:

```tcl
hwi GetSessionHandle sess
sess GetAVIExportOptionsHandle aviopt
aviopt SetFrameRate 12
sess CaptureAnimation AVI $aviFile
```

The HyperMesh/HyperWorks image-capture preference XML also lists AVI palette,
image quality, size, and frames-per-second settings. This makes AVI the most
locally evidenced direct animation export route from script.

There is also:

```tcl
sess CaptureAnimationByAreaPercentage AVI $file $x $y $w $h
```

This is useful if HyperView's own animation playback is already configured.
After AVI export, convert AVI to GIF with ffmpeg:

```powershell
ffmpeg -i capture.avi -vf "fps=8,scale=1280:-1:flags=lanczos,palettegen" palette.png
ffmpeg -i capture.avi -i palette.png -lavfi "fps=8,scale=1280:-1:flags=lanczos[x];[x][1:v]paletteuse" capture.gif
```

### Optional: Try Direct GIF Capture

Some local report/test metadata lists GIF as an animation/rendered output
format. However, the inspected function-key script uses AVI, and the inspected
animation test framework lists GIF but does not implement animation generation.

So direct GIF capture should be treated as a target-machine experiment:

```tcl
catch {capture_sess CaptureAnimation GIF $gifFile} err
```

If it fails, use PNG frames or AVI.

### HyperView GUI GIF

The GUI can expose GIF as an animation capture option, and local report/test
metadata lists GIF among animation output formats. That does not make HvTrans a
GIF tool: HvTrans only converts OP2/BDF/result content to H3D. GIF capture still
belongs to HyperView or an external encoder.

For very large jobs, use GUI GIF only after the H3D is already filtered and
small enough. Avoid trying to make the GUI animate/capture directly from the raw
40-80 GB OP2 unless the selected range is tiny and the response time has been
tested.

## Performance Guidelines For Very Large OP2/BDF

Use these rules for 40-80 GB OP2 files:

```text
Keep one HyperView session open during capture.
Do not reload OP2 for each mode.
Do not reload BDF for each mode.
Convert OP2+BDF to filtered H3D first.
Prefer H3D with embedded model for capture.
Select only required modal subcase/modes.
Select only required displacement/eigenvector data.
Avoid unnecessary elemental stress/strain/layer data.
Prefer local SSD/NVMe paths, not network paths.
Split huge jobs into mode chunks if needed.
Write logs and resume from existing PNG files.
Use fixed image size; avoid huge 4K captures until the pipeline is stable.
```

Suggested chunking:

```text
Chunk 1: modes 1-20
Chunk 2: modes 21-40
Chunk 3: modes 41-60
```

This helps if one conversion/capture fails; only rerun the failed chunk.

## Practical GUI/Code Split

```text
Task                                      GUI        Code
----------------------------------------  ---------  -----------------------------
Verify OP2 reader                         best first  later automate
Choose model source BDF/result            best first  later automate
Choose mode range                         good        good after known subcase IDs
Choose visual style/view                  best        possible but tedious
Save MVW template                         best        possible
Loop hundreds of modes                    poor        best
Wait/draw/retry/log                       poor        best
Create PNG frames                         ok manual   best
Create GIF from frames                    possible    best external tool
```

## Minimum Prototype Plan

1. Pick a small mode range, for example modes 1-3.
2. Use HvTrans GUI to create a small H3D from OP2+BDF.
3. Open H3D in HyperView GUI.
4. Set final view/style and save `capture_template.mvw`.
5. Write a Tcl capture script that opens the MVW and captures 3 PNG files.
6. Convert the PNGs to GIF externally.
7. Only after this works, scale to all needed modes.

## What To Validate On Real Data

Before committing to a full 80 GB job, verify:

```text
Does OP2 load in HvTrans without exhausting memory?
Does "From result file" contain usable geometry, or is BDF required?
Does output H3D open without needing the original BDF/OP2?
Does selected mode range map to the expected physical modes?
Does deformation scale remain consistent across modes?
Does CaptureWindow or CaptureScreenToSize produce nonblank images?
Does direct CaptureAnimation GIF work on this install? If not, use PNG/AVI.
How long does one mode capture take after H3D is loaded?
```

## Recommended Final Architecture

```text
prepare_h3d/
  input:  bdf, op2, mode range, data type policy
  output: filtered h3d, conversion log
  tool:   HvTrans GUI first, hvtrans Tcl later

make_template/
  input:  filtered h3d
  output: mvw template
  tool:   HyperView GUI

capture_frames/
  input:  mvw template, h3d, mode list
  output: PNG frames, capture log
  tool:   hw.exe /clientconfig hwpost.dat -b -tcl

make_gif/
  input:  PNG frames
  output: GIF
  tool:   ffmpeg/ImageMagick/Python
```

The key design principle is simple: use GUI to define a correct visual state,
then use code to repeat it without reloading massive files.
