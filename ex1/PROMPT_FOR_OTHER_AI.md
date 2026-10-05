# Yêu cầu dành cho AI trên máy nhận

Tôi muốn kiểm tra và điều khiển dữ liệu EXCITE qua Excel vì settings trong phần mềm nhiều, dễ sai. Hãy đọc README và toàn bộ các tài liệu/CSV liên quan trong gói này để tiếp tục công việc.

Xác định thư mục cài AVL release đang dùng trên máy này, chỉ xem các đường dẫn trong gói là tương đối từ `<AVL_ROOT>`. Xác định riêng `<AWS_USERHOME>` của phiên Workspace. Không dùng đường dẫn/username của máy nguồn. Đối chiếu API và schema local trước khi kết luận một field đọc/ghi được ở release này.

Mục tiêu dashboard: chọn đúng model/product/case/object; Refresh current data; lọc theo nhóm Load Data, bearing, solver, crank train và Timing Drive; hiển thị Current, Proposed, unit, parameter binding, active state và Check result. Giữ Proposed khi Refresh bằng stable IDs. Bảng curves/matrix phải có cấu trúc phù hợp để xem và kiểm tra.

Phân biệt: đọc runtime đã xác nhận; setter có trong source nhưng chưa thử; field chỉ là schema candidate. Đừng coi 193 mục chỉ mục hoặc 1.388 khai báo schema là các phép Apply đã được chứng minh.

Trước tiên xây/kiểm thử Refresh và Check trên model của máy này. Sau đó xây Preview và Apply từng adapter trên bản sao model, xác nhận write → read-back → SaveAs → reopen. Đưa các field unsupported/inactive/stale vào trạng thái rõ ràng; không biến blank/null/INF thành 0. Giữ unit, expression, parameter binding và case override đúng ý nghĩa.

Tôi muốn Apply từ Excel bằng local bridge dùng runtime AVL. Có thể bắt đầu với file `.ex` đã lưu và client batch riêng. Nếu cần phiên GUI đang mở/unsaved state, phải triển khai utility trong EXCITE và giao thức request/response; không giả định external Python đã tự attach đúng GUI client.

Power Unit Timing Drive Link chỉ là liên kết; native chain/belt/tensioner/cam thuộc model/client Timing Drive `tycon` riêng. Hãy giữ phân biệt này trong adapter và dashboard.

Hãy báo cáo bằng tiếng Việt: đã đọc/kiểm thử được gì, những trường nào đủ điều kiện Apply, phần nào còn thiếu model/schema/adapter. Dùng tên nhóm và đơn vị kỹ thuật rõ ràng để tôi kiểm tra trước khi chỉnh dữ liệu thực tế.
