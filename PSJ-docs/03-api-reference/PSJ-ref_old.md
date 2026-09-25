# Hướng dẫn cho AI

File này là nguồn kiến thức duy nhất cho AI. Đọc trước khi làm bất cứ việc gì.

---

## User Context

- **Người dùng:** Yamada — kỹ sư CAE tại công ty Nhật, dùng JStamp (FEM) của TechnoStar
- **Chuyên môn:** NVH mesh, phân tích kết cấu
- **Cách làm việc:** tự chủ, không hỏi lại nhiều; AI viết code, user định hướng và review
- **Kỳ vọng:** giải thích code theo hướng "block này lấy gì → dùng để làm gì → xuất ra gì", kèm data type. Ngắn gọn, đủ hiểu
- **Realtime macro:** `C:\Users\TechnoStar\AppData\Local\Temp\TechnoStar\00\PSJCommands.py` (kiểm tra folder `00`–`03`, lấy `LastWriteTime` mới nhất)
- **Khi nói "đọc macro":** đọc các dòng mới trong PSJCommands.py kể từ lần đọc trước
- **Browser:** Microsoft Edge (không phải Chrome)
- **Cấm:** đọc/dùng file license; không dùng data project cho training Anthropic

---

## Quy tắc chọn tool (bắt buộc tuân thủ)

### KHÔNG được spawn agent khi có thể dùng tool trực tiếp

| Tác vụ | Tool đúng | KHÔNG dùng |
|---|---|---|
| Tìm keyword trong PSJCommands.py | `Grep` | Explore/general-purpose agent |
| Đọc file đã biết path | `Read` | Explore agent |
| Tra cứu PSJ documentation | Skill `read-psj-doc` | general-purpose agent |
| Chạy lệnh shell/Python | `Bash` | general-purpose agent |
| Edit code | `Edit` trực tiếp | Agent |

### Khi NÀO mới dùng agent

Chỉ spawn agent khi **cả 3 điều kiện** đúng:
1. Không biết trước path/file cụ thể
2. Cần reasoning qua nhiều bước không đoán được
3. Không có skill/tool trực tiếp nào xử lý được

### Chọn model cho agent

| Loại tác vụ | Model |
|---|---|
| Phân tích logic, debug, thiết kế thuật toán | `sonnet` |
| Lập kế hoạch kiến trúc phức tạp | `sonnet` |
| Search/gather đơn giản (nếu bắt buộc dùng agent) | `haiku` |
| KHÔNG dùng | `opus` (quá đắt cho project này) |

---

## Help — Local Documentation

Source: `C:\Program Files\TechnoStar\Jupiter_5.0.4\Help\`

| File/Folder | Nội dung | Cách đọc |
|---|---|---|
| `WEB_BASE_HELP\psj\` | **PSJ docs đầy đủ dạng HTML tĩnh** (Docusaurus) — đọc trực tiếp bằng `Read` tool | `Read` path HTML |
| `BASE_HELP\JPT-Help_FULL_EN.pdf` | Full Jupiter manual tiếng Anh | PDF viewer |
| `BASE_HELP\JPT-Help_FULL_JP.pdf` | Full Jupiter manual tiếng Nhật | PDF viewer |
| `API_HELP\JPT_API_Help_EN.chm` | JPT API reference tiếng Anh | CHM viewer |
| `API_HELP\JPT_API_Help_JP.chm` | JPT API reference tiếng Nhật | CHM viewer |

### WEB_BASE_HELP — cấu trúc thư mục docs

```
WEB_BASE_HELP\psj\docs\
├── psj-command\       ← tất cả PSJ commands (meshing, geometry, BC…)
│   ├── meshing\
│   ├── geometry\
│   ├── boundary-conditions\
│   ├── connections\
│   ├── analysis\
│   ├── post\
│   └── ...
├── psj-gui\           ← toàn bộ pyjdg API — MỖI METHOD = 1 folder có index.html
│   ├── JDGCreator\
│   ├── dlg.add_spin\
│   ├── dlg.add_face_selector\
│   └── ... (100+ methods)
├── macro\             ← macro recording examples
├── data-type\         ← PSJFont, TableCellID, TableCellRange, PSJMessageBox…
├── get-started\
├── tutorials\
└── external-ide\
```

**Cách đọc doc cho 1 method:**
```
Read: C:\Program Files\TechnoStar\Jupiter_5.0.4\Help\WEB_BASE_HELP\psj\docs\psj-gui\dlg.add_spin\index.html
```
> **Ưu tiên dùng local HTML này** thay vì extract từ PSJ Documentation.exe — nhanh hơn, không cần brotli decode.

---

## pyjdg — Bổ sung từ local docs (WEB_BASE_HELP)

Các method **chưa có** trong PSJ_KNOWLEDGE.md, tìm được từ `WEB_BASE_HELP\psj\docs\psj-gui\`:

### Selectors bổ sung
- `dlg.add_vertex_selector()` — thêm Vertex vào selection list
- `dlg.add_elementedge_selector()` — thêm Element Edge vào selection list
- `dlg.add_barpart_selector()` — thêm Bar Part vào selection list
- `dlg.add_2delement_selector()` — thêm 2D Element vào selection list
- `dlg.add_3delement_selector()` — thêm 3D Element vào selection list
- `dlg.add_condition_selector()` — thêm Boundary Condition vào selection list
- `dlg.add_coordinate_selector()` — thêm Coordinate System vào selection list
- `dlg.add_group_selector()` — thêm Group vào selection list

> Tất cả selector không cần tham số. Dùng kết hợp với `on_dlg_selector_changed` hoặc `get_dlg_selector_selected_entities`.

- `dlg.get_dlg_selector_selected_entities(selid)` → DItemVector
  - Description: lấy danh sách DItem đang được pick trong selection list
  - Key params: `selid` = index của selector (0 = selector đầu tiên được thêm)

- `dlg.on_dlg_selector_changed(callfunc)` — callback mỗi khi user pick entity
  - Key params: `callfunc(dlg, sel_list)` — `sel_list` = list DItem vừa pick

### Dialog control
- `dlg.do_modal()` — hiện dialog dạng **modal** (blocking, khác `generate_window` là non-blocking)
- `dlg.on_command(name, callfunc)` — bind function vào bất kỳ component nào theo tên
  - Key params: tổng quát hơn `on_button_clicked` — dùng cho custom event binding

### ImageCtrl
- `dlg.add_imagectrl(name, image_file, layout)` — thêm image frame vào dialog
  - Key params: `image_file` = đường dẫn tuyệt đối; dùng `JPT.GetProgramPath()` để build path
- `dlg.set_image_file(name, image_file)` — đổi ảnh hiển thị sau khi dialog đã mở

### ListBox
- `dlg.add_listbox(name, layout, multisel=False, options=[], width=0, height=0)`
- `dlg.add_listbox_option(name, option)` — thêm 1 item vào listbox
- `dlg.insert_listbox_options(name, options)` — thêm nhiều items
- `dlg.insert_listbox_option(name, option, index)` — chèn vào vị trí cụ thể
- `dlg.remove_listbox_option(name, index)` — xóa item theo index
- `dlg.clear_listbox(name)` — xóa tất cả items
- `dlg.get_listbox_sel(name)` → int — index đang chọn
- `dlg.get_listbox_sels(name)` → list[int] — các index đang chọn (multisel)
- `dlg.get_listbox_option(name, index)` → str
- `dlg.get_len_listbox(name)` → int — tổng số items
- `dlg.set_listbox_sel(name, index)` — set selection theo index
- `dlg.on_listbox_sel(name, callfunc)` — callback khi selection thay đổi

### Browser
- `dlg.add_browser(name, mode="file", filefilter="", default="", multisel=False, layout)` — file/folder picker
  - Key params: `mode` = `"file"` | `"folder"`; `filefilter` = `"All Files (*.*), Abaqus (*.inp)"`

### Button / Checkbox / RadioButton
- `dlg.add_button(name, text="", width=0, height=0, layout)` — nút bấm
- `dlg.add_checkbox(name, text="", width=0, height=0, checked=False, layout)` — checkbox
- `dlg.add_radiobutton(name, text="", width=0, height=0, checked=False, group=False, layout)` — radio button
  - Key params: `group=True` → tách nhóm mới (không deselect radio trước); `group=False` → cùng nhóm với radio trước
- `dlg.isbutton_checked(name)` → bool — đọc trạng thái checkbox/radio
- `dlg.set_checkbox_state(name, checked)` — set trạng thái checkbox
- `dlg.set_radiobutton_state(name, checked)` — set trạng thái radio button

### Textbox / Label / RichEditBox
- `dlg.add_textbox(name, text="", width=0, height=0, type="string", layout)` — input text
  - Key params: `type` = `"string"` | `"double"` | `"integer"`
- `dlg.add_label(name, text="", width=0, height=0, texthalign="left", textvalign="top", layout)` — label tĩnh
  - Key params: `texthalign` = `"left"` | `"center"` | `"right"`; `textvalign` = `"top"` | `"middle"` | `"bottom"`
- `dlg.add_richeditbox(name, text="", width=60, height=22, layout)` — rich text box (multi-line)
- `dlg.get_item_text(name)` → str — đọc text của bất kỳ component nào
- `dlg.set_item_text(name, text)` — set text của component

### Combobox
- `dlg.add_combobox(name, options=[], width=0, height=0, layout)` — dropdown list
- `dlg.add_combobox_option(comboboxname, optiontext)` — thêm 1 item
- `dlg.insert_combobox_option(comboboxname, position, option)` — chèn vào vị trí cụ thể
- `dlg.insert_combobox_options(comboboxname, position, options)` — chèn nhiều items
- `dlg.get_combobox_sel(comboboxname)` → int — index đang chọn
- `dlg.get_combobox_option(comboboxname, index)` → str — text của item theo index
- `dlg.get_len_combobox(comboboxname)` → int — tổng số items
- `dlg.set_combobox_sel(comboboxname, option)` — set selection (int index hoặc str tên)

### Slider
- `dlg.add_slider(name, width=60, height=22, min=0, max=100, pos=0, vertical=False, showticks=True, showborder=False, showbothticks=False, layout)` — thanh trượt
- `dlg.set_slider_vertical(name, enabled)` — đổi hướng vertical/horizontal
- `dlg.set_slider_show_tics(name, enabled)` — hiện/ẩn tick marks
- `dlg.set_slider_show_border(name, enabled)` — hiện/ẩn border
- `dlg.set_slider_bothtics(name, enabled)` — tick marks 2 bên hay 1 bên

### Table
- `dlg.add_table(name="", menus=[], width=260, height=260, showgridline=True, showlinenumber=True, columns=[], rows, layout)` — bảng dữ liệu
  - Key params: `columns` = list str tên cột (required); `rows` = số hàng (required); `menus` options: `"clear"`, `"cut"`, `"copy"`, `"paste"`, `"insert row"`, `"delete row"`, `"from file"`, `"to file"`
- `dlg.add_table_right_menu(tablename, menus)` — thêm items vào context menu
- `dlg.get_cell_value(tablename, cellrowid, cellcolumnid)` → str — đọc giá trị ô (0-based)
- `dlg.set_cell_value(tablename, cellrowid, cellcolumnid, value)` — ghi giá trị ô
- `dlg.get_table_sel_cell(tablename)` → TableCellID — ô đang chọn; `.row_number`, `.col_number`
- `dlg.get_total_row(name)` → int — tổng số hàng
- `dlg.get_total_column(name)` → int — tổng số cột
- `dlg.get_table_column_width(tablename, col)` → int — độ rộng cột
- `dlg.set_table_column_width(tablename, col, width)` — set độ rộng cột
- `dlg.set_table_cell_fill_color(tablename, cell, color)` — tô màu nền ô; `cell` = `TableCellID(row, col)`
- `dlg.set_table_cell_text_color(tablename, cell, color)` — tô màu chữ ô
- `dlg.on_table_sel_changed(tablename, callfunc)` — callback khi chọn ô khác
- `dlg.on_table_right_menu(tablename, callfunc)` — callback khi right-click context menu

### Tab Window
- `dlg.add_tabwnd(name, width=60, height=22, layout)` — tab container
- `dlg.add_tabwnd_page(tabwndname, pagename, pagetext="", pageorientation="vertical")` — thêm tab page
  - Key params: `pageorientation` = `"vertical"` | `"horizontal"`
- `dlg.get_tabwnd_current_page(name)` → int — index tab đang hiển thị
- `dlg.set_tabwnd_current_page(name, pageindex)` — chuyển tab
- `dlg.on_active_tab_page(name, callfunc)` — callback khi user chuyển tab

### Pages Control (Wizard-style)
- `dlg.add_pagesctrl(name, showheader=True, currentpage=0, layout)` — wizard multi-page trong dialog
- `dlg.add_pageitem(pagesctrlname, pagename, pageheader)` — thêm page vào pagesctrl
- `dlg.set_pagesctrl_current_page(pagesctrlname, pageindex)` — chuyển page (0-based)

### GroupBox
- `dlg.add_groupbox(name, width=0, height=0, text="", layout)` — group box container
- `dlg.set_groupbox_checked(name, checked)` — hiện/ẩn checkbox của groupbox (True=hiện+checked)
- `dlg.set_groupbox_collapsed(name, collapsed)` — hiện/ẩn collapse icon (True=collapsed)
- `dlg.set_groupbox_orientation(name, orientation)` — `"vertical"` | `"horizontal"`

### Layout & Spacing
- `dlg.add_hlayout(name, margin=[], layout)` — horizontal layout container
- `dlg.add_vlayout(name, margin=[], layout)` — vertical layout container
- `dlg.add_layout(name, orientation, margin=[], layout)` — layout với orientation object
- `dlg.add_space(name="", orientation="", size=0, layout)` — khoảng trống giữa các components
- `dlg.add_separator(layout)` — đường kẻ phân cách
- `dlg.show_layout(name)` — hiện layout và tất cả children
- `dlg.hide_layout(name)` — ẩn layout và tất cả children

### Visibility & Tooltip
- `dlg.enable_item(name)` — enable component
- `dlg.disable_item(name)` — disable component
- `dlg.show_tooltip(name, tip)` — tooltip khi hover chuột
- `dlg.set_icon_file(file)` — set icon cho dialog window (full path)

---

## Jupiter Macro API Reference

Source: `C:\Program Files\TechnoStar\Jupiter_5.0.4\macro\`

---

## Module: macro_defs.py

Cursor type helpers và constants dùng xuyên suốt toàn bộ API.

**Constants:** `DFLT_INT`, `DFLT_INT_64`, `DFLT_DBL`, `FLT_MAX`

**Cursor constructors** (auto-generated cho mọi entity type):
```python
Part(1, 2)        # CursorStr typeId=3
Face(10)          # CursorStr typeId=6
Node(691)         # CursorStr typeId=10
Elem(5)           # CursorStr typeId=11
RefFace((5, 5))   # ReferenceCursorStr typeId=15 — (ext_id, int_id)
RefPart((1, 2))   # typeId=12
RefEdge((1, 1))   # typeId=14
```

- `getCursorStr(cr)` → str — `[typeId, id]` list → `"Face(10)"`
- `getCursorListStr(crs)` → str — list of `[typeId, id]` → `"[Face(10, 11), Node(1)]"`
- `getCursorValue(cr)` → CursorStr — convert raw list cursor thành object
- `getCursorListValue(crs)` → list[CursorStr]
- `getBoolValue(val)` → bool — 0/1 → False/True
- `normalizeDoubleType(val)` → float|list — int → float, handle DFLT_DBL
- `CursorPair(first, second)` → CursorPairStr — dùng cho node pairs

**cursorTypes dict** — 0–193 mapping typeId → tên entity (Part=3, Face=6, Node=10, Elem=11, RefFace=15, Material=22, LoadCase=28, Group=79…)

---

## Module: macroTypes.py

Parameter data classes cho các lệnh phức tạp. Tất cả implement `__init__()`, `fromList()`, `toNativeStr(isOneParam)`.

### CAD_SPATIAL_PARAM_DATA
- `CAD_SPATIAL_PARAM_DATA(dSurfacePlaneTolerance=0, dSufacePlaneAngle=20, dMaxFacetWidth=0.1, bNXMultipart=True, bHealing=True)`
  - Description: tham số tessellation khi import CAD (Spatial/NX)

### CAD_PROE_PARAM_DATA
- `CAD_PROE_PARAM_DATA(dChordHeightTolerance=0, dAngleToleranceDegree=20, dStepMaxSize=0.1)`
  - Description: tham số tessellation khi import ProE/CREO

### FORCE_LBC
- `FORCE_LBC(vecForce, vecMoment, iEndArrowDir, iEndDistribute, crCurCoord, crTable, crNodeSet, dPhase, dDelay, ...)`
  - Description: định nghĩa một load case force/moment (dùng trong BoundaryConditions)

### SURFACE_MESH
- `SURFACE_MESH(...)` — tham số cho `SurfaceMeshing` và `SetMeshAttribute`
  - Description: mesh size, element type, quality settings cho surface mesher

### NASTRAN_ANALYSIS
- `NASTRAN_ANALYSIS(...)` — tham số solver cho tất cả `Analysis.Nastran.*` jobs

### ABAQUS_PAIR / ABAQUS_OUTPUT_REQUEST
- Dùng trong `Analysis.AbaqusStep.*` step definitions

### GRID_MESH
- `GRID_MESH(crlFace, crlCorner, ilMeshCount, iShape=4, bOptimize=True)`
  - Description: định nghĩa một vùng grid mesh — xem chi tiết trong PSJ_KNOWLEDGE.md

---

## Module: FileMenu.py

- `LoadJTH5(strFileName="", bUseTmpTable=False)` — mở file .jth5
- `SaveJTH5(strFileName="")` — lưu file .jth5
- `LoadJTDB(strFileName="", bUseTmpTable=False)` — mở project database .jtdb
- `SaveJTDB(strFileName, strHistoryTree="")` — lưu project database
- `AddJTDB(strFileName, strMethod="AUTO", strTargetModel="IMPORTED", strOption="OFFSET", iInputNode=0, iInputElem=0, iInputPart=0, iInputFace=0, iInputEdge=0, iInputMaterial=0, iInputProperty=0, iInputInst=0, strTargetUnit="CURRENT")` — import/merge JTDB vào model hiện tại
- `LoadPOH5(strFileName="", bUseTmpTable=False)` — mở post-processing file .poh5
- `SavePOH5(strFileName="")` — lưu file .poh5

---

## Module: Geometry/Part.py

Tất cả trả về cursor `Part` (hoặc list cursor).

- `Cube(dlOrigin, dlLength, ilAxialNodes=[10,10,10], strName="Cube_1", iPartColor=7105764, crLocalCoordinate=None)` → Part cursor
- `Wedge(dlOrigin, dlLength, ilAxialNodes, strName, iPartColor, crLocalCoordinate)` → Part cursor
- `Sphere(dlOrigin, dRadius=0.005, iLatitudeDivisions=20, iLongitudeDivisions=20, strName, iPartColor, crLocalCoordinate)` → Part cursor
- `Torus(dlOrigin, dInnerRadius=0.015, dRingRadius=0.02, iCircumNodes=20, iRingNodes=20, strName, iPartColor, crLocalCoordinate)` → Part cursor
- `Cylinder(strName, crLocalCoordinate, bHollow=False, bTapered=False, dlOrigin, dTopInnerRadius, dTopOuterRadius, dBottomInnerRadius, dBottomOuterRadius, dHeight, iCircularNodes=36, iAxialNodes=10, iPartColor)` → Part cursor
- `Cone(dlOrigin, dBottomRadius=0.01, dHeight=0.02, iCircularNodes=20, iAxialNodes=20, strName, iPartColor, crLocalCoordinate)` → Part cursor
- `Trapezoid(dlOrigin, dlLength, dTopXLength=7.0, dRadius=0, ilAxialNodes, strName, iPartColor, crLocalCoordinate)` → Part cursor
- `Tube(strName, bTri=True, crlEdges=[], dRadius=0.01, dMeshSizeAxis=0.005, dWMeshSizeCirc=0.001, iNumCirc=36, iPartColor)` → list[Part cursor]
  - Key params: `crlEdges` — edges dùng làm path cho tube
- `Elems(crlElems, strPartName)` — tạo Part mới từ các elements đã chọn

---

## Module: Geometry/Face.py

- `FourEdges(crlEdges)` → Face cursor — tạo face từ 4 edges
- `FromMesh(crFace)` — tạo CAD face từ mesh face
- `Edges(crlEdges, crlParts=[], crlNodes=[], bSharedFace=False, bSmoothFace=False, bCreatePart=False, bImproved=False, bBarsOnly=False, bOnlyOnePart=True, bIncludeMidNodes=False)` → Face cursor
  - Description: tạo face từ edges (thường dùng để tạo face bao quanh vùng cần mesh)
- `Elements(crlElems, bSharedFace=False)` → list[Face cursor] — tạo faces từ elements
- `CreateSmoothFace(bInterPoration, crlTargets, iElemGeneration, dGradation, iEnableFaceSmooth, crTargetPart)` — tạo smooth face từ mesh

---

## Module: Geometry/FindFeature.py

- `Face(crlParts=[], crlFaces=[], iType=0, bCylinder=True, bDisc=False, bFourCorners=True, dMinThickness=0.1, dMaxThickness=2.0, dMinFaceWidth=0.1, dMaxFaceWidth=10.0, dMinCurveRadius=0.1, dMaxCurveRadius=10, dAngleMin=0, dAngleMax=171, bConvex=True, bConcave=False)` → list[Face cursor]
  - Description: tìm faces theo loại hình học (cylinder, disc, four-corner) trong parts
- `Edge(crlParts=[], iEdgeType=0, crlEdges=[], dDiameterMin=1.0, dDiameterMax=2.0, crlFaces=[])` → list[Edge cursor]
  - Description: tìm edges theo loại (circular, straight…) trong parts
- `Fillet(crlParts=[], crlFaces=[], dMinAngle=1, dMaxAngle=10, dMinFaceWidth=1, dMaxFaceWidth=10, dMinCurveRadius=0, dMaxCurveRadius=171, dScale=1.0)` — tìm và xóa fillet/chamfer
- `DelCircChamfer(crlParts, dMaxThick=0.1, dMinThick=2)` — xóa circular chamfer
- `Faces(crlParts, iFaceType=0, bCylinder=True, bDisc=False, bFourCorners=True, dMinThickness=0.1, dMaxThickness=2.0, crlFaces=[])` — legacy version của `Face()`

---

## Module: Meshing/__init__.py

- `SurfaceMeshing(crlParts=[], surfaceMesh=SURFACE_MESH(), bUseSetting=True, bFMesher=False, iThreadNum=8, bRefData=True, bMeshColor=False, iPartColor=65280)` → bool
  - Description: mesh bề mặt 2D cho các parts
  - Key params: `surfaceMesh` — SURFACE_MESH object chứa size/type settings
- `SolidMeshing(crlParts=[], bTet10=False, dGradingFactor=0, dStretchLimit=0, iSpeedVsQual=0, iSpeedVsMem=0, iRegion=0, bInternalNodes=True, bSafeMode=True, iParallel=0, bSurfaceNodes=True, bEdgeNodes=True, bPreservation=True, bInternalMeshOnly=True, bMeshColor=False, iPartColor=2763429)` → bool
  - Description: mesh solid 3D (tet) cho các parts
- `GridMesh(listGridMesh=[], bProjectToCad=False, strGroupName="", bMakeNewGroup=False)` → bool
  - Description: mesh structured quad/tri từ danh sách `GRID_MESH` objects — xem PSJ_KNOWLEDGE.md
- `BarMeshing(crlCadEdge, crlBarEdge, crlBarPart, dDocMeshSize=0, iDocNumofElem=4)` → bool
  - Description: mesh bar/beam elements dọc theo CAD edges
- `SetMeshAttribute(crlParts=[], surfaceMesh=SURFACE_MESH())` → bool — set mesh attributes mà không chạy meshing

---

## Module: Meshing/CADProjection.py

- `Part(crCadPart=None, crMeshedPart=None, bForceProject=False, bProjectCornerNodes=False, bProjectMidNodes=True, bIDcheck=True)` → bool
  - Description: project toàn bộ mesh part lên CAD part
- `Face(crCadPart=None, crlMeshedFaces=[], bForceProject=False, bProjectCornerNodes=True, bProjectMidNodes=False, bIDcheck=False)` → bool
  - Description: project mesh faces lên CAD part (dùng RefPart)
  - Key params: `crCadPart` = `RefPart((ext_id, int_id))`
- `FaceToFace(crlCadFaces=[], crlMeshedFaces=[], bProjectCornerNodes=False, bProjectMidNodes=True, bIDcheck=True)` → bool
  - Description: project mesh faces lên CAD faces cụ thể (dùng RefFace)
  - Key params: `crlCadFaces` = `[RefFace((ext_id, int_id))]`
- `NodeToFace(crlCadFaces=[], crlMeshedNodes=[], iDirection=0, iImproveQuality=0, dTol=1e-3, bNearest3Nodes=False)` → bool
  - Description: project nodes lên CAD faces
  - Key params: `iDirection` 0=auto,1=X,2=Y,3=Z,4=-X,5=-Y,6=-Z; `iImproveQuality` bỏ qua iDirection nếu ≠0
- `NodeToEdge(crCadEdge=None, crlMeshedNodes=[], iDirection=0)` → bool
  - Description: project nodes lên CAD edge (dùng RefEdge)

---

## Module: Connections/__init__.py

- `MassElements(strName, crlTargets, dMass=0.01, iDof=1, bDesigner=True, crCoordinate=None, dOffset0=0, dOffset1=0, dOffset2=0, dInertia0-5=0, crEdit=None, bUpdateDispCS=True)` → cursor
  - Description: tạo concentrated mass element (CONM2)
- `BarBeam(strName, iEType=10, iMethod=1, crProp=None, dlOrient=[], crlMasterTargets=[], crlSlaveTargets=[])` → cursor
  - Description: tạo bar/beam connection giữa master và slave targets
- `RBE3(iMethod=0, crlMasterTargets=[], crlSlaveTargets=[], listRbe3TermConnection=[], iTypeRBE3=3, strName="", crCoordSys=None, dTolerance=0, posVirtualNodePos=[0,0,0], iSurfaceDef=0, crEdit=None, bUpdateDispCS=True, bCornerOnly=False)` → cursor
  - Description: tạo RBE3 rigid body element
- `Connector(strName="", iMethod=1, iConnectType=0, iRefNode=0, iElemCs=0, crLocalCS=None, crlElasticity=[], crlDamp=[], crlMasterTargets=[], crlSlaveTargets=[], crEdit=None, iEffectiveDofs=0)` → cursor
  - Description: tạo connector element (spring/damper/bushing phức hợp)
- `GapsDetail(crlMaster=[], crlSlave=[], iMethod=0, iOriMode=0, crCoord=None, strName="", dU0, dF0, dKa, dKb, dKt, dMar, dMu1, dMu2, dlOriVec, dTmax, dTol, dTrmin, crEditCur=None)` → cursor
  - Description: tạo gap element với đầy đủ tham số contact
- `RigidWall(strName, iObject, iType, iMotion, iFriction, iOrtho, iForces, ..., bAllNodeSlave=False, crCoord, crAreaFaceSet, crVisualNodeSet, crlTargets, crEdit)` → cursor
  - Description: tạo rigid wall (dùng cho explicit dynamics)
- `Plot(strName="PLOT_1", iPID=1, crlTargets=[], crEdit=None)` → cursor — tạo 1D plot property
- `CreateConnConm(strName, iEType, iMethod, iCoordSys, iConmId, crMatCoord, dMass, dlX, dlVintertia0, dlVintertia1)` → cursor — tạo CONM element (Nastran)
- `BoltMeshingSplitOnly(strName, ..., surfaceMesh, ..., crlTargets, poslCutter)` → cursor — bolt meshing (split only mode)
- `BoltMeshingNotSplitOnly(strName, ..., surfaceMesh, ..., crlTargets, poslCutter)` → cursor — bolt meshing (full mode)

---

## Module: Properties/Material.py

- `Add(strMaterialName, listMaterialProperty, iMaterialID=0)` — tạo material mới; iMaterialID=0 → auto-assign ID
- `Modify(iMaterialID, listMaterialProperty)` → bool — cập nhật properties của material có sẵn
- `Delete(iMaterialID)` → bool — xóa material theo ID

---

## Module: Analysis/AbaqusStep.py

Tất cả trả về cursor `AbaqSteps*`.

- `StaticStep(strName, strDescription="", iAutomatic=0, iMaxInc=0, dInitSize, dMinSize, dMaxSize, iMethod, iMatrixStorage, iSolutionTech, iAllowIter, dAdjustFactor, iMaxContactIteration, iType, dDampingFactor, iUseAdaptive, dMaxRationOfEnergyStrain, iNlGeom, dTimePeriod, iIncludeHeatEffect, iConvertDiscontinuityIteration, iRamp, iExtrapolateMethod, iAcceptByMaxIteration, iObtainLongTermSolution, iPertubation, iFullPlasticRegion, strlFullPlasticRegion, listOutput=[], crEdit=None)` → cursor
- `DynamicStep(strName, strDescription="", iAutomatic=0, iMaxInc=100, dInitSize=1.0, dMinSize=1e-5, dMaxSize=1.0, ..., iNlGeom=0, dTimePeriod=1.0, ..., iExtrapolateMethod=1, iAcceptByMaxIters=0, listOutput=[], crEdit=None)` → cursor
- `ModalStep(strName, strDesp="", iEigenSolver=0, ..., iNEigenRequest, iMaxItersUsed=30, iVectorsUsed, iMethod, iMatrixStorage, iNormalizeEigenBy=1, ..., abaqusOutputRequest=[], crEdit=None)` → cursor
- `TransientStep(strName, strDesp="", iEnableAutomatic=0, iMaxInc=0, dInitSize, dMinSize, dMaxSize, ..., iEnableNlgeom=0, dTimePeriod, ..., listAbaqusOutputRequest=[], crEdit=None)` → cursor
- `SteadyStateStep(strName, strDesp="", iAutomatic=0, iMaxInc=100, ..., endStepTemp=ABAQUS_PAIR(), dMaxAllowEmissivityChange=0.1, ..., listAbaqusOutputRequest=[], crEdit=None)` → cursor
- `DynamicExplicitStep(strName, strDesp="", iEnableAutomatic=1, iIncrmtEstimator=0, abaqusPair1=ABAQUS_PAIR(), dTimeScalfactor=1.0, abaqusPair2=ABAQUS_PAIR(), iEnableNlgeom=1, dTimePeriod=1.0, ..., listAbaqusOutputRequest=[], crEdit=None)` → cursor
- `CoupledTDStep(strName, strDesp="", ..., abaqusPair1=ABAQUS_PAIR(), abaqusPair2=ABAQUS_PAIR(), ..., listAbaqusOutputRequest=[], crEdit=None)` → cursor
- `DynamicCoupledTDExplicitStep(strName, strDesp, iEnableAutomatic, iMaxSizebchecked, dlMaxSizeTList, iIncrmtEstimator, iUserTimeIncrmtbchecked, dlUserTimeIncrmtTList, dTimeScalfactor, iEnableNlgeom, dTimePeriod, dLinearBlkVisco, dQuadrBlkVisco, listAbaqusOutputRequest, crEdit)` → cursor
- `StaticRiskStep(strName, strDesp="", ..., dTotalArcLength=1.0, iExtrapolateMethod=0, ..., listOutput=0, crEdit=None)` → cursor — Riks arc-length method

---

## Module: Analysis/Nastran.py

Tất cả cùng signature, trả về cursor `NastranJob`.

- `LinearStatic(strName="Job_1", strDescription="", crlTargets=[], nastranAnalysis=NASTRAN_ANALYSIS(), bDummyPropAutoAssign=True, iDummyPropMaterialID=0, crEdit=None, strPath="", iModelCheckAnswer=0, iDeleteSlaveNodesAnswer=0)` → cursor
- `NormalModes(...)` → cursor — modal analysis
- `LinearBuckling(...)` → cursor — buckling analysis
- `Transient(...)` → cursor — transient dynamic
- `SteadyState(...)` → cursor — frequency response (steady state)
- `ModalFrequencyResponse(...)` → cursor
- `ModalTransientResponse(...)` → cursor

---

## Module: Post/Calculation.py

- `PeakSearch(iOption=0, dParam=0.1, bStep=False)` → list[Node cursor]
  - Description: tìm nodes có giá trị kết quả cực đại/cực tiểu
  - Key params: `iOption` — loại peak search; `dParam` — threshold; `bStep` — tìm theo step hay toàn bộ

---

## Module: Utility.py

- `FindEntities(strTarget, strFindType, bFindMatch=False)` → list[cursor]
  - Description: tìm entities theo tên/loại; `strTarget` = tên entity, `strFindType` = loại ("Part", "Face"…)
- `MeasureDistanceBy2Edges(crEdgeFirst, crEdgeLast, iPrecision=6)` → float
  - Description: đo khoảng cách giữa 2 edges

---

## Module: Tools/Group.py

- `CreateGroup(strGroupName, crlTargets=[], crEdit=None)` — tạo group từ danh sách entities
- `DeleteGroupEntity(crlGroups, bRemoveAll=False, iDelFlag=-1)` — xóa entities khỏi group (hoặc xóa cả group nếu `bRemoveAll=True`)

---

## Cursor Type IDs — Quick Reference

| typeId | Tên | Dùng khi |
|---|---|---|
| 3 | Part | mesh part |
| 5 | Edge | CAD/mesh edge |
| 6 | Face | mesh face |
| 10 | Node | node |
| 11 | Elem | element |
| 12 | RefPart | CAD part reference (CADProjection.Face) |
| 14 | RefEdge | CAD edge reference (NodeToEdge) |
| 15 | RefFace | CAD face reference (NodeToFace, FaceToFace) |
| 22 | Material | material |
| 27 | Coord | coordinate system |
| 28 | LoadCase | load case |
| 79 | Group | group |
| 82 | Property0DMass | mass property |
| 83 | Property1DBar | bar property |
| 84 | Property1DBeam | beam property |
| 87 | Property2DShell | shell property |
| 89 | Property3DSolid | solid property |
| 98 | ConnectRbe2 | RBE2 |
| 102 | ConnectRbe3 | RBE3 |
| 111 | ContactAbaqus | Abaqus contact |
| 110 | ContactMSCNastran | MSC Nastran contact |
| 147 | NastranJob | Nastran job cursor |
| 143 | AbaqusJob | Abaqus job cursor |

---

## site-packages: jpt & dwg — Framework UI thứ hai (PySide2-based)

Source: `C:\Program Files\TechnoStar\Jupiter_5.0.4\Lib\site-packages\`

> **Lưu ý quan trọng:** Đây là framework UI *khác* với `pyjdg`. `pyjdg` (JDGCreator) là Qt-native dialog đơn giản. `dwg`+`jpt` là framework wizard/dialog declarative dựa trên PySide2 — mạnh hơn, có multi-page wizard, data binding, JSON persistence.

---

## Module: jpt/jpt.py (`import jpt`)

Entry point kết nối PSJ macro với Qt UI framework `dwg`.

- `init(JPT_)` — inject JPT object thật vào module (gọi ở đầu script)
- `get()` → JPT object hiện tại
- `print_(text)` — in ra Jupiter console (`JPT.MsgOut`)
- `launch(command, nonblock=False)` — mở Wizard hoặc Dialog từ `Command`/`Section` class; tự detect JPT context
  - Key params: `command` = subclass của `dwg.Command` (wizard) hoặc `dwg.Section` (dialog đơn trang)
- `getAll(typeId)` → list[DItem] — lấy tất cả entity theo typeId (`jpt.FACE`, `jpt.NODE`…)
- `getLastCursor(typeId=-1)` → list[DItem] — lấy cursor vừa tạo, filter theo typeId nếu cần
- `getSelection(*types)` → list[DItem] — lấy selection hiện tại, filter theo typeIds
- `isSelected(targets)` → bool — kiểm tra có entity thuộc `targets` typeIds đang được chọn không
- `toCursorString(elements)` → str — list DItem → `"[6:10, 6:11, 10:5]"` dạng JPT.Exec string
- `buildMap(data, selection=None)` → dict — data object + cursor string → dict để dùng với Template
- `execute(source, data, targets=None)` — render `string.Template(source)` với data+selection rồi chạy từng dòng qua `JPT.Exec`
  - Key params: `source` = macro string có `$variable`; `targets` = typeIds để filter selection
- `switchSelection(target=None)` — chuyển Jupiter selection mode (`jpt.FACE`, `jpt.NODE`, `jpt.EDGE`…)
- `installSelectionChecker(page, targets)` — gắn timer 250ms vào wizard page, tự enable/disable Apply button theo selection
- `isAlreadyRunning(name)` → bool — kiểm tra command đã mở chưa (tránh mở 2 lần)
- `enter(name)` → context manager `jpt_execution` — quản lý lifecycle của command trong JPT

### jpt.Section (extends dwg.Section)
- `prepare(cls, data)` — xử lý trước khi execute: disabled DoubleField → `NULL_STRING`; EnumField → giá trị string thay vì index
- `opened(cls, page)` — tự động gọi `switchSelection` và `installSelectionChecker` nếu class có `target` attribute

### jpt.constants — typeID constants
```python
import jpt
jpt.FACE    # 6
jpt.NODE    # 10
jpt.ELEM    # 11
jpt.EDGE    # 5
jpt.BODY    # 3  (= Part)
jpt.GROUP   # 78
jpt.MATERIAL # 22
# ... 163 constants tổng cộng, tên UPPER_SNAKE_CASE
```

---

## Module: dwg — Declarative UI Framework

### dwg/fields.py — Field classes (khai báo trong Section)

| Class | Widget tạo ra | Tham số chính |
|---|---|---|
| `DoubleField` | QLineEdit + QDoubleValidator | `initial`, `readonly`, `regex`, `optional` |
| `DoubleSpinField` | QDoubleSpinBox | `initial`, `minimum`, `maximum`, `decimals=16`, `optional` |
| `IntField` | QSpinBox | `initial`, `minimum`, `maximum` |
| `EnumField` | QComboBox | `initial` (index), `choices=[str,…]` |
| `BooleanField` | QCheckBox | `initial=False`, `text` |
| `StringField` | QLineEdit | `initial`, `regex` |
| `FileField` | QLineEdit | `initial`, `regex` |
| `ButtonField` | QPushButton | `initial` (label), `action=callable` |

**Tham số chung** cho tất cả Field: `name` (display label), `group` (indent group), `separator=True` (thêm đường kẻ), `description` (tooltip)

### dwg/section.py — Section, Command, Data

### Section
```python
class MySection(dwg.Section):
    title = "Tên trang"
    description = "Mô tả"
    
    mesh_size  = dwg.DoubleSpinField(name="Mesh Size", initial=5.0, minimum=0.1)
    elem_type  = dwg.EnumField(name="Type", choices=["Quad", "Tri"], initial=0)
    project    = dwg.BooleanField(name="Project to CAD", initial=True)
    
    @classmethod
    def execute(cls, data):           # hoặc execute(cls, data, context) hoặc execute(cls, data, context, page)
        JPT.Exec(f'SurfaceMeshing2D(..., {data.mesh_size}, ...)')
    
    @classmethod
    def opened(cls, page): ...        # gọi khi page mở
    
    @classmethod
    def finished(cls, data, context) -> bool: ...  # validate trước khi Next/Finish
```

### Command (multi-page wizard)
```python
class MyWizard(dwg.Command):
    title    = "My Wizard"
    sections = [Page1, Page2, Page3]
```

### Data
- `data.<field_name>` — đọc/ghi giá trị field
- `data.connect(key, observer)` — đăng ký callback khi `data.key` thay đổi
- `data.setEnabled(key, bool)` — enable/disable field
- `data.isEnabled(key)` → bool

### CommandIO — JSON persistence
- `CommandIO.save(path, command, dataDict)` — lưu tất cả data của wizard ra JSON
- `CommandIO.load(path, command, dataDict)` — load lại giá trị từ JSON

### dwg/views.py — UI containers

- `Dialog(section)` — QDialog đơn trang từ một Section; có OK/Cancel/Apply buttons
  - `dialog.data` — Data object
  - Signal: `closed`, `applied`
- `Wizard(command)` — QWizard multi-page từ Command
  - `wizard.context` — Context object shared giữa các pages
  - `wizard.dataset()` → OrderedDict `{section_name: Data}`
- `FrontPage` — trang chọn path (branching wizard); dùng với `Layout(FrontPage, paths=[Path1, Path2])`
- `Layout(pageClass, **kwargs)` — gắn custom page class vào Section: `MySection.layout = Layout(FrontPage, paths=[...])`
- `getApplyButton(page)` → QPushButton | None
- `installTimer(page, interval_ms, func)` — timer gắn vào page, tự dừng khi page đóng
- `launch(command, nonblock=False)` — standalone launcher (không cần JPT)

### dwg/utils.py
- `connectClosure(signal, func)` — kết nối Qt signal với closure Python (tránh GC issue)
- `invokeLater(func)` — schedule gọi func trên Qt event loop

---

### Pattern sử dụng dwg+jpt (so sánh với pyjdg)

```python
# dwg+jpt: declarative, phù hợp wizard nhiều bước
import jpt, dwg

class MeshSettings(jpt.Section):
    title  = "Mesh Settings"
    target = [jpt.FACE]          # auto-switch selection mode khi page mở
    
    size    = dwg.DoubleSpinField(name="Size (mm)", initial=5.0, minimum=0.1)
    project = dwg.BooleanField(name="Project to CAD", initial=True)
    
    @classmethod
    def execute(cls, data):
        faces = jpt.toCursorString(jpt.getSelection(jpt.FACE))
        JPT.Exec(f'SurfaceMeshing2D({faces}, ...)')

jpt.launch(MeshSettings)   # mở như Dialog đơn trang
```

```python
# pyjdg: imperative, phù hợp dialog đơn trang nhanh
from pyjdg import *
dlg = JDGCreator(title="Mesh", resizable=True)
dlg.add_spin(name="Size", min=0.1, max=100, pos=5, increment=0.5, layout="L1")
dlg.generate_window()
dlg.on_dlg_ok(callfunc=on_ok)
```

---

## tools/ReportingTool — PPT Report Generator

Source: `C:\Program Files\TechnoStar\Jupiter_5.0.4\tools\ReportingTool\`

> Bộ scripts tạo báo cáo PowerPoint từ kết quả FEA. Phụ thuộc `gen_report_lib.pyo` (compiled binary — chứa class `PPT`).

**Chạy từ command line:**
```
python gen_report_linear_static.py <anything> <csv_conf_file>
python gen_report_modal.py         <anything> <csv_conf_file>
python gen_report_overall.py       <anything> <csv_conf_file>
```

---

### PPT class (từ gen_report_lib — inferred từ usage)

```python
ppt = PPT(visible=True)          # mở PowerPoint, visible=False = headless
ppt.addSlide()                   # thêm slide mới
ppt.addTextbox(text, left, top, width, height, align)   # align: 1=left, 2=center
ppt.addPicture(fpath, left, top, width, height)         # chèn ảnh
ppt.addTSVFile(fpath, left, top, width, height)         # chèn file TSV dạng bảng
ppt.addTable(datas, colors, row, column, left, top, width, height)
# datas = [[title_row], [row1], [row2]…]
# colors = list of [color_per_cell] — 'White', 'Black', 'Red' hoặc RGB tuple
ppt.saveAs(filepath)             # lưu file .pptx
ppt.quit()                       # đóng PowerPoint (dùng khi visible=False)
```

**Tọa độ:** đơn vị pixel, gốc top-left của slide. Slide chuẩn = 840×630px.

---

### Module: gen_report_linear_static.py

Tạo báo cáo Linear Static — stress/displacement theo từng Part.

**CSV config format:**
```
Project Name, <tên project>
Temp Directory, <thư mục chứa ảnh pic/>
Calculate Value, Mises          # Mises | Maximum principal | Minimum principal | Displacement
Evaluation Value, A/B           # A/B | B/A
Language, JAPANESE              # tùy chọn — dịch label sang tiếng Nhật
PPT Visible, False
Export File Path, output.pptx
Mesh Info, <elem_count>, <node_count>
Condition Names, Case1, Case2
Whole Item, <std_val>, <res_val>, <subcaseNo>
Part Item, <part>, <prop>, <mat>, <std_val>, <res_val>, <subcaseNo>
Original Image Size, <w>, <h>
```

**Luồng slide:** Cover → Table (part/prop/mat/value) → Condition (ảnh BC + mesh) → All-model image → Per-part images

**Ảnh cần có trong `<TempDir>/pic/`:**
- `all_cond1.1.jpg` — boundary condition
- `all_mesh1.1.jpg` — mesh view
- `all_mdl1.1.jpg`, `all_pic1.1.jpg`, `all_pic_zoom1.1.jpg` — overall result
- `mdl{i}.1.jpg`, `pic{i}.1.jpg`, `pic_zoom{i}.1.jpg` — per-part result (i=1,2…)

---

### Module: gen_report_modal.py

Tạo báo cáo Normal Modes — mode shapes + eigenfrequency table.

**CSV config format:**
```
Project Name, <tên>
Temp Directory, <dir>
Results in one page, 4          # 1 | 2 | 4 | 6 ảnh/slide
PPT Visible, False
Export File Path, output.pptx
Mode Item, <mode_no>, <freq_Hz>
Original Image Size, <w>, <h>
```

**Luồng slide:** Cover → Mode/Frequency table (tối đa 20 modes/cột) → Mode shape images (N/slide)

**Ảnh:** `pic/pic{n}.1.jpg` (n = 1, 2, 3…)

---

### Module: gen_report_overall.py

Tạo báo cáo tổng hợp (overall) — nhiều result types/steps.

**CSV config format:**
```
Project Name, <tên>
Temp Directory, <dir>
Results in one page, 4
Mode Item, <process>, <step>, <time>, <resultType>, <resultName>
Original Image Size, <w>, <h>
```

**Luồng slide:** Cover → Result list table → Images (N/slide)

---

### Module: pre_general_report.py

Pre-processing: expand wildcard patterns trong CSV config bằng `fnmatch`.

- `parse_mat_part_list_file(list_f)` → `MatProps` — đọc file danh sách Part/Material/Property và quan hệ giữa chúng
- `main()` — nhận `<list_file> <input_csv> <output_csv>`, expand `Part Item` rows từ pattern `*` thành các dòng cụ thể

**MatProps attributes:** `.parts[]`, `.mats[]`, `.props[]`, `.prop_part_d{}` (prop→part), `.mat_props_d{}` (mat→[props])

---

## SampleData Utility Scripts

Source: `C:\Program Files\TechnoStar\Jupiter_5.0.4\SampleData\PSJ\PSJ-Utility\Utils\`

---

## Module: PSJ_Interpreter.py

Kết nối external Python IDE với Jupiter GUI đang chạy qua Windows IPC (WM_COPYDATA).

- `RUN_FILE(filePath, activeJupiter)` — gửi file .py để Jupiter thực thi; `activeJupiter=True` → bring Jupiter to foreground
  - Key params: `filePath` = đường dẫn tuyệt đối tới .py file
- `RUN_CODE(line, activeJupiter)` — gửi một dòng/block code string để thực thi ngay
- `RUN_DEBUG(line, activeJupiter)` — gửi lệnh ở debug mode (không blocking)
- `SendMessageToJupiter(sendMsg)` — low-level: tìm PID `DCAD_main.exe`, gửi WM_COPYDATA

### JupiterListener
- `JupiterListener()` — tạo win32 hidden window để nhận response từ Jupiter
  - `OnCopyData(hwnd, msg, wparam, lparam)` — xử lý message trả về từ Jupiter, in ra stdout

**Dùng từ command line:**
```
python PSJ_Interpreter.py <filePath> <True|False>
```

---

## Module: JPTModule.py

- `GetAllPartsWrapper()` → list — wrapper cho `JPT.GetAllParts()`, dùng khi cần gọi từ context không có JPT trực tiếp

---

## Module: Logger.py

### PrintFile
- `PrintFile.print_file(write_to_file, in_str)` — append một dòng vào log file; silent fail nếu không mở được file

---

## Module: Sorts.py

### SortAlgorithms
General-purpose sort utilities (không liên quan PSJ trực tiếp, dùng làm tham khảo thuật toán).

- `SortAlgorithms(arr)` — khởi tạo với list cần sort
- `bubble_sort()` → list — O(n²), so sánh cặp kề
- `selection_sort()` → list — O(n²), chọn min lặp
- `insertion_sort()` → list — nhanh hơn bubble/selection với list gần sorted
- `merge_sort(array)` → list — O(n log n), stable
- `quick_sort(array, begin=0, end=None)` → list — O(n log n) average

---

## Module: External_Create_Cube.py / External_Meshing.py

Sample scripts minh họa cách gọi `JPT.Exec` trực tiếp (không qua macro wrapper):

```python
# External_Create_Cube.py
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')

# External_Meshing.py — flow: xóa chamfer → set mesh attr → mesh
JPT.Exec('DelCircChamfer([3:1], 0.001, 5e-05)')
JPT.Exec('SetMeshAttrib([3:1], {0.03, 0.045, 0.001, 1, ...})')
JPT.Exec('SurfaceMeshing2D([3:1], {...}, 1, 0, 4, 1, 0, 65280)')
```

**SURFACE_MESH native format** (từ External_Meshing.py):
```
{elemSize, maxElemSize, minElemSize, elemType, angleMin, angleMax, aspectRatio,
 minJacobian, maxJacobian, ..., iParallel, maxNodes, ...}
```
→ 28 giá trị; dùng `SURFACE_MESH()` Python object thay vì build string thủ công.

---

## JPT API — Hàm thường dùng & Gotchas

### JPT utility functions
```python
JPT.GetSelectedFaces()          # → list[DItem]
JPT.GetSelectedNodes()          # → list[DItem]
JPT.GetAllSelected()            # → list[DItem] (tất cả loại)
JPT.ClearAllSelection()
JPT.GetInternalIDRefItem(JPT.DItemType.REF_FACE, face_ext_id)  # → int (int_id)
```

### Auto-build RefFace từ mesh face (không cần user chọn thủ công)
```python
ref_parts = []
for face in JPT.GetSelectedFaces():
    int_id = JPT.GetInternalIDRefItem(JPT.DItemType.REF_FACE, face.id)
    ref_parts.append(f"15:{face.id}-{int_id}")
auto_ref = "[" + ", ".join(ref_parts) + "]"
JPT.Exec(f'CadProject_NodeToFace({auto_ref}, {nodes_str}, 0, 0, -1, 0)')
```
> `face.id` == RefFace `ext_id`; `int_id` là giá trị khác lấy qua `GetInternalIDRefItem`

### DItem attributes — Face (typeID=6)
| Attribute | Giá trị |
|---|---|
| `.id` | ext_id (= RefFace ext_id, cùng số với mesh face ID) |
| `.key` | bằng `.id` |
| `.typeID` | 6 |
| `.nodes` | nodes thuộc face |
| `.edges` | edges thuộc face |
| `.elems` | elements thuộc face |

### DItem attributes — Node (typeID=10)
| Attribute | Giá trị |
|---|---|
| `.id` | node ID |
| `.typeID` | 10 |
| `.isFloating` | 0=attached, 1=floating |
| `.pos` | `TVector3d` object — **KHÔNG subscriptable** |

```python
# ĐÚNG:
x, y, z = node.pos.x, node.pos.y, node.pos.z
# SAI: node.pos[0] → TypeError
```

### AssociatedPick — lấy nodes từ mesh faces
```python
MainWindow.RightClick.AssociatedPick(
    crlInput=[Face(229015280, 229015281)],  # mesh faces
    strTarget="Node"                         # "Node" | "Face" | "Edge"
)
```
> Dùng trước `NodeToFace` để tự động lấy nodes từ face được pick.  
> **Lưu ý:** AssociatedPick KHÔNG hỗ trợ target `"RefFace"` hay `"CadFace"`.

### Type prefix trong JPT.Exec string
| Prefix | Loại |
|---|---|
| `6:{id}` | Face (mesh face) |
| `10:{id}` | Node |
| `15:{ext_id}-{int_id}` | RefFace (CAD face) |

---

## pyjdg — Chi tiết tham số bổ sung

### `add_button` — đầy đủ tham số
```python
dlg.add_button(
    name, layout,           # bắt buộc
    text="",
    width=0, height=0,
    text_color=0,           # int RGB packed
    bk_color=15790320,      # int RGB packed, default = xám nhạt
    img="",                 # đường dẫn icon
    location="left",        # "left" | "right" | "top"
)
```

### `add_spin` — đầy đủ tham số
```python
dlg.add_spin(
    name, min, max, pos, increment, layout,  # bắt buộc
    type=spin.integer,      # spin.integer | spin.double
    precision=1,            # số chữ số thập phân (chỉ với spin.double)
)
```

### `set_item_size_behavior` — resize behavior
```python
dlg.set_item_size_behavior(
    name="Table1",
    behavior=size_behavior.greedy     # co giãn theo dialog (default)
    # size_behavior.fixed             # cố định
    # size_behavior.horizontal        # chỉ co giãn ngang
    # size_behavior.vertical          # chỉ co giãn dọc
)
```
> Áp dụng cho: `TabWnd`, `ImageCtrl`, `Table`, `PagesCtrl`. KHÔNG áp dụng cho Button/Label/Spin.

### `set_item_font`
```python
dlg.set_item_font(name="Lbl1", font=PSJFont())
```

### `set_spin_value` — KHÔNG TỒN TẠI ⚠️
`JDGCreator` **không có** method `set_spin_value`. Gọi sẽ raise `AttributeError`.  
Spin widget không thể cập nhật lại giá trị hiển thị sau khi dialog đã mở.

### Color — RGB packed int
```python
# R*65536 + G*256 + B
GREEN   = 5025616   # 0x4CAF50
RED     = 13382451  # 0xCC3333
WHITE   = 16777215  # 0xFFFFFF (chữ trắng)
DEFAULT = 15790320  # 0xF0F0F0 (xám mặc định)
```

### Căn chỉnh label trong hlayout
```python
LW = 230  # chiều rộng cố định cho tất cả label → spin boxes thẳng hàng
dlg.add_label(name="LblA", text="Aspect ratio:", width=LW, layout="row")
dlg.add_spin(name="SpAspect", ...)
```

### `add_space` — spacer co giãn
```python
dlg.add_space(layout="row", orientation="horizontal", size=0)
# size=0 = auto-expand spacer → đẩy nội dung về 2 phía
```
