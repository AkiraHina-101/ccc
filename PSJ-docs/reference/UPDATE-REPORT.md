# Cập nhật toàn bộ tài liệu API — 2026-10-12

Đã quét hết các nguồn tài liệu PSJ/Jupiter cục bộ được xác định cho công việc này, bao gồm `PSJ Documentation.exe`. Nội dung trùng được gộp; danh mục vẫn lưu các đường dẫn nguồn, phiên bản và ngôn ngữ để đối chiếu.

## Quyền riêng tư

Ngày 2026-10-15, các ví dụ có đường dẫn hồ sơ Windows cục bộ đã được chuẩn hóa thành `C:\Users\USERNAME` trong bản sao văn bản, corpus, catalog và chỉ mục tìm kiếm. `source_sha256` lưu checksum nguồn ban đầu; `sha256` lưu checksum bản sao đã che. Tài liệu nguồn cài đặt không bị sửa.

## Kết quả

| Hạng mục | Kết quả |
|---|---:|
| Trang nguồn HTML/CHM được lập chỉ mục | 20.297 |
| Nội dung trang duy nhất | 7.152 |
| Trang có nội dung trùng được gộp | 13.145 |
| Tài nguyên văn bản giải mã từ EXE | 14.266 |
| Tài nguyên EXE trùng được bỏ qua khi ghi file | 66 |
| File Help/IDEData đối chiếu checksum | 23.222 |
| Bộ CHM đọc thành công | 9 |
| Stream văn bản CHM | 2.392 |
| PDF / tổng số trang | 3 / 728 |
| Nhóm API runtime đọc qua MCP | 36 |
| Mục runtime duy nhất, gồm hàm/type/enum/thuộc tính | 5.245 |
| Callable/type có mục chữ ký hoặc docstring | 2.146 |
| Alias runtime gộp vào ánh xạ tên | 51.886 |
| Hàm/phương thức trong wrapper cũ | 1.480 |
| Dòng Function trong calltips cục bộ | 934 |
| Bản ghi tìm kiếm full-text | 9.306 |
| Lỗi trích xuất/checksum/introspection | 0 |

Không cộng các số trên thành số API: trang tài liệu, alias, thuộc tính, kiểu dữ liệu, ví dụ và API thực thi là các đơn vị khác nhau.

## Nguồn và phạm vi

- `C:/Program Files/TechnoStar/Jupiter_5.0.1/Help` và `Jupiter_5.0.4/Help`: đồng bộ toàn bộ file tài liệu; bỏ installer/uninstaller và file kiểm soát truy cập web.
- `IDEData/*.dat` của cả hai bản cài đặt: keywords, chữ ký/calltips cho command, utility, GUI và Python helper.
- `PSJ Documentation.exe`: đọc bảng tài nguyên Tauri và giải mã Brotli trực tiếp bằng Node tích hợp; không cần chạy EXE. Các bộ tài liệu nhúng gồm 5.0.4 và 5.1.0, tiếng Anh/tiếng Nhật.
- 9 CHM: đọc stream văn bản bằng Windows ITStorage; bao gồm JPT API, hướng dẫn đầy đủ và hướng dẫn tùy chọn.
- 3 PDF: trích văn bản toàn bộ 728 trang. Trang 2 của hai hướng dẫn đầy đủ không có văn bản; đã render và xác nhận đều trắng hoàn toàn. Đây không phải trang API bị bỏ sót.
- MCP `search_psj`: tra nguồn `JPT.GetAllByTypeID()` để đối chiếu; MCP `run`: introspection API trong phiên Jupiter 5.0.4 riêng, gồm command roots, JPT và pyjdg. Không gọi các hàm thay đổi model.
- Các wrapper Python cũ trong thư mục tham chiếu: trích bằng AST, ghi rõ nguồn/dòng/chữ ký/docstring và mức độ chứng cứ.

Các bản gốc trong Program Files và EXE được giữ nguyên. JSON runtime ghi các alias riêng thay vì sao chép docstring nhiều lần. Corpus loại trùng theo SHA-256 của nội dung trang đã trích, không gộp các trang có khác biệt nội dung/tham số.

## Tra cứu và mức độ chứng cứ

- [API-CATALOG.md](API-CATALOG.md): bảng tất cả trang, theo phiên bản/ngôn ngữ/nhóm.
- `api-catalog.json`: toàn bộ nguồn và ví dụ code, ánh xạ nội dung trùng về một file corpus.
- `psj-doc-tree-current.json`: cây tra cứu mới cho mọi phiên bản/ngôn ngữ/nhóm; `psj-doc-tree.json` cũ giữ làm snapshot 5.1.0 trước lần cập nhật này.
- [RUNTIME-API.md](RUNTIME-API.md), `runtime-api-5.0.4.json`: snapshot runtime, chữ ký Python hoặc docstring C++ nếu runtime cung cấp.
- `api-coverage.json`: đối chiếu tên API trong tài liệu 5.0.4 với tên/alias runtime. Tên xuất hiện trong ví dụ có thể là dialog do người dùng tạo hoặc wrapper; không quan sát thấy không đồng nghĩa với không hỗ trợ.
- `legacy-wrapper-api.json`: API wrapper cũ, tách khỏi chứng cứ runtime hiện tại.
- `update-summary.json` và các extraction/source manifests: số liệu và kiểm tra máy đọc được.

Tài liệu 5.1.0 được giữ riêng về phiên bản và không chứng minh tương thích với Jupiter 5.0.4. Một số trang Help cài đặt vẫn có nhãn nội bộ 5.0.3; nhãn danh mục chỉ phiên bản bộ tài liệu/đường dẫn nguồn. Introspection xác nhận sự hiện diện/chữ ký, chưa kiểm tra hành vi của từng API.

MCP `search_psj` đang dùng chỉ mục vector cũ. Nội dung cập nhật có chỉ mục full-text riêng trong `PSJ-docs`, dùng được ngay và không phụ thuộc mô hình embedding:

```powershell
python -X utf8 PSJ-docs/reference/search_api.py "GetAllByTypeID" --limit 5
python -X utf8 PSJ-docs/reference/search_api.py "Cube" --version 5.0.4
```

## Tái tạo và kiểm tra

Các script trích xuất/cập nhật được giữ trong thư mục này. `extract_pdf_text.py` dùng Python có `pypdf` trong runtime tích hợp; script giải mã EXE dùng Node với `zlib` tích hợp. Các script còn lại dùng thư viện chuẩn Python/Windows COM.

Thứ tự: `extract_documentation_exe.py` → `decode_documentation_assets.cjs` → `extract_chm_api.py` → `extract_pdf_text.py` → `update_api_catalog.py` → `finalize_api_catalog.py`. CHM/PDF cần bản Help cục bộ đã đồng bộ. `inspect_runtime_api.py` chạy qua MCP Jupiter riêng trước bước tạo danh mục. Có thể dùng `update_api_catalog.py --skip-sync` khi chỉ tái lập corpus từ các file đã đồng bộ.

Đã chạy `py_compile` cho các script Python; kiểm tra toàn bộ checksum; kiểm tra SQLite integrity; tìm kiếm thử utility, geometry, connection và GUI. Đã đọc mẫu corpus tiếng Anh/tiếng Nhật để kiểm tra nội dung tham số, code và mã hóa Shift-JIS của CHM.

