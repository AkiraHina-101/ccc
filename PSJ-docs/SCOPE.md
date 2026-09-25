# Phạm vi AI có thể chạm tới

## Được phép đọc và dùng làm nguồn

- Nội dung trong `PSJ-docs/` và project workspace đã được người dùng cung cấp.
- Tài liệu, mã nguồn, test và fixture của `01-DETECT_RIB`, `02-OUTER_EXTRACT`, `03-PSJ-RECORD`, `04-FUNCTION_ADDITIONAL` theo yêu cầu công việc cụ thể.
- PSJ/JPT API đã tra được trong docs và wrapper; MCP `search_psj` là đường tra cứu ưu tiên.

## Có thể chạy khi người dùng giao việc phù hợp

- Static tests và script offline trong workspace.
- AI được chủ máy ủy quyền tự chủ thao tác Jupiter nội bộ qua PSJ để hoàn thành công việc: mở model, chọn đối tượng, chỉnh sửa hình học/mesh và trạng thái, chạy macro, lưu hoặc xuất kết quả.
- Có thể dùng local HTTP adapter `http_bridge.py` (custom HTTP/OpenAPI client), MCP `run` / `test_gui`, hoặc `send.py`. Adapter chỉ dùng trên chính máy Jupiter; không mở cổng cho máy khác và không tạo tunnel.
- Quyền này chỉ áp dụng cho Jupiter và các file đầu vào/đầu ra cần cho công việc PSJ; không bao gồm quyền quản trị Windows, cài phần mềm, hay truy cập file cá nhân/ngoài phạm vi công việc.

## Cấm triển khai tải/cài từ web

- Không triển khai installer, downloader, package manager hay chức năng lấy model/thư viện/tài nguyên từ web.
- Chỉ dùng chương trình và tài liệu PSJ/Jupiter đã có sẵn trên máy công ty.
- Không tạo tunnel, port forward, proxy hay firewall rule để đưa adapter ra ngoài máy.

## Có thể sửa trong phạm vi workspace

- File mới và mã dự án trong workspace, theo HANDOFF/CLAUDE/playbook.
- Không ghi đè bản release hoặc thay đổi đã được xác nhận; tạo phiên bản thử riêng và test theo quy trình.
- Bridge copy trong `PSJ-docs/02-bridge` chỉ là tài liệu tham khảo. Sửa bản đang dùng trong `03-PSJ-RECORD`, không sửa bản sao handoff rồi mong runtime thay đổi.

## Vùng không được chạm

- `C:\Program Files\TechnoStar\` — không sửa/thêm/xóa file, kể cả thư viện Python đi kèm; chỉ chạy Jupiter/API theo quyền đã có.
- File license hoặc thư mục/license binary của Jupiter — không đọc.
- Không sửa `03-PSJ-RECORD/jupiterutils/` gốc TechnoStar; bổ sung bằng file mới bên cạnh.
- Không thay đổi cài đặt hệ thống hoặc cài thêm phần mềm.
- Không tự gửi lệnh vào mọi cửa sổ Jupiter đang mở: bridge IPC cũ có thể broadcast tới nhiều cửa sổ DCAD_main.exe. Xác nhận đúng phiên trước khi chạy.

## Những gì chưa thể bảo đảm

- Chỉ có thể thao tác được gì mà phiên bản Jupiter/API cho phép; không giả định mọi click GUI đều có journal hoặc API.
- ID entity trong macro có thể đổi theo model/remesh. Kiểm tra danh tính trước khi áp dụng lên model khác.
- MCP `test_gui` đóng tiến trình Jupiter sau khi chụp ảnh; không dùng trên phiên làm việc cần giữ.
- HTTP adapter chỉ bind vào loopback, cần bearer token và client có hỗ trợ custom HTTP/OpenAPI tools. Chỉ client trên cùng máy được kết nối.
- Gói RAG có index đã build nhưng thiếu thư mục `Document/` nguồn trong workspace; khả năng cập nhật corpus cần lấy lại nguồn.
