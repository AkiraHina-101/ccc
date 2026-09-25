# Nastran Control Tool — Spec v1.0

## Mục tiêu

GUI chạy trong HyperMesh để:
1. Scan Nastran model → hiển thị Components / Properties / Materials dưới dạng bảng
2. Đặt **label** (tên người dùng) cho Components và Materials — dễ nhận biết hơn ID số
3. **Assign material** cho component bằng cách chọn tên label — tool tự tìm property và ghi MID
4. **CSV import/export** — export bảng ra CSV, edit ngoài Excel, import lại
5. **Session** — lưu trạng thái (labels, assignments) theo model, tái dụng material library

Verification status:

```text
PROJECT-SPEC:
  This is the project behavior spec, not an Altair API reference. Validate API
  assumptions through the dedicated refs and
  _clean/docs/OFFICIAL_ALTAIR_2022_3_VERIFICATION.md.
```

---

## Data Model

### 3 trường hợp Component

| Case | Mô tả | Property | Material assign |
|------|-------|----------|-----------------|
| 1 | Comp thường (2D/3D) | PSHELL / PSOLID (riêng, 1:1) | ✓ assign bình thường |
| 2 | Spring/1D có shared property | PBUSH (dùng chung N comps) | ✓ assign, hiển thị WARN "N comps affected" |
| 3 | 1D không có property | — (RBE2, RBE3, gộp vào comp_no_property) | ✗ không assign |

### Labels

| Label | Áp cho | Lưu ở đâu | Ghi vào HM? |
|-------|--------|-----------|-------------|
| Comp label | Component | session/comps.csv | **Có** — ghi vào HM component name (safe: Nastran export bỏ comp name) |
| Material label | Material | session/materials.csv | Không |

**Không label Property riêng** — property chỉ hiển thị type (PSHELL/PBUSH/…) làm context.

### Assign Flow

```
User chọn comp → chọn material label →
tool: comp.prop_id → prop.mid = mat_id của label → ghi HM → ghi audit
```

Shared property (Case 2): preview rõ "Sẽ ảnh hưởng N comps: Spring_A, Spring_B" trước khi ghi.

---

## Session Schema

**1 model = 1 session folder.** Tên folder = tên model file (không extension).

```
sessions/
└── 02-Test_Model/
    ├── materials.csv       — material library (tái dụng giữa các model)
    ├── comps.csv           — comp data + label của model này
    ├── assignments.csv     — comp_id → material_label (desired state)
    └── audit.csv           — log mọi thay đổi
```

### materials.csv
```
mat_id, label, type, e, nu, rho, note
7, Steel_HT, MAT1, 210000, 0.3, 7.85e-9,
3, Rubber_soft, MAT1, 3, 0.49, 1.2e-9,
```

### comps.csv
```
comp_id, comp_name_hm, label, prop_id, prop_type, case
45, Bracket_front, Bracket_front, 12, PSHELL, 1
12, Spring_A, Spring_A, 5, PBUSH, 2
13, Spring_B, Spring_B, 5, PBUSH, 2
99, comp_no_property, RBE_joints, , , 3
```

### assignments.csv
```
comp_id, material_label
45, Steel_HT
12, Rubber_soft
```

### audit.csv
```
timestamp, action, comp_id, comp_label, prop_id, mat_before, mat_after, status, note
2026-06-11T10:32:15, APPLY, 45, Bracket_front, 12, Alum, Steel_HT, OK,
2026-06-11T10:32:15, APPLY, 12, Spring_A, 5, , Rubber_soft, WARN, shared PBUSH: 2 comps
```

---

## GUI Layout

```
┌─────────────────────────────────────────────────────┐
│  Nastran Control  [Scan]  [Import CSV]  [Export CSV] │
├─────────────────────────────────────────────────────┤
│ Comp Label  │ ID │ Prop Type │ Material Label │ Mat ID│
│─────────────┼────┼───────────┼───────────────┼───────│
│ Bracket_... │ 45 │ PSHELL    │ Steel_HT ▼    │  7    │
│ Spring_A    │ 12 │ PBUSH ×2  │ Rubber_soft ▼ │  3    │
│ RBE_joints  │ 99 │ —         │ (greyed out)  │       │
├─────────────────────────────────────────────────────┤
│ LOG: [10:32:15] APPLY Bracket_front → Steel_HT  OK  │
│      [10:32:15] APPLY Spring_A → PBUSH#5 WARN:2comps│
└─────────────────────────────────────────────────────┘
```

**Columns:** Comp Label (editable inline) | Comp ID | Prop Type | Material Label (dropdown) | Mat ID

**Copy-paste:**
- Ctrl+C trên selected rows → clipboard TSV → paste thẳng vào Excel
- Paste từ Excel (TSV) vào bảng → update label / material assignment
- Right-click: Copy row / Paste / Copy column

**Log panel:** Scrollable text box phía dưới bảng. Mỗi action ra 1 dòng với timestamp.

---

## Out of Scope (v1)

- PBUSH numeric field write (chưa verify HM command syntax)
- Python/batch mode
- Multiple sessions per model
- Image capture (tool riêng: capture_component_images.tcl)
- Mesh / Mark Shared (tools riêng, không liên quan)

---

## File Structure

```
_clean/
├── nastran_control.tcl       — entry point
├── lib/
│   ├── hm_api.tcl            — HM commands (rebuilt từ verified probe)
│   ├── session.tcl           — session folder init/load/save
│   ├── scan.tcl              — scan model → data struct
│   ├── csv_io.tcl            — CSV read/write
│   ├── labels.tcl            — label get/set + write comp name to HM
│   ├── mutations.tcl         — apply material, audit
│   └── ui_table.tcl          — GUI table widget
├── tools/                    — standalone HM utilities (copy từ codex)
├── tests/                    — probes per phase
├── docs/                     — SPEC.md, API_VERIFIED.md
└── sessions/                 — runtime session data
```
