# HyperMesh Entity Model API Reference

Purpose: AI-readable reference for reading and editing HyperMesh/Nastran model
entities used by the Nastran Control Tool, especially component, property, and
material structure.

Verification status:

```text
OFFICIAL:
  Data Names, `hm_getvalue`, pointer data-name access, the Modify Commands
  category, `*createentity`, and entity categories such as components,
  properties, materials, elements, nodes, results, and tables are confirmed by
  Altair help.

LOCAL-INSTALL:
  `*setvalue` usage and detailed Nastran card/entity/field inventory are from
  installed Altair Tcl/template files.

RUNTIME-TEST-NEEDED:
  Mutations should be validated on throwaway models and exported BDFs before
  production use.
```

This file is a synthesis from:

```text
_clean/lib/scan.tcl
_clean/lib/mutations.tcl
_clean/lib/labels.tcl
_clean/docs/API_VERIFIED.md
_ref/lib/hm_api.tcl
_ref/_archive/Nastran_Control_Tool/material_property_mapper.tcl
<ALTAIR_INSTALL_DIR>/hm/scripts/nastran/*.tcl
```

Detailed Nastran card/field inventory generated from the HyperMesh template is
kept in:

```text
_clean/docs/HYPERMESH_NASTRAN_CARD_FIELD_REF.md
```

Detailed color/render API for `hm_winfo entitycolors`, `hm_entityinfo color`,
`*colormark`, show/hide/isolate, display style, view control, and screenshots is
kept in:

```text
_clean/docs/HYPERMESH_COLOR_RENDER_API_REF.md
```

Embedded Python support and Tcl-Python bridge notes are kept in:

```text
_clean/docs/HYPERMESH_PYTHON_EMBEDDING_API_REF.md
```

Batch-mode model scan/edit/export/validate notes are kept in:

```text
_clean/docs/HYPERWORKS_BATCH_API_REF.md
```

## Mental Model

Primary relationship:

```text
component -> property -> material
```

Meaning:

```text
component:
  Collector/container for elements and geometry.
  Has an ID, name, color, and usually a referenced property.

property:
  Solver property collector/card such as PSHELL, PBUSH, PSOLID.
  Has a HyperMesh internal reference, a solver/display ID, a name, card image,
  card-specific fields, and usually a referenced material.

material:
  Solver material collector/card such as MAT1.
  Has an ID, name, card image, color, and card-specific numeric fields.
```

In this codebase, "component ID" is usually safe to use as the visible ID. For
properties, be more careful: HyperMesh can expose both an internal reference and
a solver/display ID. Many bugs come from passing one where the other is expected.

## Entity Type Names

Common entity type spellings:

```text
components: comps, component
properties: props, properties
materials: mats, materials
elements: elems, elements
nodes: nodes
```

Many commands accept short names such as `comps`, `props`, `mats`. Some card and
attribute APIs use long names such as `properties` or `materials`.

## IDs, Names, And Refs

Important concepts:

```text
internal ref:
  The HyperMesh database reference. Often returned by marks and by
  component -> property links.

solver/display ID:
  The ID shown to the user or exported to the solver. Properties may need
  dataname=solver_id to read this.

name:
  Collector/entity name. Required by some update commands, for example
  *materialupdate and *propertyupdate use names, not numeric IDs.
```

Useful wrappers from `_ref/lib/hm_api.tcl`:

```tcl
mark_all $etype
get_name $etype $id
get_entity_id $etype $id
resolve_entity_id $etype $display_id
get_card $etype $id
get_entity_value $etype $id $candidate_datanames $string_flag
```

The property-safe ID flow:

```tcl
# display/solver ID from a property reference
set prop_display_id [get_entity_id props $prop_ref]

# internal reference from a display/solver ID
set prop_ref [resolve_entity_id props $prop_display_id]
```

## Load Template Before Cards

Card image reads need a solver template. In GUI HyperMesh this is often already
loaded, but batch or scripted sessions may return empty card names until the
template is set.

```tcl
set template ""
catch {set template [hm_info templatefilename]}
if {$template eq "" || ![file exists $template]} {
    foreach candidate {
        {<ALTAIR_INSTALL_DIR>/templates/feoutput/nastran/general}
        {<ALTAIR_INSTALL_DIR>/templates/feoutput/nastran/nastran}
        {<ALTAIR_INSTALL_DIR>/templates/feoutput/optistruct/optistruct}
    } {
        if {[file exists $candidate]} {
            catch {*templatefileset $candidate}
            break
        }
    }
}
```

Read card names:

```tcl
hm_getcardimagename props +$pid -byid
hm_getcardimagename mats  +$mid -byid
```

## List And Count Entities

Each command below is documented as **Signature / Return shape /
Precondition-side-effect / Confidence**. Confidence levels follow
`OFFICIAL_ALTAIR_2022_3_VERIFICATION.md`:
`OFFICIAL`, `RUNTIME-TESTED`, `LOCAL-INSTALL`, `UNVERIFIED`.

### `*clearmark` / `*createmark "all"` — list all entities by type

1. **Signature**
   ```tcl
   catch {*clearmark comps 1}
   *createmark comps 1 "all"
   set comp_ids [hm_getmark comps 1]
   catch {*clearmark comps 1}
   ```
   Args: entity type (`comps`, or `props`/`mats` per the variants below), mark
   number, and either the literal `"all"` or a selection-mode string. Same
   pattern works for other entity types:
   ```tcl
   *createmark props 1 "all"
   *createmark mats 1 "all"
   hm_getmark props 1
   hm_getmark mats 1
   ```

2. **Return shape**
   `*createmark`/`*clearmark` are side-effect only (no return value); they
   populate/empty the given mark number. `hm_getmark <etype> <mark#>` returns a
   Tcl list of internal entity IDs in the mark (empty list if none match).

3. **Precondition / side-effect**
   Call `*clearmark` before `*createmark` on the same mark number to avoid
   appending to a stale mark left over from a previous operation. Call
   `*clearmark` again after reading the mark via `hm_getmark` to leave session
   state clean. Wrapping `*clearmark` in `catch` is a defensive pattern in case
   the mark does not yet exist (first use in a session).

4. **Confidence**: RUNTIME-TESTED for the `comps` case (see
   `API_VERIFIED.md`, probe run 2026-06-11, PASS). The `props`/`mats` variants
   use the identical command form and are treated as RUNTIME-TESTED by
   extension, though not each individually re-probed.

### `hm_marklength` — count elements in a component

1. **Signature**
   ```tcl
   catch {*clearmark elems 1}
   *createmark elems 1 "by collector id" $cid
   set count [hm_marklength elems 1]
   catch {*clearmark elems 1}
   ```
   `hm_marklength` args: entity type (`elems`), mark number.

2. **Return shape**
   `hm_marklength` returns a single integer string — the number of entities in
   the mark. Returns `0` if the component has no elements. `*createmark ...
   "by collector id" $cid` is side-effect only (populates the mark).

3. **Precondition / side-effect**
   Requires `*clearmark` then `*createmark elems 1 "by collector id" $cid` to
   run first on the same mark number. This is the confirmed working
   alternative to `hm_entityinfo comps $id numelems`, which is NOT AVAILABLE
   (invalid option) per `API_VERIFIED.md`. Clear the mark again afterward.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS — see
   `API_VERIFIED.md` "1 FAIL has working alternative").

## Read Component

### `hm_getvalue comps ... dataname=name` — component name

1. **Signature**
   ```tcl
   hm_getvalue comps id=$cid dataname=name
   ```
   Args: entity type (`comps`), `id=<int>` (component ID), `dataname=name`.

2. **Return shape**
   Returns a single string: the component's name.

3. **Precondition / side-effect**
   None beyond `$cid` referring to a valid, existing component. Read-only.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS — see
   `API_VERIFIED.md`).

### `hm_getvalue comps ... dataname=propertyid` — component's property reference

1. **Signature**
   ```tcl
   hm_getvalue comps id=$cid dataname=propertyid
   ```
   Fallback alternates, tried in order in `_clean/lib/scan.tcl`-style code:
   ```tcl
   foreach script [list \
       [list hm_getvalue comps id=$cid dataname=propertyid] \
       [list hm_getentityvalue comps +$cid property.id 0 -byid] \
       [list hm_getentityvalue comps $cid property.id 0]] {
       if {![catch $script value] && [string is integer -strict [string trim $value]] && $value > 0} {
           set prop_ref [string trim $value]
           break
       }
   }
   ```

2. **Return shape**
   Returns a single string containing an integer: the property's internal
   reference. Returns `0` or empty string when the component has no assigned
   property (Case 3). The fallback loop above treats any non-integer or
   non-positive result as a failure and tries the next form.

3. **Precondition / side-effect**
   None beyond `$cid` referring to a valid, existing component. Read-only. The
   value is a HyperMesh internal reference, not necessarily the solver/display
   property ID — see "IDs, Names, And Refs" above.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS) for the primary
   `hm_getvalue ... dataname=propertyid` form. The two `hm_getentityvalue`
   fallback forms are LOCAL-INSTALL — present in the codebase's defensive
   fallback pattern but not each individually confirmed by the probe log.

### `hm_entityinfo color comps` — component color

1. **Signature**
   ```tcl
   hm_entityinfo color comps $cid
   ```
   Args: `color` sub-command, entity type (`comps`), component ID.

2. **Return shape**
   UNKNOWN — needs live-session verification. Likely returns a color index or
   RGB triple based on the color/render API in
   `HYPERMESH_COLOR_RENDER_API_REF.md`, but the exact return shape for this
   specific call was not confirmed in this file or in `API_VERIFIED.md`.

3. **Precondition / side-effect**
   None beyond `$cid` referring to a valid, existing component. Read-only
   (assumed).

4. **Confidence**: UNVERIFIED — not in the probe log (`API_VERIFIED.md`) and
   not cross-checked against official docs in
   `OFFICIAL_ALTAIR_2022_3_VERIFICATION.md`. Note `hm_entityinfo` with other
   sub-commands/options (`numelems`, `2delems`, etc.) is confirmed NOT
   AVAILABLE for comps in `API_VERIFIED.md`, so this specific `color`
   sub-command should be treated with caution until tested.

Case classification used by `_clean/lib/scan.tcl`:

```text
case_type 1: normal component with property
case_type 2: shared PBUSH property used by more than one component
case_type 3: no property assigned, prop_id = 0
```

Case 3 components cannot receive a material directly through
`*materialupdate props ...` because there is no property to update.

## Read Property

### `hm_getvalue props ... dataname=name` — property name

1. **Signature**
   ```tcl
   hm_getvalue props id=$pid dataname=name
   ```
   Args: entity type (`props`), `id=<int>` (property ID/ref), `dataname=name`.

2. **Return shape**
   Returns a single string: the property's name.

3. **Precondition / side-effect**
   None beyond `$pid` referring to a valid, existing property. Read-only.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS — see
   `API_VERIFIED.md`).

### `hm_getvalue props ... dataname=solver_id` — property solver/display ID

1. **Signature**
   ```tcl
   hm_getvalue props id=$pid dataname=solver_id
   ```
   Args: entity type (`props`), `id=<int>` (internal property ref),
   `dataname=solver_id`.

2. **Return shape**
   UNKNOWN — needs live-session verification. Expected to return a single
   integer string (the solver/display ID as distinct from the internal
   reference — see "IDs, Names, And Refs" above), but this exact dataname was
   not in the `tests/probe_hm_api.tcl` run recorded in `API_VERIFIED.md`.

3. **Precondition / side-effect**
   None beyond `$pid` referring to a valid, existing property. Read-only
   (assumed).

4. **Confidence**: UNVERIFIED — not covered by the probe log in
   `API_VERIFIED.md`. The general `hm_getvalue ... dataname=X` mechanism is
   OFFICIAL (confirmed by Altair Data Names docs per
   `OFFICIAL_ALTAIR_2022_3_VERIFICATION.md` item 15), but this specific
   `dataname=solver_id` value was not independently confirmed.

### `hm_getcardimagename` — property card type (PSHELL/PBUSH/...)

1. **Signature**
   ```tcl
   hm_getcardimagename props +$pid -byid
   ```
   Args: entity type (`props`), `+$id` (ID prefixed with `+`), `-byid` flag.

2. **Return shape**
   Returns a single string: the card image name, e.g. `"PSHELL"`. Returns
   empty string if no solver template is loaded.

3. **Precondition / side-effect**
   Requires a solver template loaded first via `*templatefileset` (see "Load
   Template Before Cards" above). Read-only otherwise.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS, after template
   load — see `API_VERIFIED.md`).

### `hm_getentityvalue props ... material.id` — property's material reference

1. **Signature**
   ```tcl
   hm_getentityvalue props +$pid material.id 0 -byid
   ```
   Robust fallback order used in this codebase:
   ```tcl
   foreach script [list \
       [list hm_getentityvalue props +$pid material.id 0 -byid] \
       [list hm_getentityvalue props $pid material.id 0] \
       [list hm_getvalue props id=$pid dataname=materialid]] {
       if {![catch $script value] && [string is integer -strict [string trim $value]] && $value > 0} {
           set mat_id [string trim $value]
           break
       }
   }
   ```

2. **Return shape**
   Returns a single string containing an integer: the material's internal
   reference. Returns `0`/empty if the property has no material assigned. The
   fallback loop treats non-integer or non-positive results as failure and
   tries the next form.

3. **Precondition / side-effect**
   None beyond `$pid` referring to a valid, existing property. Read-only.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS — see
   `API_VERIFIED.md`) for all three forms in the fallback chain; all three are
   listed together as verified alternates in `API_VERIFIED.md`.

### `hm_getentityvalue props ... material.name` — material name via property

1. **Signature**
   ```tcl
   hm_getentityvalue props +$pid material.name 1 -byid
   ```
   Alternate: `hm_getentityvalue props $pid material.name 1` (no `+`/`-byid`).
   The trailing `1` (vs `0` for `material.id`) selects the string-typed value
   flag, not a repeat count.

2. **Return shape**
   Returns a single string: the material's name as known to HyperMesh — the
   exact string required by `*materialupdate` (see Edit Property below).

3. **Precondition / side-effect**
   Requires `$pid` to be a valid property reference that already has a
   material assigned. Behavior when no material is assigned is UNKNOWN — needs
   live-session verification.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS — see
   `API_VERIFIED.md`) for the `+$pid ... -byid` form; the plain-`$pid` alternate
   is LOCAL-INSTALL (present in codebase, not separately probed).

### `hm_entityinfo color props` — property color

1. **Signature**
   ```tcl
   hm_entityinfo color props $pid
   ```

2. **Return shape**
   UNKNOWN — needs live-session verification (same caveat as `hm_entityinfo
   color comps` above).

3. **Precondition / side-effect**
   None beyond `$pid` referring to a valid, existing property. Read-only
   (assumed).

4. **Confidence**: UNVERIFIED — not in the probe log; other `hm_entityinfo`
   sub-commands/options are confirmed NOT AVAILABLE for other entity types in
   `API_VERIFIED.md`, so treat this with caution until tested.

### Card-specific numeric fields (reference list, not a command)

```text
PSHELL-like fields: T, NSM, Z1, Z2
PSOLID detail fields: from psolid_detail_fields
PBUSH numeric fields: from pbush_numeric_fields
```

This is a field-name inventory extracted from the archived material/property
mapper script, not a callable API. Confidence: LOCAL-INSTALL (from
`_ref/_archive/Nastran_Control_Tool/material_property_mapper.tcl`).

### `hm_attributeindexmax` / `hm_attributeindexidentifier` / `hm_attributeindexvalue` — read property attributes by identifier

1. **Signature**
   ```tcl
   set max_index [hm_attributeindexmax properties $pid -byid]
   for {set index 1} {$index <= $max_index} {incr index} {
       set identifier [hm_attributeindexidentifier properties $pid $index -byid]
       if {$identifier eq $attr_id} {
           set value [hm_attributeindexvalue properties $pid $index -byid]
       }
   }
   ```
   Args:
   - `hm_attributeindexmax`: entity type (long form `properties`), property ID,
     `-byid` flag.
   - `hm_attributeindexidentifier`: entity type, property ID, 1-based attribute
     index, `-byid` flag.
   - `hm_attributeindexvalue`: entity type, property ID, 1-based attribute
     index, `-byid` flag.

2. **Return shape**
   - `hm_attributeindexmax` returns a single integer string: the highest valid
     attribute index for this property/card.
   - `hm_attributeindexidentifier` returns a single string: the attribute's
     identifier name at that index (e.g. a card field name), used to match
     against a known `$attr_id`.
   - `hm_attributeindexvalue` returns a single string: the attribute's current
     value at that index. Exact type (numeric vs string) is UNKNOWN — needs
     live-session verification; the caller must interpret it based on the
     known field.

3. **Precondition / side-effect**
   Requires `$pid` to be a valid property reference. Uses the long entity-type
   name `properties` (not `props`) per this codebase's usage — some
   attribute/card APIs use long names while mark/value APIs use short names
   (see "Entity Type Names" above). Read-only. This loop is the documented
   fallback for reading a card field when a direct `dataname=` is not accepted
   (mirrors the `*setvalue`-not-accepted case documented for writes in
   `API_VERIFIED.md`'s NOT AVAILABLE table).

4. **Confidence**: LOCAL-INSTALL — this pattern is present in
   `_clean/lib/scan.tcl`/`_ref/lib/hm_api.tcl` and inferred from installed
   Altair Tcl scripts, but none of the three `hm_attributeindex*` commands
   appear in the `tests/probe_hm_api.tcl` run log in `API_VERIFIED.md`, so it
   is not RUNTIME-TESTED.

## Read Material

### `hm_getvalue mats ... dataname=name` — material name

1. **Signature**
   ```tcl
   hm_getvalue mats id=$mid dataname=name
   ```
   Args: entity type (`mats`), `id=<int>` (material ID/ref), `dataname=name`.

2. **Return shape**
   Returns a single string: the material's name.

3. **Precondition / side-effect**
   None beyond `$mid` referring to a valid, existing material. Read-only.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS — see
   `API_VERIFIED.md`).

### `hm_getentityvalue mats ... name` — material name (alternate form)

1. **Signature**
   ```tcl
   hm_getentityvalue mats $mid name 1
   ```
   Args: entity type (`mats`), material ID, dataname (`name`), trailing `1`
   flag (string-typed value, same convention as `material.name` on props
   above).

2. **Return shape**
   Returns a single string: the material's name. Same semantic result as
   `hm_getvalue mats id=$mid dataname=name` above.

3. **Precondition / side-effect**
   None beyond `$mid` referring to a valid, existing material. Read-only.

4. **Confidence**: LOCAL-INSTALL — listed in this codebase's reference as
   an alternate read form, but not separately confirmed in the
   `tests/probe_hm_api.tcl` run log in `API_VERIFIED.md` (only the
   `hm_getvalue` form for mats was in that probe run).

### `hm_getcardimagename` — material card type (MAT1/...)

1. **Signature**
   ```tcl
   hm_getcardimagename mats +$mid -byid
   ```
   Args: entity type (`mats`), `+$id` (ID prefixed with `+`), `-byid` flag.

2. **Return shape**
   Returns a single string: the card image name, e.g. `"MAT1"`. Returns empty
   string if no solver template is loaded.

3. **Precondition / side-effect**
   Requires a solver template loaded first via `*templatefileset` (see "Load
   Template Before Cards" above). Read-only otherwise.

4. **Confidence**: RUNTIME-TESTED (probe run 2026-06-11, PASS, after template
   load — see `API_VERIFIED.md`).

### `hm_entityinfo color mats` — material color

1. **Signature**
   ```tcl
   hm_entityinfo color mats $mid
   ```

2. **Return shape**
   UNKNOWN — needs live-session verification (same caveat as `hm_entityinfo
   color comps`/`props` above).

3. **Precondition / side-effect**
   None beyond `$mid` referring to a valid, existing material. Read-only
   (assumed).

4. **Confidence**: UNVERIFIED — not in the probe log; treat with caution until
   tested.

### Card-specific material fields (reference list, not a command)

```text
MAT1-like fields:
  E, G, NU, RHO, A, TREF, GE, ST, SC, SS, MCSID
```

Field-name inventory from the archived material/property mapper script, not a
callable API. Confidence: LOCAL-INSTALL.

### `hm_attributeindexmax` / `hm_attributeindexidentifier` / `hm_attributeindexvalue` — read material attributes by identifier

1. **Signature**
   ```tcl
   set max_index [hm_attributeindexmax materials $mid -byid]
   for {set index 1} {$index <= $max_index} {incr index} {
       set identifier [hm_attributeindexidentifier materials $mid $index -byid]
       if {$identifier eq $attr_id} {
           set value [hm_attributeindexvalue materials $mid $index -byid]
       }
   }
   ```
   Same command family and argument shape as the property-attribute variant
   above, but with entity type `materials` (long form) and `$mid` instead of
   `$pid`.

2. **Return shape**
   Same as the property-attribute variant: `hm_attributeindexmax` returns an
   integer string (max valid index); `hm_attributeindexidentifier` returns a
   string identifier; `hm_attributeindexvalue` returns a string value whose
   type depends on the specific card field. Exact value-type handling is
   UNKNOWN — needs live-session verification.

3. **Precondition / side-effect**
   Requires `$mid` to be a valid material reference. Uses long entity-type name
   `materials`. Read-only. Documented fallback for reading a card field when a
   direct `dataname=` is not accepted.

4. **Confidence**: LOCAL-INSTALL — same status as the property-attribute
   variant; not present in the `tests/probe_hm_api.tcl` run log in
   `API_VERIFIED.md`.

## Row Schemas

Clean Nastran Control component row:

```text
comp_id    int     component ID
comp_name  string
prop_id    int     0 = Case 3/no property
prop_name  string
prop_card  string  PSHELL/PBUSH/PSOLID/etc.
mat_id     int     0 = no material
mat_name   string
mat_card   string  MAT1/etc.
case_type  int     1=normal, 2=shared PBUSH, 3=no property
elem_count int     -1 until lazily fetched
```

Archived property row:

```text
prop_id
prop_ref
hm_prop_name
display_name
card
mat_id
mat_ref
mat_name
T, NSM, Z1, Z2
psolid_detail_fields...
pbush_numeric_fields...
```

Archived material row:

```text
mat_ref
mat_id
hm_mat_name
display_name
card
E, G, NU, RHO, A, TREF, GE, ST, SC, SS, MCSID
```

UI row enrichment:

```text
entity_type: comp | prop | mat
entity_id
comp_user_name / prop_user_name / mat_user_name
prop_color, prop_color_hex
mat_color, mat_color_hex
mat_alias
mat_usage_count
shared_count
note
_pending_create, _pending_create_seq
```

## Edit Component

Rename a component:

```tcl
set old_name [hm_getvalue comps id=$cid dataname=name]
*renamecollector comps "$old_name" "$new_name"
```

Assign a property to a component:

```tcl
set prop_ref [resolve_entity_id props $prop_display_id]
set prop_name [get_name props $prop_ref]

*clearmark comps 1
*createmark comps 1 "by id only" $cid
*propertyupdate comps 1 "$prop_name"
*clearmark comps 1
```

Renumber component:

```tcl
*clearmark comps 1
*createmark comps 1 "by id only" $old_id
*renumber comps 1 $new_id 1 0 0
*clearmark comps 1
```

Set component color:

```tcl
*clearmark comps 1
*createmark comps 1 "by id only" $cid
*colormark comps 1 $color_id
*clearmark comps 1
```

## Edit Property

Assign material to a property. Critical: `*materialupdate` expects the material
name string, not the material ID.

```tcl
set mat_name [hm_getvalue mats id=$mat_id dataname=name]

*clearmark props 1
*createmark props 1 "by id only" $prop_id
*materialupdate props 1 "$mat_name"
*clearmark props 1
```

Rename property:

```tcl
set old_name [hm_getvalue props id=$prop_id dataname=name]
*renamecollector props "$old_name" "$new_name"
```

Create property:

```tcl
set before_refs [mark_all props]
set card PSHELL
set prop_name "PROP_1001"

if {[catch {*createentity props cardimage=$card name=$prop_name}]} {
    *createentity props name=$prop_name
}

set prop_ref [new_entity_ref_after_create props $before_refs $prop_name "Property"]
catch {*dictionaryload properties 1 [hm_info templatefilename] "$card"}
```

Renumber property solver/display ID:

```tcl
*clearmark properties 1
*createmark properties 1 "by id only" $old_id
*renumbersolverid properties 1 $new_id 1 0 0 0 0 0
*clearmark properties 1
```

Set property fields:

```tcl
*setvalue props id=$prop_ref T=$value
*setvalue props id=$prop_ref NSM=$value
```

Fallback for attributes when dataname fields are not accepted:

```tcl
*attributeupdatedouble properties $prop_ref $attr_id 1 2 0 $value
*attributeupdateint    props      $prop_ref $attr_id 18 2 0 $value
```

Set property color:

```tcl
*clearmark props 1
*createmark props 1 "by id only" $prop_id
*colormark props 1 $color_id
*clearmark props 1
```

## Edit Material

Rename material:

```tcl
set old_name [hm_getvalue mats id=$mat_id dataname=name]
*renamecollector mats "$old_name" "$new_name"
```

Create material:

```tcl
set name "MAT_1001"
set color 7
*collectorcreate materials "$name" "" $color

*clearmark materials 1
*createmark materials 1 "$name"
*renumber materials 1 $mat_id 1 0 0
*clearmark materials 1

set template [hm_info templatefilename]
catch {*dictionaryload materials 1 $template "MAT1"}
```

Renumber material:

```tcl
*clearmark materials 1
*createmark materials 1 "by id only" $old_id
*renumber materials 1 $new_id 1 0 0
*clearmark materials 1
```

Set material fields:

```tcl
*setvalue mats id=$mat_ref E=$value
*setvalue mats id=$mat_ref G=$value
*setvalue mats id=$mat_ref NU=$value
*setvalue mats id=$mat_ref RHO=$value
```

Fallback for attributes:

```tcl
*attributeupdatedouble materials $mat_ref $attr_id 1 2 0 $value
```

Set material color:

```tcl
*clearmark mats 1
*createmark mats 1 "by id only" $mat_id
*colormark mats 1 $color_id
*clearmark mats 1
```

## Delete Entities

Pattern:

```tcl
*clearmark $etype 1
*createmark $etype 1 "by id only" $id
*deletemark $etype 1
*clearmark $etype 1
```

Use with care. Deleting a property or material can leave components or properties
with broken references. Prefer explicit validation and UI confirmation.

## Create Pending Rows In UI

The archived mapper separates UI intent from actual model creation. A pending
row has `_pending_create 1`; it is not committed to HyperMesh until an apply/save
step creates the entity.

Pending property default:

```text
_pending_create 1
entity_type prop
prop_id / prop_ref / entity_id
prop_card PSHELL
prop_name, hm_prop_name = PROP_<id>
mat_id, mat_ref, mat_card empty
T, NSM, Z1, Z2 empty
```

Pending material default:

```text
_pending_create 1
entity_type mat
mat_id / mat_ref / entity_id
mat_card MAT1
mat_name, hm_mat_name = MAT_<id>
E, G, NU, RHO, A, TREF, ST, SC, SS empty
```

## Cache And Refresh

Read caches observed:

```text
model_mark_cache
model_entity_ref_cache
_prop_cache
_mat_cache
_prop_users
model_scan_cache
model_display_rows
```

After any model mutation:

```text
clear or invalidate entity caches
rescan the affected rows or full table
refresh UI table data
recompute shared-property Case 2 status
re-render image cells if the table uses image_path
```

## High Risk Rules

```text
1. Do not assign material to a Case 3 component; create/assign a property first.
2. Warn for shared PBUSH properties; editing the property affects multiple comps.
3. For *materialupdate and *propertyupdate, pass entity names, not numeric IDs.
4. Load a solver template before hm_getcardimagename or dictionaryload.
5. Resolve property IDs carefully; props may have solver ID != internal ref.
6. Use marks for mutations, then clear marks.
7. Use catch around HyperMesh commands and report the real command error.
8. For card fields, prefer *setvalue first, then attributeupdate fallback.
9. After create, identify the new entity by diffing mark_all before/after.
10. Keep UI row edits separate from HM model commits until Apply/Save.
```
