# PSJ/Jupiter bridge — ghi chú API nhanh

## Hai bề mặt thực thi

1. PSJ nội bộ/journal: cú pháp record được gửi nguyên file vào Jupiter qua `send.py` / `JPT_RUN_FILE`. Chạy trong ngữ cảnh PSJ.
2. Wrapper: script Python dùng `from jupiterutils import *` và `JPT.*`; chạy qua VSCode hoặc MCP. Không chuyển máy móc cú pháp journal sang wrapper vì tên/tham số có thể khác.

## IPC của `jupiterutils`

- `JPT_RUN_LINE(str)`: gửi biểu thức/lệnh, chờ kết quả qua listener; hữu ích cho bridge VSCode.
- `JPT_RUN_CODE(str)`: gửi block code, không đợi stdout trả về.
- `JPT_RUN_FILE(path)`: yêu cầu Jupiter thực thi file; kết quả/lỗi thường xem ở cửa sổ Python API.
- Mã nguồn `PSJ_Interpreter.py` cho thấy giao thức Win32 `WM_COPYDATA`, `DCAD_main.exe`, message prefix `debug;`, `file;`, `line;`.

## API có xác nhận trong HANDOFF

- Đọc selection: `JPT.GetSelectedFaces()`, `JPT.GetSelectedParts()`.
- Chọn theo ID: `JPT.SelectionByIDs(JPT.DItemType.FACE/BODY, ids, JPT.BoolType.TRUE_VAL)`; xóa selection: `JPT.ClearAllSelection()`.
- Đọc BODY visibility: `JPT.GetAllByTypeID(JPT.DItemType.BODY)` rồi đọc `DItem.isHidden`.
- Ghi visibility: `JPT.ShowHideEntitiesByID(JPT.DTableType.BODY, id, JPT.BoolType.TRUE_VAL/FALSE_VAL)`, `JPT.ShowHideAllParts(...)`, `JPT.InverseHideBodies(partID)`.

Các API selection/visibility trên được HANDOFF ghi nhận đã chạy thật trên Jupiter 5.0.4. `GetAllParts()` trả runtime `DBody` không có `isHidden`; dùng `GetAllByTypeID(BODY)` cho visibility. `isHidden` không đồng nghĩa với occlusion, clipping, transparency hay suppression.

## Hạn chế IPC cần tính đến

- `SendMessageToJupiter` tìm tiến trình theo tên rồi gửi tới các cửa sổ phù hợp; nhiều phiên Jupiter có thể nhận lệnh.
- Đường trả kết quả trong `PSJ_Interpreter.py` lọc ký tự non-ASCII và có xử lý chuỗi đặc thù; text Unicode hoặc kết quả lớn có thể sai.
- `RUN_CODE`/`RUN_FILE` là fire-and-forget; wrapper cũ có thể trả dữ liệu stale nếu không có phản hồi mới. Provider visibility đã có kiểm tra schema chặt.
- ID trong macro cố định; model khác hoặc remesh có thể khiến lệnh nhắm sai entity.

Đây là ghi chú nguồn, không thay tài liệu API theo phiên bản. Tra `search_psj` và nguồn trong `03-api-reference/` trước khi viết lệnh mới.
