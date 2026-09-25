# Nastran Control Mutation Primitives

Scope: this note records the verified backend path for model-changing actions in
`production_2/material_property_mapper.tcl`.

Verification status:

```text
LOCAL-INSTALL / RUNTIME-TESTED:
  This file records project mutation primitives proven in the local tool path.

OFFICIAL:
  Altair help confirms the general HyperMesh Data Names, Query Commands, and
  Modify Commands mechanisms, but not every project primitive in this file.
```

## Current Rule

- Prefer proven HyperMesh primitives from the legacy working mapper.
- Do not identify newly-created props/materials by a before/after full-model diff
  when a direct mark-by-name flow is available.
- GUI actions may update table/cache locally after a successful mutation, but the
  model mutation itself must be confirmed by a direct HyperMesh query or mark.

## Create Property

Backend entry:

- `create_property pid card name mat_id`
- lower helper for legacy row import: `create_prop_with_id pid row`

Primitive:

1. Validate `pid`, card, and unique name.
2. Create property with `*createentity props cardimage=$card name=$name`.
3. Fallback to `*createentity props name=$name` if card-image create fails.
4. Mark the new property by exact name: `*createmark props 1 "by name only" "$name"`.
5. Read the mark with `hm_getmark props 1`.
6. Renumber the marked property to requested ID.
7. Load dictionary/card image when template is available.
8. Apply material link only after material ID resolves.
9. Append/refresh cache/table through the UI fast path.

Known failure to avoid:

- `property 'PROP_x' could not be identified after create` from before/after
  entity diff. That path is not reliable enough for New/Duplicate.

## Create Material

Backend entry:

- `create_material mid card name color`
- lower helper: `create_material_with_id mid card name color`

Primitive:

1. Validate `mid`, card, and unique name.
2. Create material with `*collectorcreate materials "$name" "" $color`.
3. Mark by exact name: `*createmark materials 1 "by name only" "$name"`.
4. Read the mark with `hm_getmark materials 1`.
5. Renumber the marked material to requested ID.
6. Load `MAT1` dictionary/card when template is available.
7. Append/refresh cache/table through the UI fast path.

## Duplicate Property

Backend entry:

- `duplicate_property source_pid new_pid new_name`

Primitive:

1. Resolve source from `scan_properties`; fallback to direct card/material fields.
2. Generate unique `_copy`, `_copy_2`, ... name.
3. Call `create_property` with the source card and material ID.
4. Copy only fields in `duplicate_property_writable_fields`.
5. Append the new row locally when possible; repaint once for multi-duplicate.

## Duplicate Material

Backend entry:

- `duplicate_material source_mid new_mid new_name`

Primitive:

1. Resolve source from `scan_materials`.
2. Generate unique `_copy`, `_copy_2`, ... name.
3. Call `create_material`.
4. Copy verified writable MAT1 numeric fields only.
5. Append the new row locally when possible; repaint once for multi-duplicate.

## Delete Property/Material

Backend entries:

- `delete_properties_selected pids`
- `delete_materials_selected mids`

Current user-approved behavior:

- Do not block delete only because a component/property still references the item.
- Audit dependency information, attempt deletion, verify model state, then remove
  rows from cache/table for deleted IDs.

## Safety Probe

Run:

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\production_2\run_safety_probes.ps1
```

Expected:

- `SAFETY_STATIC_PROBE PASS`
- `SAFETY_REGRESSION_PROBE PASS`
- `SAFETY_PROBES PASS`
