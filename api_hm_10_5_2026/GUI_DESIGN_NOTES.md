# Hướng dẫn thiết kế GUI cho các tool kỹ thuật

Đây là hướng dẫn thiết kế có thể dùng lại cho các GUI sau này, không phải mô tả API chính thức của Altair hay mẫu cố định cho một dự án. Khi làm tool HyperMesh, chọn toolkit và cú pháp theo [bản đồ nguồn GUI](official_help/GUI_AND_TOOLKIT_SOURCES.md) cùng tài liệu đúng phiên bản. Với ứng dụng khác, dùng tài liệu chính thức của toolkit tương ứng. Tách quyết định thiết kế trải nghiệm khỏi hợp đồng API.

## Quy trình trước khi viết GUI

1. Liệt kê tác vụ chính, dữ liệu đầu vào, kết quả, thao tác phụ và trạng thái chưa có dữ liệu. Vẽ một bố cục nhỏ trước khi tạo widget. Nếu tác vụ hoặc ý nghĩa thao tác chưa rõ, hỏi người dùng; không lấp khoảng trống bằng nút hoặc nhãn tự đoán.
2. Chọn widget có sẵn của toolkit: `labelframe`/group box cho nhóm, menu cho các lựa chọn cùng một chức năng, bảng/tree cho danh sách, dialog chuẩn cho màu và file. Kiểm tra API đúng release; không tự mô phỏng hành vi mà widget chuẩn đã hỗ trợ.
3. Xác định phần nào co giãn, phần nào giữ bề rộng tối thiểu, vị trí trạng thái và cách cửa sổ phản ứng khi danh sách rỗng hoặc rất dài. Làm việc này trước khi gắn callback xử lý model.
4. Sau khi dựng GUI, xem ảnh ở kích thước thật và thử thao tác cơ bản. Một cửa sổ dựng được nhưng trống, bị cắt hoặc có nút lệch hàng vẫn là lỗi.

## Bố cục và tương tác

- Đặt thao tác chính ở vị trí dễ thấy; gom các lựa chọn có liên quan **trong khung có viền và tên ngắn**. Căn thẳng nhãn, ô nhập, ô màu và nút; dùng khoảng cách và bề rộng nút nhất quán. Tránh tiêu đề lặp, vùng trống lớn và một cột nút dài không phân nhóm.
- Chọn hàng ngang hay dọc theo nội dung và không gian thực tế. Với danh sách loại lỗi và màu, mỗi loại nằm trên một hàng cùng một ô màu **hình vuông**; bản thân ô màu không cần chữ. Các thao tác phụ có thể xếp thành một cột nút đều nhau bên cạnh.
- Đặt thao tác có cùng mục đích trong cùng nhóm: cấu hình, chạy/xuất kết quả, xem xét, dọn dấu tạm. Nếu một chức năng có vài nguồn đầu vào tương đương, một nút menu có các lựa chọn rõ tên thường gọn hơn nhiều nút gần giống nhau. Dùng menu ngữ cảnh cho thao tác gắn với một hàng; thao tác quan trọng vẫn cần đường truy cập dễ thấy hoặc gợi ý rõ.
- Giữ nhãn ngắn nhưng phân biệt được hành động, ví dụ `Find shared nodes...` với các nguồn `Selected components` và `Displayed elements`. Đặt động từ ở đầu nút; tránh tên chỉ mô tả trạng thái thay vì hành động.
- Thể hiện trạng thái chưa chọn dữ liệu, đang xử lý, hoàn thành, không có kết quả, lỗi và hủy. Chỉ bật thao tác khi đầu vào hợp lệ; thông báo ngắn gọn và cho biết bước tiếp theo. Không âm thầm làm thay đổi viewport hay dữ liệu model khi chỉ đóng một hộp thoại, trừ khi hành vi đó được yêu cầu rõ.
- Hỗ trợ bàn phím và khả năng đọc: thứ tự Tab hợp lý, focus nhìn thấy được, thao tác mặc định và Escape phù hợp, nhãn không bị cắt, trạng thái không chỉ truyền bằng màu. Dùng độ tương phản đủ rõ và kiểm tra khi Windows dùng DPI lớn.
- [Bố cục Shared Edge Check đã được người dùng duyệt](gui_layout_reference.png) là ví dụ về độ gọn và căn chỉnh, không phải mẫu phải sao chép cho mọi tool.

## Co giãn và vị trí cửa sổ

- Dùng geometry manager của toolkit (`grid`, `pack`, layout class) để phân phối không gian. Gán trọng số/co giãn cho vùng danh sách hoặc nội dung; giữ nút và ô màu ở kích thước hợp lý. Với `ttk::treeview`, dùng tùy chọn cột `-stretch` và `-minwidth` trước khi viết callback tự tính lại từng pixel. Bảng phải lấp vùng sẵn có khi người dùng resize và không để dải trắng lớn vô cớ.
- Đặt kích thước tối thiểu theo nội dung quan trọng; thử thu nhỏ và phóng lớn. Không đổi `wm geometry`/kích thước cưỡng bức mỗi khi cập nhật dữ liệu, mở danh sách hay đổi trạng thái nút: việc đó làm cửa sổ giật và phá kích thước người dùng đã chọn.
- Trên máy nhiều màn hình, tránh mặc định cố định vào góc màn hình chính. Ưu tiên cơ chế đặt cửa sổ của hệ điều hành hoặc toolkit. Nếu cần đặt lần đầu, dùng màn hình đang tương tác, giới hạn cửa sổ trong work area, rồi để người dùng tự di chuyển; không tiếp tục ép vị trí sau đó. Chỉ lưu và khôi phục vị trí/kích thước khi sản phẩm cần và đã xử lý màn hình bị tháo, DPI thay đổi, tọa độ ngoài màn hình.
- `Always on top` là lựa chọn của người dùng, không nên tự bật. Đặt nó nơi dễ tìm nhưng không cạnh tranh với thao tác chính; lưu trạng thái nếu người dùng đã chọn.

## Giữ thiết lập giữa các lần mở

**Nguyên tắc dùng lại:** các thiết lập người dùng chỉnh và có ý nghĩa giữa các phiên phải được giữ sau khi đóng GUI, source lại hoặc đóng/mở ứng dụng. Ví dụ ngưỡng từ `0.1` đổi thành `0.3`, số lớp lan, chế độ, màu và Always on top phải được nạp lại đúng. Reset trạng thái thao tác không được tự đổi các thiết lập này về mặc định; nếu cần khôi phục mặc định, dùng một thao tác riêng có tên rõ ràng.

- Trước khi sửa GUI, tìm nơi tool đang lưu preference và đọc dữ liệu cũ trước khi gán giá trị mặc định. Phân biệt **preference** (chế độ, màu, ngưỡng, topmost) với **trạng thái phiên/model** (ID component/node, kết quả kiểm tra, mark tạm). Chỉ lưu vị trí/kích thước cửa sổ nếu có nhu cầu rõ và có cách đưa cửa sổ trở lại màn hình khi cấu hình monitor thay đổi.
- Khi đổi schema hay đường dẫn, chuyển dữ liệu cũ sang định dạng mới; kiểm tra dữ liệu khi nạp và dùng mặc định an toàn nếu file hỏng. Không lưu ID component/node phụ thuộc model vào preference dùng chung.
- Sau khi sửa, mở lại GUI để xác nhận setting được nạp thật từ file, không chỉ tồn tại trong biến của phiên hiện tại.
- Lưu xuống file ngay khi người dùng hoàn tất một thay đổi hợp lệ, không chỉ dựa vào callback đóng cửa sổ: đóng ứng dụng có thể không gọi callback đó. Có thể dùng variable trace hoặc callback thay đổi/focus-out phù hợp; đừng ghi dữ liệu đang nhập dở hoặc không hợp lệ đè lên giá trị hợp lệ đã lưu. Ghi qua file tạm rồi thay thế file đích để tránh preference bị ghi dở.
- Khi source lại, lưu trạng thái cũ **trước** các lệnh khởi tạo namespace/giá trị mặc định. Sau đó nạp preference; không để code dựng lại GUI ghi mặc định đè lên file trước khi nạp. Tránh đăng ký trùng trace/callback sau nhiều lần source.

### Bẫy Tcl: trùng tên lệnh đóng file với hàm đóng GUI

- Comp Cavity Remesh r25 có `::CCRUI::close` để đóng GUI. Trong cùng namespace, `close $channel` gọi nhầm hàm này thay vì lệnh Tcl đóng file. `catch` che lỗi, channel không được đóng và dữ liệu buffered có thể chưa được ghi xuống đĩa. r25.1 sửa thành `::close $channel` và `flush $channel`; chưa kiểm chứng đóng/mở lại trong HM2022 tại thời điểm ghi chú.
- Trong các namespace GUI, gọi rõ `::open`, `::close` cho file I/O và các lệnh Tcl khác có nguy cơ trùng tên với procedure của tool. Không bỏ qua lỗi ghi, flush hoặc close: hiện thông báo ngắn để người dùng biết settings chưa lưu được.
- Khi được yêu cầu kiểm chứng persistence, kiểm tra file có dữ liệu thực, rồi đóng/mở GUI hoặc source lại và đọc giá trị đã nạp. Không báo lưu thành công chỉ vì callback chạy không báo lỗi. Không tự đóng/khởi động lại HyperMesh để kiểm chứng.

## Kiểm tra giao diện

- Kiểm tra ít nhất: lần mở đầu, mở lại với setting đã đổi, danh sách rỗng, danh sách dài, cửa sổ thu/phóng, màn hình phụ, DPI khác mặc định, đóng bằng nút Close và nút X. Nếu có menu ngữ cảnh, kiểm tra click phải đúng hàng và trường hợp click vùng trống.
- Đo bằng hành vi quan sát được: có đủ widget, đúng nhóm, không cắt chữ, không chồng lớp, không nhảy vị trí/kích thước khi cập nhật dữ liệu, cột bảng luôn chiếm chiều rộng cần thiết, trạng thái nút đúng, setting được đọc lại từ file.
- Kiểm tra callback ở mức phù hợp: lỗi an toàn hiển thị thông báo dễ hiểu, không để GUI kẹt ở trạng thái disabled, không tạo entity hoặc thay đổi view ngoài ý muốn. Phân biệt kết quả kiểm tra cú pháp với kiểm tra GUI trong ứng dụng thật.

### Bẫy Tk: khung nhóm che widget khi dùng `grid -in`

- Đã gặp trong Comp Cavity Remesh r21–r23: nút, ô nhập và log được tạo dưới `.ccr`, sau đó dùng `grid -in` để đặt vào các frame/labelframe cũng là con của `.ccr`. Khung được tạo sau nằm trên widget trong thứ tự hiển thị, khiến khung có khoảng trống nhưng các điều khiển bị che. `grid -in` chỉ đổi nơi quản lý bố cục, không đổi parent của widget.
- Ưu tiên tạo frame/labelframe trước, rồi tạo widget **thực sự bên trong nhóm đó** (ví dụ `.ccr.search.ids`). Cập nhật đồng bộ đường dẫn trong callback, enable/disable, focus và bind.
- Nếu giữ đường dẫn widget cũ và dùng `grid -in` với khung cùng parent, phải quản lý thứ tự hiển thị: `raise` các widget lên trên khung sau khi dựng bố cục. Bản r23.1 đã thêm cách sửa này; chưa kiểm chứng trực tiếp trong HM2022 tại thời điểm ghi chú.
- Khi xem GUI, kiểm tra đủ nút, ô nhập và log trong từng nhóm; khung vẫn hiện không có nghĩa widget bên trong đã hiển thị đúng. Không kết luận GUI đạt chỉ từ việc Tcl không báo lỗi.

Khi được phép chạy GUI trong HyperMesh, chụp và xem giao diện ở kích thước thật để tìm chữ bị cắt, widget chồng lên nhau, lệch hàng, ô màu không vuông và trạng thái nút sai. Kiểm tra ít nhất một luồng thành công và một luồng không có dữ liệu hoặc lỗi an toàn. Nếu chưa kiểm tra được trong ứng dụng, ghi rõ giới hạn đó khi bàn giao.
