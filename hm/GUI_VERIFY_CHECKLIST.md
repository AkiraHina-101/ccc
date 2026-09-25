# GUI Verify Checklist — Nastran Control Tool

Mục tiêu: xác nhận tool chạy end-to-end **trong HyperMesh GUI** với model thật.
Offline test (csv_io + session) đã PASS; phần còn lại (scan / assign / label / GUI) chỉ verify
được trong HM. Tick từng bước; ghi lỗi vào cột Note.

> Lưu ý: tool dùng đường dẫn Altair `<ALTAIR_INSTALL_DIR>/...`
> (trong `lib/scan.tcl::ensure_template`). Nếu bản cài khác version/đường dẫn → sửa candidate
> trong `ensure_template` trước khi test.

Verification status:

```text
RUNTIME-TEST-NEEDED:
  This is a human/GUI verification checklist, not an API source. Use it to prove
  behavior in a real HyperMesh GUI session.
```

---

## 0. Chuẩn bị
- [ ] Mở HyperMesh, profile **Nastran** (hoặc OptiStruct).
- [ ] Load 1 model nhỏ. Gợi ý: `02-NASTRAN_CONTROL/_ref/models/02-Test_Model.hm`
      (hoặc `01-Test_Model.hm` đã dùng cho API probe).

## 1. Launch
Cách A — Tcl console:
```
*evaltclscript("<PROJECT_ROOT>/02-NASTRAN_CONTROL/_clean/nastran_control.tcl", 0)
```
Cách B — menu button: page 5 nút **"Nastran Control"** (GREEN), hoặc Session page nút **"NC Launch"**.

- [ ] Cửa sổ table "Nastran Control — <model>" mở, không có lỗi đỏ trong console.

## 2. Table hiển thị
- [ ] 5 cột đúng: **Comp Label | ID | Prop Type | Mat Label | Mat ID**.
- [ ] Số dòng = số component trong model.
- [ ] Comp Label, Prop Type, Mat Label, Mat ID có data hợp lý (không rỗng hết, không "ERROR:").

## 3. Case detection (màu)
- [ ] Case 2 — PBUSH dùng chung nhiều comp: ô Prop Type tô **vàng** + hậu tố "(shared)".
- [ ] Case 3 — comp không property (RBE2/RBE3...): Prop Type = "—", ô Mat **xám** (disabled).
- [ ] Case 1 — comp thường: bình thường, không tô màu.

## 4. Inline edit label (ghi vào HM + session)
- [ ] Double-click 1 ô **Comp Label** → gõ tên mới → **Enter**.
- [ ] Log panel hiện `OK rename ... -> <tên mới>`.
- [ ] Kiểm tra trong HM Model Browser: component đã đổi tên đúng.
- [ ] **Esc** khi đang sửa → hủy, giữ tên cũ.

## 5. Assign material
- [ ] (Nếu dropdown trống) Material library lấy từ `sessions/<model>/materials.csv` —
      tạo file đó hoặc Import materials CSV trước. Xác nhận hành vi khi chưa có material.
- [ ] Chọn vài dòng (Case 1) → chọn material trong dropdown → **"Assign to selected"**.
- [ ] Log hiện `OK <comp> -> <material>`; cột Mat Label/Mat ID cập nhật.
- [ ] Assign vào dòng **Case 2 (PBUSH shared)** → log hiện `WARN ... shared prop#N affects M comps`.
- [ ] Assign vào dòng **Case 3** → log hiện `SKIP ... no property`.
- [ ] Kiểm tra trong HM: property của comp đã trỏ material mới (Card edit / Entity editor).

## 6. CSV export → edit → import
- [ ] **Export CSV** → chọn file → mở bằng Excel, đúng 5 cột + data.
- [ ] Sửa 1 Comp Label và 1 Mat Label trong Excel, lưu.
- [ ] **Import CSV** → chọn file đó → log hiện số label/assignment cập nhật; table phản ánh đúng.
- [ ] **Ctrl+C** trên dòng đã chọn → dán vào Excel ra đúng TSV.

## 7. Session persistence
- [ ] Nút **NC Save** (Session page) hoặc tự lưu sau assign.
- [ ] Mở folder `_clean/sessions/<model_name>/` — có: `comps.csv`, `assignments.csv`,
      `audit.csv` (và `materials.csv` nếu đã import). Nội dung khớp thao tác.
- [ ] Đóng tool, **launch lại** → label/assignment cũ được khôi phục (merge_labels).

---

## Phụ: chạy scan offline qua hmbatch (không cần GUI)
Chứng minh `scan.tcl` đọc model thật, in phân bố Case 1/2/3:
```powershell
$env:NC_MODEL_PATH = "<PROJECT_ROOT>\02-NASTRAN_CONTROL\_ref\models\02-Test_Model.hm"
& "<ALTAIR_INSTALL_DIR>\hm\bin\win64\hmbatch.exe" -tcl `
  "<PROJECT_ROOT>\02-NASTRAN_CONTROL\_clean\tests\test_scan.tcl"
```
- [ ] In ra danh sách component + "Case summary" với số đếm hợp lý.

---

## Kết quả
- Ngày verify: ____________
- Model dùng: ____________
- Bước fail (nếu có): ____________
- Kết luận: [ ] PASS toàn bộ   [ ] cần fix (xem note)
