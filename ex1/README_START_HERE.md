# EXCITE → Excel: gói bàn giao cho AI trên máy khác

Ngày đóng gói: 2026-10-05. Phần mềm đã nghiên cứu: AVL EXCITE.

## Mục tiêu của người dùng

Settings EXCITE nhiều và dễ sai. Người dùng muốn xem/kiểm tra dữ liệu tập trung trong Excel, lọc theo model/object/case/nhóm, so sánh Current với Proposed và Apply các thay đổi đã kiểm chứng từ Excel vào model. Ưu tiên dữ liệu đúng object, case, unit, parameter binding và active branch. Refresh không được làm mất Proposed edits.

Đây là gói nghiên cứu và scripts đọc, chưa phải dashboard Apply hoàn chỉnh. Có 193 mục trong chỉ mục chính và 1.388 khai báo schema ứng viên. 21 dòng chỉ mục đã xác nhận đọc runtime trên model mẫu; chưa có write round-trip đã kiểm chứng. Không coi mọi field schema là setting active/ghi được ngay.

## Quy ước đường dẫn portable

- `<AVL_ROOT>`: thư mục cài **một release AVL** trên máy nhận, chứa `bin`, `AWS`, `documentation`. AI phải xác định thư mục này tại máy đó. Không cố định ổ đĩa, Program Files hoặc username.
- `<AWS_USERHOME>`: profile Workspace của người dùng và release đang chạy. Xác định từ cấu hình/session AVL trên máy nhận; không mặc định là thư mục cài phần mềm.
- `<MODEL_EX_PATH>`: model `.ex` do người dùng chọn trên máy nhận, cùng các file phụ thuộc của nó.
- Đường dẫn `scripts/`, `docs/`, `index/` là tương đối với **folder gói này**.
- `<ORIGINAL_WORKSPACE>` nếu xuất hiện trong ghi chú lịch sử chỉ là nơi làm việc cũ, không phải dependency. Source/API tổng hợp cũ ngoài gói không cần để chạy scripts này.

Các placeholder trong tài liệu/CSV là ký hiệu, không phải biến môi trường hoặc đường dẫn chạy trực tiếp. Nguồn CSV dạng `<AVL_ROOT>/AWS/...` cần nối với root thực tế. AI đọc implementation của release trên máy nhận để kiểm tra khác biệt schema/API.

## Nội dung

```text
EXCITE_EXCEL_AI_HANDOFF/
  README_START_HERE.md
  PROMPT_FOR_OTHER_AI.md
  docs/
    HANDOFF_EXCITE_SETTINGS_BROWSER.md
    RESEARCH_EXCITE_UTILITIES_EXTRACTION.md
    EXCEL_EXCITE_DASHBOARD_FEASIBILITY.md
  index/
    EXCITE_CONTROL_INDEX.csv
    EXCITE_SCHEMA_CANDIDATES.csv
  scripts/
    EXCITE_SettingsBrowser.py
    excite_py_script.ini
    inspect_open_ex_api.py
    probe_ex_utilities_readonly.py
    Run-ReadOnlyProbe.ps1
```

Không cần copy thư viện/DLL của AVL từ máy nguồn. Máy nhận dùng phần mềm, Python runtime và documentation cài sẵn của chính máy đó. Gói không kèm model mẫu; kết quả `simple_body.ex` trong tài liệu là evidence lịch sử, không phải kết quả của model máy nhận.

## Thứ tự đọc cho AI

1. README này và `PROMPT_FOR_OTHER_AI.md` để hiểu mục đích.
2. Báo cáo dashboard để hiểu phạm vi, nhánh batch và live, cùng luồng Apply.
3. CSV chính, rồi CSV schema để tra sâu.
4. Báo cáo API và source scripts; đối chiếu `<AVL_ROOT>/AWS/python/WS.py`, `clients/excite/excWS.py`, các header/schema được dẫn trong CSV.

Các báo cáo trong `docs/` là ghi chép nghiên cứu đã chuẩn hóa đường dẫn. Nếu có mô tả bố trí workspace cũ, ưu tiên bố trí trong README này. Browser được đóng gói là **bản deploy dùng `aws_dialog.BaseUtility`**, không phải bản `gtk.Window` cũ. Browser chưa được xác nhận chạy GUI thành công; đọc syntax/source không thay thế thử mở utility trên máy nhận.

## Chạy probe đọc file đã lưu

AI xác định `<AVL_ROOT>` và `<MODEL_EX_PATH>`, rồi chạy từ folder gói:

```powershell
.\scripts\Run-ReadOnlyProbe.ps1 -AvlRoot '<AVL_ROOT>' -ModelPath '<MODEL_EX_PATH>'
```

Thay placeholders bằng đường dẫn thực tế. Launcher kiểm tra `bin/aws_cmd.exe` và file model, rồi gọi script bằng đường dẫn được suy ra từ vị trí gói. Không cần sửa code theo đường dẫn máy nhận.

Probe tạo client EXCITE riêng, hidden, đọc model đã lưu và in JSON ra stdout. Nó không đọc unsaved state trong GUI, không gọi setters/SaveModel/RunJob. Một số getter mặc định phụ thuộc Power Unit model/type nên lỗi cần được ghi nhận, không biến thành giá trị 0. Model khác cần kiểm tra dữ liệu và dependencies; probe không phải kiểm tra tính hợp lệ toàn bộ solver.

## Mở browser trong phiên EXCITE

Đặt `EXCITE_SettingsBrowser.py` vào `<AWS_USERHOME>/python/`. Registry có tên đúng `excite_py_script.ini`; nếu máy nhận đã có registry user, **gộp entry của gói vào XML hiện có**, không ghi đè toàn bộ file và làm mất các utility khác. Template nằm trong `scripts/`.

Lưu model nếu cần, mở lại EXCITE để reload menu, chọn Utilities → Python Scripts → EXCITE Settings Browser. Browser dùng client active trong GUI; refresh/lọc/export CSV. Nó chỉ enumerate named parameters và element metadata, chưa lấy mọi WSClass setting đã nghiên cứu.

`inspect_open_ex_api.py` là utility đọc khác cho GUI, tạo báo cáo text cạnh script; nó không tự được đăng ký vào menu bởi registry hiện tại. AI có thể chạy bằng cơ chế utility/console thích hợp sau khi kiểm tra release.

## Triển khai theo mục đích người dùng

Giai đoạn đầu: dashboard Refresh/Check đáng tin cậy, Current và Proposed riêng, stable row identity theo object UUID + case + field mapping. Hiển thị unsupported/inactive/missing/stale, cùng giá trị raw/evaluated/unit/binding. Mục chưa có full path/adapter chưa được bật Apply.

Sau đó kiểm thử từng setter trên bản sao: ghi → đọc lại → SaveAs → mở lại → đối chiếu. Bắt đầu với scalar và named parameters, rồi Load Data, bearing, cuối cùng Timing Drive và live GUI bridge. Power Unit Timing Drive Link và model/client `tycon` riêng cần được tách đúng phạm vi.

Workbook dùng local controller/AVL runtime để Apply. `=PY()` chạy trên cloud và không trực tiếp truy cập phần mềm AVL local. Các cột read_api/write_api trong CSV là mô tả research; không chạy chúng bằng eval().
