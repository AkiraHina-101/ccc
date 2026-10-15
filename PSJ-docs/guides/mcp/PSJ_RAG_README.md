# MCP tra cứu tài liệu PSJ

Tài liệu MCP cung cấp tra cứu chỉ đọc cho corpus PSJ/Jupiter. Giao diện khái niệm gồm:

- `search_psj(query, top_k=5, mode="auto", version="", locale="")`: tìm theo tên hoặc toàn văn, có thể lọc phiên bản/ngôn ngữ.
- `get_api(name, version="5.0.4", locale="en")`: tra API chính xác, chữ ký runtime, alias và trang tài liệu liên quan.
- `read_doc(source, start_offset=0, max_chars=16000)`: đọc trang dài theo từng đoạn.
- `list_doc_versions()`: liệt kê nguồn và phiên bản/ngôn ngữ có trong index.

Tìm kiếm `auto` ưu tiên tên API/trang rồi mới tìm toàn văn. Đối chiếu phiên bản trước khi dùng thông tin 5.1.0 cho runtime 5.0.4. Chữ ký trong tài liệu không thay thế kiểm chứng runtime.

## Ranh giới triển khai

MCP server, SQLite index vận hành và cấu hình client được quản lý riêng, không nằm trong corpus này. Host environment chịu trách nhiệm cung cấp server, index, đường dẫn corpus và cấu hình kết nối. Không ghi đường dẫn tuyệt đối theo máy cá nhân vào tài liệu dùng chung.

Corpus này chỉ nhằm hỗ trợ AI đọc và tra cứu tài liệu; nó không cấp quyền gọi API trực tiếp, chạy macro hoặc điều khiển Jupiter.
