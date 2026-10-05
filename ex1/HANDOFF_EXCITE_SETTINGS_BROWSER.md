# Handoff — EXCITE Settings Browser và phạm vi điều khiển `.ex`

Ngày lập: 2026-10-04  
Đích: người tiếp quản phát triển GUI đọc/ghi setting EXCITE Power Unit thông qua AVL Workspace API.

## Tóm tắt trạng thái

Đã tạo một Python GUI chạy bên trong EXCITE, đọc model đang mở và có thể lọc/xuất CSV. Script hiện tại **chỉ đọc**; không có nút sửa, không gọi `SetParameter`, `SetCaseParameter`, `WSClass.SetValue` hay `SaveModel`. Vì vậy nó là công cụ khảo sát API/dữ liệu, chưa phải công cụ điều khiển setting.

Menu đăng ký đúng đã được cài vào profile người dùng:

```text
<AWS_USERHOME>\python\excite_py_script.ini
<AWS_USERHOME>\python\EXCITE_SettingsBrowser.py
```

Source được giữ trong workspace:

```text
scripts\EXCITE_SettingsBrowser.py
scripts\excite_py_script.ini
```

`excite_py_script.ini` phải mang đúng tên dành cho client `excite`; file `EXCITE_SettingsBrowser.ini` với tên tùy chọn trước đó không được menu loader nhận diện. Menu custom được nạp lúc khởi động EXCITE: lưu model, đóng/mở lại EXCITE rồi tìm **Utilities → Python Scripts → EXCITE Settings Browser**. Không tự đóng phiên EXCITE của người dùng khi model có thể chưa lưu.

## GUI đã làm gì

Script dùng Python 2.7/PyGTK đi kèm AVL và chạy trong process EXCITE. `WS.GetActiveClient()` lấy client hiện hành; `client.GetModel()` lấy model đang mở. Cửa sổ có bảng Scope/Object/Setting/Value/Unit/API coverage, tìm kiếm, Refresh và Export CSV. Nó liệt kê:

- Global parameters qua `GetParameters`, `GetParameter`, `GetParameterUnit`.
- Case sets, cases và override parameters qua `GetCaseSets`, `WithCaseSet`, `GetCases`, `WithCase`, `GetCaseParameters`, `GetCaseParameter`.
- Elements qua `GetElements`, tên/nhãn/class/code, và thử `GetParameters`, `GetParameter`, `GetParameterUnit` trên mỗi element.
- Dòng ghi chú cho WSClass, nhưng không tự enumerate toàn bộ field lồng nhau vì API không cung cấp schema enumeration tổng quát.

Entry dùng `<options auto="yes" args="" dialog="yes"/>`. Gói này chứa bản browser đã dùng `aws_dialog.BaseUtility`. Khi phát triển tiếp, đối chiếu `<AVL_ROOT>/AWS/python/aws_dialog.py` và utility cùng release. Cách cài portable nằm trong README_START_HERE.md của gói.

## Đã kiểm chứng API và khả năng ghi

Nguồn cục bộ chính: `API.md`, AVL `tools\impresschart\python\WS.py`, `documentation\COMMON\AWS_Python_Scripting\topics\` và `documentation\COMMON\EXCITE_PowerUnit_UsersGuide\topics\`. Ghi chú project nói các API dưới đây đã đối chiếu implementation/docs; vẫn cần chạy thử trên bản sao model của user trước khi coi thao tác là an toàn trong workflow.

### Tương đối chắc chắn: global parameters

```python
names = model.GetParameters()
value = model.GetParameter(name)
unit = model.GetParameterUnit(name)
model.SetParameter(name, str(value))
# nếu đổi unit: dùng đúng unit key của parameter
model.SetParameter(name, str(value), unit_key)
model.CreateParameter(name, str(value), unit_key)  # tạo parameter mới; cần xác minh điều kiện áp dụng
```

Đây là bề mặt ghi rõ nhất. API lưu giá trị dưới dạng chuỗi; không nên tự đoán unit, tên parameter, expression syntax hoặc cho phép tạo parameter tùy tiện. Một số giá trị có thể là expression; dùng `GetEvaluatedParameter` để tách giá trị được tính khỏi biểu thức gốc.

### Tương đối chắc chắn: case overrides/case structure

Sau khi chọn đúng context:

```python
model.WithCaseSet(case_set_name)
model.WithCase(case_name)
model.SetCaseParameter(name, str(value))
```

Ngoài sửa override đã có, tài liệu liệt kê `NewCaseParameter`, `DeleteCaseParameter`, `DeleteAllCaseParameters`; case-set API còn có New/Copy/Delete case/set, ActivateCase, `SetCaseSetEditable`. Các thao tác cấu trúc này tác động rộng hơn sửa một con số; chưa được đưa vào GUI và cần kiểm tra editable state, bản sao, cùng semantics của model trước khi cung cấp cho người dùng. Xóa override có thể khiến case kế thừa global value.

### Có thể ghi object-level nhưng chưa an toàn để expose hàng loạt

```python
element = next(e for e in model.GetElements() if e.GetLabel() == element_label)
ws_obj = element.GetClass()
old = ws_obj.GetDblValue(field_path)  # hoặc GetIntValue/GetStrValue theo schema
ws_obj.SetValue(field_path, new_value)
sub = ws_obj.GetClass(subclass_name)
sub.SetValue(field_name, new_value)
```

Đây là cách đọc/ghi WSClass field theo **field path đã biết**. AVL cảnh báo data model có thể đổi giữa release; không thấy API chung để enumerate mọi nested field/schema, enum hợp lệ, unit, constraint hay dependency. Vì vậy “setting nào đó hiển thị trong element dialog” chưa đồng nghĩa API có thể sửa nó an toàn. Trước mỗi field cần tra WS docs/schema, thử Get/Set/đọc lại trên bản sao `.ex`, xác minh giá trị trong GUI, save sang file test riêng, đóng/mở lại và kiểm tra model integrity.

Đối chiếu trực tiếp `AWS\python\WS.py:3278` xác nhận `Element.SetParameter(name, value, unit)` tồn tại; setter có thể tạo parameter nếu tên chưa tồn tại. Đây là setter cho named element parameters, không phải toàn bộ setting nội bộ của element. Chưa chạy thử ghi. Không có `Element.GetWSClass()` hay `WSClass.GetValue()` trong wrapper đang cài; dùng `GetClass()` và getter theo kiểu dữ liệu.

### Lưu, chạy và side effects

`client.SaveModel()` ghi thay đổi của model đang gắn với client. Không gọi trong read-only browser. Batch flow có `WS.CreateClient('excite')`, `LoadModel(path)`, sửa, `SaveModel`; API mô tả cả `GetSimManager().RunJob(...)`, nhưng chạy simulation tạo side effects/tốn thời gian và không cần cho chức năng xem setting. Không trộn thao tác chạy job vào GUI setting nếu chưa có xác nhận rõ ràng.

## Cách đã tìm API (để lặp lại)

1. Bắt đầu với API reference/guide đúng version cài đặt, tránh dựa vào tài liệu của release khác. Các bản tổng hợp trong workspace là `API.md`.
2. Dùng `rg` để định vị method trong `WS.py` và wrapper `excite_WS.py`, ví dụ `SetParameter`, `SetCaseParameter`, `GetElements`, `GetWSClass`, `GetValue`, `SetValue`, `SaveModel`, `GetActiveClient`.
3. Tra tutorial HTML đi kèm AVL: pre-processing/launching simulation, utilities tích hợp Workspace GUI, thêm Python script vào menu, truy cập model data, debugging. Đọc nội dung HTML/implementation chứ không chỉ dựa trên tên file.
4. Tách ba câu hỏi: (a) object có thể enumerate không, (b) value có thể read không, (c) value có setter được hỗ trợ không. Chỉ đánh dấu write-capable sau khi thấy setter chính thức và test round-trip.
5. Với GUI đang mở, chạy utility dùng `WS.GetActiveClient()` để khảo sát đúng phiên/model; khi cần batch, chạy trong `aws_cmd` với client riêng. Không dùng standalone Python ngoài AVL để giả lập WSInterface.
6. Kiểm tra syntax bằng Python runtime đúng của AVL (menu utility hiện dùng Python 2.7; install còn Python 3 cho các luồng khác). Parse XML registration và kiểm tra file được tham chiếu tồn tại. Sau đó restart EXCITE để menu được đọc lại và test mở utility.
7. Tất cả thử nghiệm write phải trên bản sao `.ex`, ghi snapshot trước/sau, read-back, mở GUI kiểm tra, `SaveModel` vào output test riêng. Không bắt đầu bằng file duy nhất/production.

## Kế hoạch an toàn để tiến từ browser sang editor

1. Thêm mode mặc định Read-only; có nhãn rõ file/model đang mở và cảnh báo thay đổi unsaved.
2. Với global/case parameters, chọn một setting đã enumerate, hiển thị old value/unit/context; yêu cầu nhập explicit new value. Validate numeric/string và giới hạn chỉ name/value có thật; không tự tạo/xóa.
3. Preview diff trước khi ghi. Tạo backup/copy model bằng API/file workflow đã kiểm chứng; nếu không làm backup đáng tin cậy thì chỉ cho ghi bản sao do user chọn.
4. Gọi setter đúng scope rồi đọc lại ngay; nếu read-back khác kỳ vọng, báo lỗi và không tự SaveModel.
5. Save As/output riêng hoặc lưu bản copy, không âm thầm overwrite file nguồn. Ghi audit CSV gồm model path, timestamp, API, scope/case, old/new/unit và kết quả.
6. Chỉ sau khi global/case ổn định mới xây schema/allowlist theo loại element và release cho WSClass fields. Không tạo UI “mọi setting” dựa trên reflection tùy tiện.

## Mở và chẩn đoán

1. Đảm bảo AVL EXCITE Power Unit đã cài, model `.ex` đang mở.
2. Đảm bảo hai file nằm trong `%AWS_USERHOME%\python` đúng như đường dẫn phía trên; XML script name phải khớp file `.py`.
3. Thoát/mở lại EXCITE (trước đó lưu model). Vào Utilities → Python Scripts → EXCITE Settings Browser.
4. Nếu menu vẫn không có: xác nhận profile mà **process EXCITE này** đang dùng thật sự là `<AWS_USERHOME>`; kiểm tra registry file spelling/encoding/XML, file `.py` tồn tại; xem `Show Last Utility Log...`; cuối cùng dùng AWS Python console/log để in `WS.GetActiveClient()` và đường dẫn user-home. Không xóa file INI cũ khi chưa cần.
5. Nếu menu hiện nhưng cửa sổ lỗi: lấy utility log/traceback. Kiểm tra interpreter (Python 2.7), PyGTK import, API context và model open. Browser không được phép sửa hoặc save.

## Files liên quan

- `scripts\EXCITE_SettingsBrowser.py` — source GUI read-only.
- `scripts\excite_py_script.ini` — template đăng ký menu.
- `%AWS_USERHOME%\python\EXCITE_SettingsBrowser.py` — bản đang deploy.
- `%AWS_USERHOME%\python\excite_py_script.ini` — đăng ký menu đang deploy.
- `API.md` — ghi chú nghiên cứu API, ví dụ write và confidence.
- `scripts\inspect_open_ex_api.py` — script khảo sát API phiên đang mở (đọc).

## Giới hạn kết luận

Phạm vi “có thể kiểm soát setting nào” hiện được trả lời theo tầng:

| Phạm vi | Liệt kê/đọc | Ghi qua API | Độ chắc chắn hiện tại |
|---|---|---|---|
| Global model parameters | Có | `SetParameter`; tạo mới có API riêng | Cao theo API/reference; chưa kiểm thử ghi với file user |
| Case override parameters | Có | `SetCaseParameter`, tạo/xóa override có API riêng | Cao theo API/reference; phải chọn đúng case context |
| Case/case-set cấu trúc | Có | Có các thao tác create/copy/delete/editable/activate | Có API, side effect cao; chưa expose/test trong tool |
| Element parameters | Có thể enumerate/read nếu object hỗ trợ | `Element.SetParameter(name, value, unit)` | Đã xác nhận từ implementation; chưa test ghi |
| Nested WSClass fields (joint/body etc.) | Chỉ field đã biết; enumerate tổng quát không có | `SetValue` theo field path có thể ghi | Trung bình-thấp; schema/release-sensitive, test từng field |
| Mọi control/setting trong toàn bộ GUI EXCITE | Không bảo đảm | Không thể kết luận | Không; API không tương đương toàn bộ giao diện |

“Có method setter” không có nghĩa model rules, dependency, license, solver validity hoặc mọi dạng setting đều được quản lý an toàn. Chỉ cho user chỉnh field có allowlist và round-trip test trên model copy.

## Bổ sung nghiên cứu trực tiếp 2026-10-04

Xem `RESEARCH_EXCITE_UTILITIES_EXTRACTION.md`: đã chạy read-only probe qua `aws_cmd.exe` trên `simple_body.ex` và xác nhận thêm timestep, crank-train speed, simulation/results control, unit system và topology. Kết quả cho thấy 7 global parameters nội bộ, không có named parameters trên hai element, nhưng vẫn đọc được nhiều setting WSClass. `GetParameters()` không đồng nghĩa toàn bộ settings.
