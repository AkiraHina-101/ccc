# HyperMesh Color And 3D FEM Render API Reference

Purpose: AI-readable reference for HyperMesh Tcl scripts that need to color
entities, control model visibility, set 3D FEM display style, orient/fit the
graphics window, and capture rendered images.

Verification status:

```text
OFFICIAL:
  HyperMesh view/display/capture commands such as `hm_viewshaded`,
  `hm_viewwireframe`, `hm_viewfit`, `hm_windowtofile`, and
  `hm_windowtoclipboard` are confirmed by Altair help. HyperView
  render/view classes such as `poIRenderOptions`, `poIGraphicMaterial`,
  `poIContourCtrl`, `poIResultCtrl`, and `poI3DViewCtrl` are official.

LOCAL-INSTALL:
  Detailed toolbar/profile helper commands and color/render convenience flows
  are from installed scripts.

RUNTIME-TEST-NEEDED:
  Visual output should be checked with screenshots for shaded/wireframe/contour
  and background settings.
```

Sources inspected:

```text
_ref/lib/hm_api.tcl
_ref/lib/images.tcl
_ref/_archive/Nastran_Control_Tool/material_property_mapper.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/br/common/operations/showhideisolate.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/context/viewtoolbar/hmviewtoolbar.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/context/src/viz.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/ansys/ansysbrowser/component/tableAnsys.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/EngineeringSolutions/.../hw_procedures_incl_handles.tcl
```

Embedded Python can drive these Tcl/HWI color and render commands through the
Tcl-Python bridge. See:

```text
_clean/docs/HYPERMESH_PYTHON_EMBEDDING_API_REF.md
_clean/docs/HYPERWORKS_PYTHON_VIEW_CAPTURE_API_REF.md
```

Batch-mode capture/render limits are summarized in:

```text
_clean/docs/HYPERWORKS_BATCH_API_REF.md
```

## Color Model

HyperMesh entity colors are integer color IDs. In observed code, color IDs are
1-based; the RGB list from `hm_winfo entitycolors` is indexed with `color_id - 1`.

Read palette:

```tcl
set rgb_list [hm_winfo entitycolors]
set rgb [lindex $rgb_list [expr {$color_id - 1}]]
foreach {r g b} $rgb {
    set hex [format "#%02x%02x%02x" $r $g $b]
}
```

Reference helper:

```tcl
proc hm_color_hex {color_id} {
    if {![string is integer -strict $color_id]} {
        return ""
    }
    set colors [hm_winfo entitycolors]
    set index [expr {$color_id - 1}]
    if {$index < 0 || $index >= [llength $colors]} {
        return ""
    }
    foreach {r g b} [lindex $colors $index] {
        return [format "#%02x%02x%02x" $r $g $b]
    }
    return ""
}
```

Palette use cases:

```text
color ID -> GUI swatch/hex: hm_winfo entitycolors
entity -> color ID: hm_entityinfo color or hm_getvalue ... dataname=color
new entity default color: *collectorcreate ... color
existing entity recolor: *colormark
```

## Read Entity Color

Generic:

```tcl
hm_entityinfo color comps $cid
hm_entityinfo color components $cid
hm_entityinfo color props $pid
hm_entityinfo color mats $mid
hm_entityinfo color mats $mid "-byid"

hm_getvalue comps id=$cid dataname=color
hm_getvalue props id=$pid dataname=color
hm_getvalue mats id=$mid dataname=color
hm_getvalue groups mark=1 dataname=color
```

**Confidence note**: the `hm_entityinfo color <etype> $id` forms above are
UNVERIFIED — they are not in the `tests/probe_hm_api.tcl` run log
(`API_VERIFIED.md`), and `HYPERMESH_ENTITY_MODEL_API_REF.md` explicitly flags
`hm_entityinfo color comps/props/mats` as UNVERIFIED with the caveat that
other `hm_entityinfo` sub-commands/options are confirmed NOT AVAILABLE for
comps in the same probe log. Treat every `hm_entityinfo color ...` call in
this file (including the "UI Color Cells And Swatches" table-callback
examples below) as UNVERIFIED until tested live; prefer `hm_getvalue <etype>
id=$id dataname=color` (also UNVERIFIED here, but at least consistent with
the officially-documented `dataname=` mechanism per
`OFFICIAL_ALTAIR_2022_3_VERIFICATION.md` item 15) or re-verify both forms in
a live session before relying on either in production code.

Property ID caution: resolve property display/solver ID to the internal ref when
needed, then read color from the resolved property reference.

```tcl
set prop_ref [resolve_entity_id props $prop_display_id]
set color [hm_entityinfo color props $prop_ref]
```

UI row pattern:

```tcl
dict set row prop_color [get_entity_color props $prop_ref]
dict set row prop_color_hex [hm_color_hex [dict get $row prop_color]]

dict set row mat_color [get_entity_color mats $mat_id]
dict set row mat_color_hex [hm_color_hex [dict get $row mat_color]]
```

## Set Entity Color

Color a mark:

```tcl
*createmark comps 1 "by id only" $cid
*colormark components 1 $color_id
*clearmark comps 1
```

Observed accepted entity spellings:

```tcl
*colormark comps 1 $color_id
*colormark components 1 $color_id
*colormark props 1 $color_id
*colormark properties 1 $color_id
*colormark mats 1 $color_id
*colormark materials 1 $color_id
*colormark groups 1 $color_id
*colormark contactsurfs 1 $color_id
*colormark loadcols 1 $color_id
*colormark vectorcols 1 $color_id
```

Reference helper:

```tcl
proc set_entity_color {etype ids color_id} {
    if {![string is integer -strict $color_id] || $color_id <= 0} {
        error "invalid HyperMesh color ID: $color_id"
    }
    catch {*clearmark $etype 1}
    eval [list *createmark $etype 1 "by id only"] $ids
    *colormark $etype 1 $color_id
    catch {*clearmark $etype 1}
}
```

Create material with color:

```tcl
*collectorcreate materials "$mat_name" "" $color_id
```

## UI Color Cells And Swatches

For a `tktable` cell, keep the numeric color ID as data and use the hex value for
cell background.

```tcl
set color_id [hm_entityinfo color components $cid]
set color_hex [hm_color_hex $color_id]

$table tag configure comp_color_$row -background $color_hex
$table tag cell comp_color_$row $row,$col
```

Observed table callback pattern:

```tcl
proc tblGet_color {comp} {
    set color [hm_entityinfo color components $comp]
    setCellColor $comp color $color
    return $color
}

proc tblSet_color {comp value} {
    *createmark comps 1 "by id only" $comp
    *colormark components 1 $value
    setCellColor $comp color $value
    return $value
}
```

For a custom UI, use `hm_winfo entitycolors` to build a palette grid. For HWTK
apps, `::hwtk::colorbutton` appears in the install and is the natural widget for
color picking when available.

## Visibility And Display

There are two common visibility strategies:

```text
mark-based show/hide/isolate:
  works for many entity types; used by browsers and focused render/capture.

collector/filter display:
  useful for components, groups, load collectors, contact surfaces, etc.
```

Mark-based display pattern:

```tcl
*createmark comps 1 "by id only" $cid
*createstringarray 2 "elements_on" "geometry_on"
*isolateonlyentitybymark 1 1 2
*window 0 0 0 0 0
```

Actions observed:

```tcl
*hideentitybymark 1 1 2
*showentitybymark 1 1 2
*isolateentitybymark 1 1 2
*isolateonlyentitybymark 1 1 2
```

The string array controls whether FE elements and/or geometry are affected:

```tcl
*createstringarray 2 "elements_on"  "geometry_on"
*createstringarray 2 "elements_on"  "geometry_off"
*createstringarray 2 "elements_off" "geometry_on"
```

Show all components after isolated render:

```tcl
*createmark comps 1 "all"
*showentity comps 1
*clearmark comps 1
```

Collector/filter display APIs:

```tcl
*displaycollectorwithfilter comps "on" $comp_name 1 1
*displaycollectorwithfilter comps "off" $comp_name 1 1
*displaycollectorwithfilter comps "none" "" 1 0
*displaycollectorwithfilter comps "all" "" 1 0
*displaycollectorwithfilter comps "reverse" "" 1 0

*displaycollectorsbymark components 1 "on" 1 0
*displaycollectorsbymark components 1 "off" 1 0
*displaycollectorsall off 1 1
```

Other observed collector types:

```text
components/comps
groups
contactsurfs
loadcols
loadsteps
systcols
vectorcols
plots
sets
assemblies
```

## 3D FEM Display Style

High-level view toolbar APIs observed:

```tcl
::HM_Framework::p_SetElementStyleShadedLines
::HM_Framework::p_SetElementStyleWireframeSkin
::HM_Framework::p_SetGeomShadedEdges
::HM_Framework::p_SetGeomStyleWireframe

hw::viewtoolbar invoke shadedmesh
hw::viewtoolbar invoke wireframemesh
hw::viewtoolbar invoke transparentmesh
hw::viewtoolbar invoke shadedgeom
hw::viewtoolbar invoke wireframegeom
```

Lower-level style APIs observed:

```tcl
hm_getdiedisplayattribute
hm_getoption shrink_mode
hm_getoption detailed_elements_beamvis
hm_getoption detailed_elements_shellvis
hm_info showcompositelayers

*setdisplayattributes 3 0
*settransparency 0
*settransparency 1
*transparencyvalue 0
*transparencyvalue 7
*setoption mesh_transparency=$value
```

Context-style API from `context/src/viz.tcl`:

```tcl
hwctx SetMeshStyle 0   ;# wireframe
hwctx SetMeshStyle 1   ;# hiddenline
hwctx SetMeshStyle 2   ;# hiddenlinewithmesh / shaded with mesh
hwctx SetMeshStyle 3   ;# hiddenlinewithfeatures
hwctx SetMeshStyle 4   ;# hiddenlinetransparent

hwctx SetGeomStyle 0   ;# wireframe geometry
hwctx SetGeomStyle 1   ;# hiddenlinewithfeatures / shaded with feature lines
hwctx SetGeomStyle 2   ;# hiddenlinewithmesh
hwctx SetGeomStyle 3   ;# hiddenline
hwctx SetGeomStyle 4   ;# transparent geometry
```

Practical display style recipes:

```tcl
# FEM shaded with mesh lines
catch {::HM_Framework::p_SetElementStyleShadedLines}

# FEM wireframe skin
catch {::HM_Framework::p_SetElementStyleWireframeSkin}

# Geometry shaded with edges
catch {::HM_Framework::p_SetGeomShadedEdges}
catch {*settransparency 0}
catch {*transparencyvalue 0}

# Geometry transparent
*createmark components 1 "all"
catch {*transparencymark 1}
catch {*settransparency 1}
catch {*transparencyvalue 7}
catch {*clearmark comps 1}
```

## View, Fit, Save, Restore

Common view/orientation APIs:

```tcl
*view "iso1"
*view "top"
*view "front"
*view "rear"
*view "left"
*view "right"
*view "bottom"
```

Fit model/window:

```tcl
*window 0 0 0 0 0
*window 0 0 0 0 0 0
```

Save and restore view/mask state:

```tcl
set view_name "Script_View_[clock clicks]"
*saveviewmask $view_name 0

# change display, isolate, render...

*restoreviewmask $view_name 0
*removeview $view_name
```

Use `catch` around save/restore in scripts that may run in batch/no graphics.

## HWI Session And Graphics Capture

Simple screenshot of current page/session:

```tcl
hwi GetSessionHandle sess
sess CaptureScreen PNG "$png_path" 100
sess CaptureScreen JPEG "$jpg_path" 95
sess CaptureScreen BMP "$bmp_path" 100
sess CaptureScreen TIFF "$tif_path" 100
sess CaptureScreen Clipboard ""
```

Fixed-size capture observed in the component-image tool:

```tcl
hwi CloseStack
hwi OpenStack
hwi GetSessionHandle sess1
sess1 CaptureScreenToSize png "$png_path" 768 768 95
hwi CloseStack
```

Legacy/fallback file output:

```tcl
*jpegfilenamed $jpg_path
```

Handle chain for active page/window/client:

```tcl
hwi GetSessionHandle sess
sess GetProjectHandle proj
proj GetPageHandle page [proj GetActivePage]
page GetWindowHandle win [page GetActiveWindow]
win GetClientHandle client
```

The session-level `CaptureScreen` is enough for most automation. Use the handle
chain when a script must target a specific window or HyperView/client handle.

## Render One Component To Image

This is the most reliable pattern found locally.

```tcl
proc render_component_png {cid out_png {size 768}} {
    if {[llength [info commands hwi]] == 0} {
        error "HyperMesh hwi graphics API is not available"
    }

    set view_name "Render_View_[clock clicks]"
    set saved_view_ok [expr {![catch {*saveviewmask $view_name 0}]}]

    hwi CloseStack
    hwi OpenStack
    hwi GetSessionHandle sess1

    set rc [catch {
        *createmark comps 1 $cid
        *createmark component 2 comp_id = $cid
        *createstringarray 2 "elements_on" "geometry_on"
        *isolateonlyentitybymark 2 1 2

        catch {::HM_Framework::p_SetElementStyleShadedLines}
        *view "iso1"
        *window 0 0 0 0 0

        sess1 CaptureScreenToSize png "$out_png" $size $size 95
    } err opts]

    catch {
        *createmark comps 1 "all"
        *showentity comps 1
    }
    if {$saved_view_ok} {
        catch {*restoreviewmask $view_name 0}
        catch {*removeview $view_name}
    }
    catch {*clearmark comps 1}
    catch {*clearmark comps 2}
    hwi CloseStack

    if {$rc} {
        return -options $opts $err
    }
    return $out_png
}
```

## Render Selected FEM Model

Use this when rendering a chosen set of components/properties/material-linked
components.

```tcl
proc render_components {comp_ids out_png} {
    set view_name "Render_Selected_[clock clicks]"
    set saved_view_ok [expr {![catch {*saveviewmask $view_name 0}]}]

    hwi CloseStack
    hwi OpenStack
    hwi GetSessionHandle sess1

    set rc [catch {
        *clearmark comps 1
        eval [list *createmark comps 1 "by id only"] $comp_ids
        *createstringarray 2 "elements_on" "geometry_on"
        *isolateonlyentitybymark 1 1 2

        catch {::HM_Framework::p_SetElementStyleShadedLines}
        *view "iso1"
        *window 0 0 0 0 0
        sess1 CaptureScreen PNG "$out_png" 100
    } err opts]

    catch {*createmark comps 1 "all"; *showentity comps 1; *clearmark comps 1}
    if {$saved_view_ok} {
        catch {*restoreviewmask $view_name 0}
        catch {*removeview $view_name}
    }
    hwi CloseStack

    if {$rc} {
        return -options $opts $err
    }
    return $out_png
}
```

## Color Then Render

Example: color selected components, isolate them, render, then restore view.

```tcl
proc color_and_render_components {comp_ids color_id out_png} {
    *clearmark comps 1
    eval [list *createmark comps 1 "by id only"] $comp_ids
    *colormark components 1 $color_id

    *createstringarray 2 "elements_on" "geometry_on"
    *isolateonlyentitybymark 1 1 2
    catch {::HM_Framework::p_SetElementStyleShadedLines}
    *view "iso1"
    *window 0 0 0 0 0

    hwi GetSessionHandle sess
    sess CaptureScreen PNG "$out_png" 100

    *clearmark comps 1
}
```

## Cautions

```text
1. Color IDs are HyperMesh palette IDs, not RGB literals.
2. Convert ID -> RGB/hex only for GUI display; use ID for *colormark.
3. Property IDs may need internal-ref resolution before reading color.
4. Always clear marks after color/display operations.
5. Save/restore view masks around render scripts that change visibility.
6. hwi/CaptureScreen requires graphics; guard for batch/no-graphics sessions.
7. CaptureScreen captures the current page/window state; prepare the viewport first.
8. CaptureScreenToSize is useful for deterministic thumbnails.
9. For component-only render, use "elements_on" and usually "geometry_on".
10. If `*isolateonlyentitybymark` leaves model hidden after an error, restore all comps with `*createmark comps 1 "all"; *showentity comps 1`.
```
