# PSJ-docs — handoff cho AI làm việc với PSJ/Jupiter

Thư mục này tập hợp tài liệu vận hành, bridge hiện có, API wrapper và gói runtime để chuyển sang máy có Jupiter. Các script trong `02-bridge` là bản sao tham khảo; `http_bridge.py` có thể chạy làm local tool server trên máy Jupiter.

## Đọc theo thứ tự

1. `01-guides/CLAUDE.md` — luật và nguồn bắt buộc trước khi viết lệnh.
2. `01-guides/HANDOFF.md` — trạng thái đã kiểm chứng, cách bridge hoạt động và giới hạn.
3. `03-api-reference/AGENT_PLAYBOOK.md` — quy trình phát triển/test cùng kỹ sư.
4. `03-api-reference/API-QUICK-REFERENCE.md` — bridge/API đã ghi nhận cùng giới hạn.
5. `02-bridge/` — mã gửi/replay và provider snapshot.
6. `03-api-reference/` — wrapper/API gợi ý, ví dụ; mọi API mới cần tra cứu và xác nhận theo bản Jupiter đang dùng.
7. `04-mcp-package/PSJ_RAG_README.md` — tra cứu tài liệu PSJ đã có trên máy.
8. `04-mcp-package/HTTP_BRIDGE.md` — cách agent trên cùng máy gọi các tool cục bộ.
9. `05-jupiter-help/README.md` — bản sao tài liệu Help cục bộ của Jupiter 5.0.4 và phần Help có sẵn của 5.0.1.

## Cách AI gọi công cụ

Máy không cài MCP client vẫn có thể cung cấp `search_psj`, `run`, `test_gui` qua `02-bridge/http_bridge.py`, nếu agent hỗ trợ custom HTTP/OpenAPI tools trên cùng máy. Adapter chỉ bind loopback; không mở cổng, firewall hoặc tunnel cho máy khác. `run` mặc định tạo/đóng một phiên riêng; `reuse=true` giữ listener để gọi tiếp; `background=false` hiện cửa sổ.

## Cấu hình theo máy

Đường dẫn cấu hình phải khớp với máy Jupiter đang chạy. Dùng runtime PSJ và index tìm kiếm đã được chuẩn bị nội bộ. Bridge `03-PSJ-RECORD` hiện nhắm Jupiter 5.0.4 và Python đi kèm Jupiter; xác nhận tương thích nếu máy đích dùng phiên bản khác.

Không có thư mục `Document/` gốc trong workspace này. Tool dùng SQLite/vector database đã build sẵn; nếu cần tái lập chỉ mục sau khi docs thay đổi, cần lấy corpus `Document/` nguồn.

## Quy tắc API

- Không suy đoán tên hàm, tham số hay kiểu enum. Tìm `search_psj` trước, rồi kiểm tra ví dụ/wrapper và phiên bản Jupiter.
- Phân biệt cú pháp PSJ nội bộ ghi từ journal với wrapper `jupiterutils`; chúng không luôn tương thích trực tiếp.
- Ghi rõ mức độ chứng cứ: API có trong tài liệu, chạy tĩnh, chạy thành công trên Jupiter thật, hay xác nhận bằng mắt người dùng.
- Chạy thử tool chỉ trong model/cửa sổ Jupiter được người dùng chỉ định. Một số bridge broadcast tới các cửa sổ Jupiter cùng tiến trình.
- AI được tự chủ thao tác Jupiter nội bộ cho công việc PSJ. Không triển khai chức năng tải/cài thành phần từ web. Xem [SCOPE.md](SCOPE.md) để biết ranh giới đầy đủ.
