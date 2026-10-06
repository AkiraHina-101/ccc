# Surface Split v2.5 cho Jupiter 5.0.4

Bản release đã sửa lỗi `IndexError: list index out of range` tại
`part_names[p]` khi ghi `outer_tri2eid.json` (2026-10-06).

## Cài trên máy khác

Cần cài Jupiter 5.0.4. Hai thư mục dưới đây là bộ cài tool chạy bên trong
Jupiter; không phải ứng dụng chạy độc lập.

1. Chép thư mục `PSJ_Commands/SurfaceSplit` vào:
   `%APPDATA%\TechnoStar\JPT5.0.4\PSJ_Commands\SurfaceSplit`.
   Thư mục này chỉ chứa `SurfaceSplit.py` và `SurfaceSplit.ico`.
2. Chép nguyên thư mục `SurfaceSplitRuntime` vào:
   `%APPDATA%\TechnoStar\JPT5.0.4\SurfaceSplitRuntime`.
   Không đặt runtime bên trong `PSJ_Commands`.
3. Khởi động lại Jupiter khi cài mới, mở nút SurfaceSplit rồi chọn BDF và
   chạy Analyze. Khi cập nhật tool đã cài, đóng/mở lại hộp thoại Surface Split.

Khi chép đè bản cũ, giữ nguyên `SurfaceSplitRuntime/data/run` của máy đó
(đường dẫn đã lưu, thiết lập màu và dữ liệu người dùng).

Có thể tải [gói ZIP đã sửa](SurfaceSplit_v2_5_parser_fix_20261006.zip),
giải nén rồi làm theo các bước trên. Chi tiết: [hướng dẫn triển khai](DEPLOY_SURFACE_SPLIT.txt).

## BDF hỗ trợ

- `CTETRA`: TET4 và TET10, dùng 4 nút góc để bóc mặt ngoài.
- `CTRIA3` và `CTRIA6`: dùng 3 nút góc.
- BDF không có `$ Part :` dùng nhóm PID nội bộ và đối chiếu Element/Node ID.
- Phần tử trước dòng Part đầu tiên cũng được đưa vào nhóm PID nội bộ.
- Chưa hỗ trợ HEXA, PENTA hoặc QUAD trong parser này.

Đã chạy 10 kiểm thử hồi quy, 8 kiểm thử contact trainer và kiểm tra compile
bằng Python của Jupiter 5.0.4. Chưa kiểm tra trên BDF gây lỗi ở máy nhận.
`MANIFEST.sha256` ghi SHA-256 của 14 file trong hai thư mục triển khai.
