# AGENT PLAYBOOK — Cách phát triển tool PSJ cùng kỹ sư CAE

> Chưng cất từ 2 project thành công: rib_detector và surface classifier
> (02-OUTER_EXTRACT, v1 → v2_2, ~15 vòng lặp GT, kết quả 98%+).
> Viết cho BẤT KỲ agent nào — làm theo là tái tạo được phong cách làm việc này.

---

## PHẦN 1 — Mô hình hợp tác

### Sự thật nền tảng: agent MÙ, user SÁNG

Agent không nhìn thấy model 3D. User nhìn thấy mọi thứ nhưng không đọc code.
Mọi thiết kế phải xoay quanh việc bắc cầu hai bên:

- Agent xuất **số liệu** (debug console, đặc trưng hình học) → user đọc được.
- User xuất **phán quyết** (select face, paste console, chụp màn hình,
  mô tả bằng ngôn ngữ kỹ sư) → agent đọc được.
- KHÔNG BAO GIỜ tranh cãi với mắt của user. Nếu số liệu nói A mà user nói B,
  thì hoặc phép đo sai, hoặc đặc trưng chưa đủ — không phải user sai.

### Vòng lặp chuẩn (GT loop) — xương sống của mọi thứ

```
1. INSTRUMENT  agent thêm debug in đủ đặc trưng + nhãn "đi qua cửa nào"
2. LABEL       user select face đúng/sai, bấm Debug, paste console
3. ANALYZE     agent xếp bảng 2 nhóm (đúng vs sai), tìm cột tách được
4. RULE        sửa MỘT thứ, ngưỡng đặt theo số liệu thật (không mò)
5. RE-SCORE    chạy lại test tĩnh + chấm TOÀN BỘ mẫu cũ (chống regression)
6. VERIFY      user chạy trong PSJ, xác nhận → mới sang vòng sau
```

Nhãn của user tích lũy vào file JSON trong repo (`contact_samples.json`,
`hole_samples.json`, `ground_truth/*.json`) — đó là tài sản, không phải rác.

### Ngôn ngữ chung với user

- Khi user mô tả bằng trực giác kỹ sư ("mặt đứng chứ không vát", "ghép vào
  khép kín", "bị nhốt bởi contact", "luôn dính vào nhau") — đó là ĐỊNH NGHĨA
  THUẬT TOÁN dạng thô. Việc của agent là dịch ra phép đo:
  đứng/vát → góc pháp tuyến với trục; khép kín → tổng pháp tuyến ≈ 0;
  bị nhốt → không có đường đi trong đồ thị kề; dính nhau → thành phần liên thông.
- Bất biến user phát biểu ("outer là một khối liên thông duy nhất") là VÀNG:
  chuyển thành bước thuật toán, đừng chỉ vá case lẻ.
- Gợi ý của user là hint về domain, KHÔNG phải spec. Phải phản biện: phát biểu
  lại cách hiểu, chỉ ra hệ quả phụ, rồi mới code. User đã yêu cầu rõ điều này.

---

## PHẦN 2 — Kỷ luật kỹ thuật

### Test tĩnh (KHÔNG THƯƠNG LƯỢNG)

- Mock pyjdg: `sys.modules["pyjdg"] = types.ModuleType("pyjdg")` rồi import tool.
- Dựng mesh giả bằng class N/E/F tối giản (xem `static_test_split_v2.py`).
- Mỗi rule hình học phải có test 2 CHIỀU: ca dương (phải bắt được) VÀ ca âm
  đối chứng (phải từ chối). Ví dụ thật: "4 mảnh ¼ ghép kín → lỗ" đi kèm
  "2 mảnh ¼ (nửa vòng) → không phải lỗ".
- Test chấm điểm trên file mẫu GT thật của user — mỗi lần sửa rule chạy lại,
  in recall/precision + danh sách FN/FP theo ID.
- Test tĩnh đã bắt được các bug mà đoán mò không bao giờ ra:
  (a) face phẳng làm hàm đặc trưng trả None → mọi so sánh âm thầm False;
  (b) pháp tuyến trung bình của face to-cong bị nghiêng → so mặt phẳng sai.

### Debug instrumentation — chống "rò không biết ở đâu"

Nguyên tắc: **mỗi quyết định phân loại phải để lại dấu vết đọc được**.

- Mỗi face in: class cuối + nhãn CỬA (`gate=core/pressed/prox`,
  `hole_via=tier1..4/frag/ring0/manual/ring-banned`) + toàn bộ đặc trưng số
  + thống kê hàng xóm + thông tin đảo/island.
- Khi user báo sai: nhìn nhãn cửa là biết chỉnh van nào, KHÔNG đoán.
- Nếu user báo sai mà debug không đủ thông tin để định vị → việc ĐẦU TIÊN
  là nâng debug, không phải sửa logic.

### Versioning & revert

- KHÔNG sửa đè bản user đã xác nhận. Chuỗi version: v2 → v2_1 → v2_2, mỗi bản
  một file; bản cũ là điểm quay đầu an toàn.
- Kết quả tệ hơn → revert NGAY về hành vi cũ, sau đó mới nghĩ tiếp.
- Sai lầm đã trả giá phải được ghi vào 2 chỗ: comment ngay tại đoạn code
  ("ĐÃ THỬ X ngày N → vỡ Y. KHÔNG lặp lại") và HANDOFF.md. Đây là cách duy
  nhất để agent phiên sau không dẫm lại.
- HANDOFF.md cập nhật cuối mỗi phiên làm việc đáng kể: trạng thái, số liệu,
  việc treo, quyết định đã chốt.

### Thiết kế thuật toán — bài học cụ thể

1. **Đặc trưng mới > vặn ngưỡng cũ.** Khi 2 nhóm chồng lấn trên mọi cột hiện
   có, vặn ngưỡng chỉ đổi chỗ lỗi. Đi tìm phép đo mới (ct_in, conc, tilt,
   hollow, shn, gconc đều sinh ra kiểu này).
2. **Cảnh giác tính chất CÓ TÍNH BẮC CẦU.** "Mượt cục bộ giữa 2 face" lan
   dây chuyền → bò khắp part (fillet nối mọi thứ). Tính chất dùng để lan phải
   là toàn cục (cùng một mặt phẳng tuyệt đối) hoặc bị chặn bởi rào.
3. **Trọng tài nhóm > guard từng phần tử.** Mảnh ¼ lỗ nhìn riêng giống hệt
   cung rác; chỉ phép thử trên NHÓM (tổng pháp tuyến ≈ 0 = khép kín) phân biệt
   được. Đừng giết ứng viên sớm nếu có trọng tài cuối.
4. **Nghi ngờ phép đo trên mesh thô.** Coverage/bins vô nghĩa với vành 8 cạnh;
   trục fit từ eigen pháp tuyến sai với vành thoải/phẳng (dùng navg cho vòng
   kín); Kasa fit cuộn cung hở thành vòng giả (chặn bằng cv).
5. **Rào chắn là hệ sinh thái.** Sửa định nghĩa contact có thể vỡ grow của
   outer (vòng gasket thủng → tràn inner). Mỗi lần đổi rào phải kiểm tra lại
   cả outer LẪN inner, không chỉ nhóm đang sửa.
6. **Compute nặng offline.** Voxel/chiếu tia/flood-fill trên mesh 1M+ element:
   Python hệ thống + numpy, xuất JSON. Tool PSJ chỉ đọc JSON + select. Phân
   giải voxel là đánh đổi tốc độ/độ nét — ghi rõ vào tài liệu tham số.
7. **Adjacency dùng edge ID topology** (`face.edges` chung ID) hợp với chung
   ≥2 node làm dự phòng — nhanh và đúng hơn mọi cách tự suy.

### Khi nhãn của user mâu thuẫn

Chuyện bình thường (nhãn cũ gán trước khi định nghĩa sắc nét ra đời).
Quy trình: (1) chỉ ra mâu thuẫn cụ thể bằng bảng số liệu, (2) hỏi user định
nghĩa nào là mới nhất, (3) DỌN file mẫu theo định nghĩa mới (xóa/di chuyển
nhãn cũ, in danh sách đã dọn), (4) mới sửa rule. KHÔNG lặng lẽ ép rule chiều
cả hai — sẽ hỏng cả hai.

---

## PHẦN 3 — Taxonomy đã chốt của surface classifier (tham chiếu)

(Chi tiết trong `02-OUTER_EXTRACT/HANDOFF.md`; đây là bản đồ khái niệm.)

- **HOLE**: mặt trụ ĐỨNG rỗng tâm; 4 tier + nhẫn-đứng-khép-kín (ring0)
  + ghép mảnh với điều kiện quyết định "KÍN KHI GHÉP" (|Σ pháp tuyến|/n ≤ 0.45).
- **VÀNH** (chamfer/đế bolt/vành vát): không hole, không contact → face thường.
- **CONTACT**: core = 100% node shared (định nghĩa user) + ép-toàn-mặt (ct_in)
  + proximity trong cụm có core + đồng phẳng dính liền core (1 lớp).
- **OUTER**: grow từ seed nhìn thấy, rào = hole + contact, lấp đảo tiếp giáp,
  bất biến: một khối liên thông duy nhất.
- **INNER**: grow đối xứng từ khoang trong, lan qua mọi thứ trừ contact/outer;
  thứ bị contact "biệt giam" không phải inner.
- Mục treo khi chốt sổ: dải bolt share-một-phần (vd 767874) = face thường,
  user chưa phán quyết có cần vào contact không.

---

## PHẦN 4 — Subagent: có cần không?

**Khuyến nghị: KHÔNG dùng subagent cho vòng lặp GT chính.** Lý do:
vòng lặp này nghẽn ở user (chạy PSJ, nhìn model, gán nhãn) chứ không nghẽn ở
agent; chia việc cho subagent chỉ thêm chỗ rơi rớt ngữ cảnh — mà ngữ cảnh
(lịch sử sai lầm, định nghĩa đang tiến hóa) chính là thứ đắt nhất ở đây.

Subagent CÓ ích cho 3 việc phụ, tách được ngữ cảnh:

1. **Tra cứu PSJ API** (read-only, kho ở C:\psj-project\psj_knowledge) —
   khi cần quét rộng nhiều hàm.
2. **Review code trước khi giao** — soi bug độc lập với người viết.
3. **Chạy/giám sát analyzer offline dài** (voxel 20-60 phút).

Đã có sẵn định nghĩa `psj-tool-dev` trong `.claude/agents/` đóng gói playbook
này — dùng khi muốn ủy thác một tác vụ TRỌN GÓI (vd "viết tool X theo phong
cách chuẩn"), còn làm việc lặp với user thì agent chính tự làm.

---

## PHẦN 5 — Checklist mở phiên & đóng phiên

Mở phiên:
- [ ] Đọc CLAUDE.md → HANDOFF.md của folder → memory liên quan.
- [ ] Hỏi user mục tiêu phiên nếu chưa rõ. Phát biểu lại cách hiểu.

Trước khi giao bất kỳ file nào:
- [ ] `python -m py_compile <file>`
- [ ] Chạy static test liên quan (và cập nhật test khi thêm rule).
- [ ] Nhắc user: đóng dialog cũ, mở lại file.

Đóng phiên:
- [ ] Cập nhật HANDOFF.md (trạng thái, số liệu, việc treo, sai lầm mới ghi nhận).
- [ ] Cập nhật memory nếu có nguyên tắc/feedback mới.
- [ ] Bản đã được user xác nhận ổn định → cân nhắc chép vào release/.
