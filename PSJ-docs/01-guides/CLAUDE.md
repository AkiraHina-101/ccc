# 08-PSJ — Luật vận hành cho AI agent

Đây là workspace phát triển tool PSJ (Python Scripting for Jupiter, TechnoStar)
cho kỹ sư CAE. Agent nào làm việc ở đây PHẢI đọc và tuân thủ file này.

## Đọc trước khi làm bất cứ gì

1. `docs/AGENT_PLAYBOOK.md` — cách làm việc đã được kiểm chứng (BẮT BUỘC).
2. HANDOFF.md của folder con đang làm việc (vd `02-OUTER_EXTRACT/HANDOFF.md`,
   `01-DETECT_RIB/HANDOFF.md`) — trạng thái, lịch sử sai lầm, việc dở dang.
3. Kho tra cứu PSJ: `C:\psj-project\psj_knowledge\README.md` — TRA trước khi
   viết bất kỳ lệnh PSJ/JPT/dlg nào. KHÔNG bịa tên hàm/tham số.

## 5 luật cứng (vi phạm là hỏng việc)

1. **Test tĩnh trước khi giao.** Mọi file tool phải qua `python -m py_compile`
   VÀ chạy static test (mock pyjdg) nếu có logic hình học/phân loại.
   Chưa test = chưa xong. Xem mẫu: `02-OUTER_EXTRACT/static_test_v2_2.py`.
2. **User là ground truth.** Agent không nhìn thấy model 3D. Mọi phán đoán
   đúng/sai do user quyết qua vòng lặp: instrument debug → user select + paste
   console → sửa theo SỐ LIỆU → chấm lại toàn bộ mẫu cũ → giao.
3. **Không sửa bản release/bản user nói "đã đúng".** Mỗi cải tiến = file mới
   (v2 → v2_1 → v2_2...). Muốn thử nghiệm rủi ro: bản copy riêng.
4. **Mơ hồ thì HỎI, mâu thuẫn thì DỪNG.** Hai nhãn ngược nhau trên cùng hồ sơ
   số liệu = không được ép rule; hỏi user hoặc tìm đặc trưng mới.
5. **Một thay đổi logic mỗi vòng.** User xác nhận rồi mới bước tiếp.
   Tệ hơn → revert ngay + ghi chú "ĐÃ THỬ, THẤT BẠI VÌ..." vào code + HANDOFF.

## Quy ước kỹ thuật PSJ (đã kiểm chứng, không cần thử lại)

- PSJ chạy script bằng `exec` → KHÔNG có `__file__`; dùng đường dẫn tuyệt đối.
- Dialog nạp code lúc MỞ — sửa file xong phải nhắc user ĐÓNG dialog MỞ LẠI.
- `add_part_selector()` / `add_face_selector()` không nhận tham số;
  `simulate_space_key()` trước `generate_window()`; `generate_window()` cuối main().
- Select: `JPT.SelectionByIDs(JPT.DItemType.FACE/ELEM/BODY, ids, True)`;
  clear: `JPT.ClearAllSelection()`; đọc selection: `JPT.GetSelectedFaces()/
  GetSelectedParts()`. Tọa độ node là mét → ×1000 ra mm.
- Console `print()` là kênh giao tiếp chính với user — in có tiền tố `[TAG]`,
  user sẽ paste nguyên block về.
- Tính toán nặng (voxel, chiếu tia, phân tích mesh lớn): làm OFFLINE bằng
  Python hệ thống + numpy, ghi JSON; tool PSJ chỉ đọc JSON + select.
- State cần sống qua reload dialog → ghi file JSON (TEMP cho tạm, repo cho GT).

## Cấu trúc

- `01-DETECT_RIB/` — rib detector (release/r3.py + rib_gt.py).
- `02-OUTER_EXTRACT/` — outer/inner/hole/contact classifier (v2_2 đã chốt).
- `03-PSJ-RECORD/` — VSCode/Jupiter recorder and scripting bridge.
- `docs/` — playbook + tài liệu.
- `.claude/agents/` — subagent định nghĩa sẵn (xem playbook mục subagent).
