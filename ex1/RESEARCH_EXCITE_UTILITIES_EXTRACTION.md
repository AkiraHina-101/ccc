# EXCITE — dữ liệu lấy được qua API và Utilities

Ngày kiểm chứng: 2026-10-04. Nguồn chính là mã Python/tài liệu chính thức đi kèm AVL trên máy này. Đã chạy thực tế một client riêng ở hidden mode để đọc `simple_body.ex`; không gọi setter, SaveModel hoặc RunJob. Kết quả là trạng thái file đã lưu, không phải những thay đổi chưa lưu trong phiên GUI của người dùng.

## Kết quả chạy thực tế

Script: `scripts\probe_ex_utilities_readonly.py`.

```powershell
& '<AVL_ROOT>\bin\aws_cmd.exe' `
  '.\scripts\probe_ex_utilities_readonly.py' `
  '<MODEL_EX_PATH>'
```

Hai lượt chạy hoàn tất exit code 0. AVL ghi một cảnh báo `TypeError: 'NoneType' object is not callable ... ignored` trong quá trình load; chưa xác định nguồn cảnh báo. Các checks dưới đây đều trả status `ok`; cảnh báo không chặn kết quả nhưng không nên coi model đã được kiểm tra toàn bộ tính hợp lệ.

| Nhóm | Kết quả thực tế | API đã dùng |
|---|---|---|
| Operating speed | 2000 rpm | `GetClass('CTrain','ctrain').GetDblValueU('general.speed','rpm')` |
| Solver timestep | 1e-6 s | `GetClass('Solctr','solctr').GetDblValueU('param.timestep.dt','s')` |
| Timestep min/max | 1e-8 / 1e-5 s | cùng class, `param.timestep.min` / `param.timestep.max` |
| Simulation storage range | 0–1439.9999999999714 deg; 0–0.11999999999999761 s | `excModel.get_simulation_control().get_data_storage_interval(unit)` |
| Results Control | type ANGR; output STORED; begin 0; end 1439.9999999999714; increment 1; vertical-axis code 3 | `get_results_control().get_control_parameters()` |
| Unit system | N-mm-s | `get_unit_system_used()` |
| Crank-train axes | rotational [1,0,0]; vertical [0,0,1] | `get_crank_train_orientation()` |
| Case | Excite Set 1 / Case 1 | `GetCaseSets`, `GetActiveCaseSet`, `GetActiveCase` |
| Elements | Crankshaft1: code 2, name body; ROTx_1: code 3, name joint; cả hai ASE (`IsACT()==0`) | `GetElements`, metadata getters |
| Topology | 1 line: Crankshaft1 → ROTx_1 | `GetLines`, `GetStartElement`, `GetEndElement` |
| Parameters | 7 global tên `_UNITS_*`; cả hai element có danh sách parameter rỗng | `GetParameters` trên model/element |
| Parameter groups | danh sách rỗng | `GetParameterGroups(case_set)` |
| Body references | mesh path rỗng; joint-node và loaded-node mapping rỗng | `get_condensed_mesh_file`, `get_all_nodes_used_by_connected_joints`, `get_loaded_nodes` |
| HD bearing | không có trong model này | `get_hd_joints()` trả [] |

Results Control wrapper không ghi unit riêng trong dict. Trong lần thử ANGR này giới hạn khớp giá trị theo góc; khi output type khác cần kiểm tra unit theo schema, không tự coi mọi `begin_time/end_time` là giây. Các giá trị float gần 1440°/0.12 s là sai số biểu diễn.

## Bề mặt dữ liệu xác nhận từ mã AVL

Các đường dẫn bên dưới tương đối với `<AVL_ROOT>\AWS\python\`.

| Nhóm có thể lấy | Hàm/đường truy cập | Dẫn chứng trong source | Trạng thái |
|---|---|---|---|
| Global/case parameters, expression evaluated, unit, standard/favorites filters | `Model.GetParameters`, `GetEvaluatedParameter`, `GetParameterUnit`, filtered getters; case getters | `WS.py:1092`, `1184`, `1351`, `1481` | Global/case inventory đã chạy; filters/evaluated chưa thử |
| Case parameter groups | `GetParameterGroups`, `GetParameterGroupParameters` | `WS.py:1611`, `1623`; `common_caseExplorer.py` | Group inventory đã chạy |
| Simulation storage/control | `excModel.get_simulation_control`; `Solctr/solctr` | `clients/excite/excWS.py:603`, `768` | Đã chạy range và timestep |
| Results output controls | `excModel.get_results_control`, `get_control_parameters` | `clients/excite/excWS.py:635`, `780` | Đã chạy |
| Unit system, rotational/vertical axes | `get_unit_system_used`, `get_crank_train_orientation` | `clients/excite/excWS.py:792`, `824` | Đã chạy |
| Body condensed mesh file | `excBody.get_condensed_mesh_file` | `clients/excite/excWS.py:29` | Getter đã chạy; mẫu không có file |
| Body/node connectivity, load item → nodes | `get_all_nodes_used_by_connected_joints`, `get_loaded_nodes` | `clients/excite/excWS.py:71`, `96` | Getter đã chạy; mẫu trả mapping rỗng |
| Body/joint/HD/ACYG lists | `get_bodies`, `get_joints`, `get_hd_joints`, `get_acyg_joints` | `clients/excite/excWS.py:673–751` | Body/joint/HD đã chạy |
| Bearing radius/width, grid size, body IDs, location/orientation/d0/d90 | `excHDJoint.get_HD_grid_data('profile1'/'profile2')` | `clients/excite/excWS.py:525` | Implementation xác nhận; chưa có HD mẫu |
| AXHD diameter/clearance/cone/grid | `get_AXHD_bearing_data()` | `clients/excite/excWS.py:569` | Chưa có AXHD mẫu |
| Thermal oil/body conductivity và layer thickness | `get_layer_thickness_and_conductivity_parameters()` | `clients/excite/excWS.py:496` | Chưa có HD mẫu |
| Surface profiles và file references | `get_profiles('profile1'/'profile2')` | `clients/excite/excWS.py:356` | Chưa thử runtime |
| Surface roughness | `get_summit_roughness`, `get_summit_roughness_for_epil` | `clients/excite/excWS.py:399`, `441` | Chưa thử runtime |
| Wear configuration | `get_requested_wear_calc()` → patch count, hardness/wear factor table, acct/maxw/type | `clients/excite/excWS.py:233` | Chưa có wear mẫu; đây là setting, không phải kết quả wear |
| Element metadata/layout | UUID, label/code/text, position/dimension/rotation/anchors | `WS.py:2946–3149` | UUID/label/code đã chạy; layout còn source-level |
| Lines/anchors/connectivity | lines, endpoints, points; anchor owner/connected elements | `WS.py:3480`, `3734–3988` | Lines/endpoints đã chạy |
| Named matrix/list/map data | `GetWSMatrix(name,0)`, `GetWSClassList(name)`, `GetWSMap(name,0)` | `WS.py:1734`, `1753`, `1769`, `2478–2930` | Source-level; phải biết tên field |
| Parameter binding trên field hoặc table cell | `GetAssignedParameter`, `GetAssignedMatrixParameter` | `WS.py:2421`, `2459` | Source-level; quan trọng khi lập Excel mapping |
| ACT object properties | `Element.IsACT`, `GetACTObject`, `get_property` | `WS.py:3174–3198` | Mẫu là ASE, chưa thử ACT properties |
| Embedded data của client | `GetEmbeddedSection(key)`, length | `WS.py:988`, `1000` | Phải biết key; không bảo đảm mọi model có section |
| Export nguyên class ra file | `WSClass.Write(filename)` | `WS.py:1699` | API xác nhận; chưa thử nội dung export |

WSMatrix/WSMap access phải giải phóng handle bằng `ReleaseHandle()` kể cả khi chỉ đọc. WSClassList thực tế dùng `Release()` (docstring cấp WSClass ghi ReleaseHandle không khớp wrapper). Mode `change=0` đọc; mode 1 và setters là workflow ghi, chưa sử dụng trong probe.

## Utilities trong menu đang làm gì

Đã đọc registry built-in `AWS\python\excite_py_script.ini` và implementation case utilities.

- **Export Case Table to HTML/XML:** lấy global/case parameters, unit và case/parameter groups qua WS API (`caseExplorerHTML.py`, `caseExplorerXML.py`, `common_caseExplorer.py`). Đây là xuất case table; không phải export toàn bộ physics settings của `.ex`.
- **Explore Active Case Directory / Open Shell:** lấy model filename và active case/set rồi dựng đường dẫn thư mục. Đây là điều hướng tới dữ liệu liên quan; thư mục chứa solver/results không nằm hoàn toàn trong `.ex`.
- **Unbalance / Create Flywheel Whirl Results / Convert Total Forces and Moments to FEM:** registry xác nhận chúng là utility riêng. Các tùy chọn GIDAS/ImpressChart, GID input, node IDs và FFT windows cho thấy có phần xử lý kết quả hoặc tính toán; chưa chạy chúng và chưa xác nhận mọi input field. Không dùng chúng làm bằng chứng rằng `.ex` chứa sẵn time histories của force/moment/whirl.
- **Rescale ASCII STL:** xử lý file STL ngoài model; không phải API dump settings.
- **Job Status – Admin View:** job manager status; không phải thuộc tính physics của `.ex`.
- **Planetary Gearset Phasing / Retained Nodes for FlexACYG and E-Machine:** có utility riêng trong registry; cần inspect từng implementation và model gear phù hợp trước khi kết luận dữ liệu/side effect.

Các scripts built-in có cả đọc, tạo dữ liệu và thay đổi model. Không nên thực thi tất cả Utilities để khảo sát; dùng getter đã đọc source và output probe.

## Đọc `.ex` trực tiếp mở rộng được gì?

`simple_body.ex` là text, có các section CONTROL, MODEL, ADDON. MODEL chứa graph elements/anchors/line; ADDON chứa cấu trúc ASE lồng nhau, scalar có kiểu/unit, arrays và named class/instance. Đã thấy các global class `ExciteOpt`, `CTrain`, `Load`, `Solctr`, `Resctr`, `FeaTasks`, `FeaSolverSettings`, `CooSysList`, `NodeSets`, `UtilBatchList`. Body chứa bảng mass/center-of-mass/inertia và damping fields; joint chứa nhiều block cấu hình cho các loại joint.

Điều này cung cấp cách dò **tên field/path** mà API không enumerate. Có thể xây parser read-only để inventory mọi field của file đã lưu và đối chiếu với WSClass getters. Tuy nhiên một field tồn tại không chứng minh nó đang active: mẫu ROTx vẫn lưu nhiều cấu hình joint khác dưới dạng default/inactive branches, có INF và dữ liệu rỗng. Cần xét type selection/enable flags/parameter binding và case để phân biệt effective settings với dữ liệu lưu trữ. Parse file cũng không thấy thay đổi chưa save trong GUI.

Không sửa trực tiếp text `.ex` trong lượt nghiên cứu này. XML exporter của case table cũng không biến toàn bộ model thành XML.

## Điều chỉnh kết luận về khả năng can thiệp

1. **Element named parameters có setter chính thức:** `Element.SetParameter(name,value,unit)` ở `WS.py:3278`. Nó có thể tạo parameter nếu chưa có. Chưa kiểm thử ghi; empty named-parameter list không nghĩa element không có settings.
2. **WSClass phải dùng đúng method:** `element.GetClass()`; getter theo kiểu `GetIntValue/GetStrValue/GetDblValue/GetDblValueU`, không phải các method ví dụ `GetWSClass()/GetValue()` trong ghi chú cũ.
3. **Có setter cho field/matrix/map/binding:** `SetValue`, typed setters, matrix/map setters, `AssignParameter`, `AssignMatrixParameter`. Setter tồn tại không đồng nghĩa đã xác minh ghi các setting cụ thể.
4. **Save As được hỗ trợ:** `Client.SaveAsModel(filename)` ở `WS.py:839`, thuận tiện khi test bản copy.
5. **Bẫy wrapper:** `excite_WS.py` dòng 799 dùng `param not in self._model.GetParameters` thiếu dấu gọi hàm ở nhánh tạo override mới. Không dùng wrapper dict đó để ghi khi chưa sửa/kiểm chứng; ưu tiên WS primitives. Một số wrapper `get_bodies/get_joints` bắt mọi exception và trả [] nên list rỗng trên model khác không tự chứng minh không có body/joint.

## Hướng phát triển tiếp có căn cứ

Browser có thể bổ sung tab Simulation/Results Control, Unit/Axes và graph/body/joint references từ các getter đã test. Với model HD phù hợp có thể thêm Bearing/Thermal/Profiles/Wear. Cần bước riêng để parser inventory ASE fields + allowlist schema; từ đó mới lập mapping Excel gồm scope, class/instance, field path, datatype, unit, case, binding và active flag. Những setting như speed và timestep đã có đường getter chính xác để làm thử nghiệm write sau này.

Bản `scripts/EXCITE_SettingsBrowser.py` trong gói dùng `aws_dialog.BaseUtility`, lấy từ bản deploy đã sửa. Browser chưa được xác nhận mở GUI thành công; kiểm tra trên máy nhận theo README.
