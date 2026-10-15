# Inventory GUI Jupiter 5.0.4

Hướng dẫn áp dụng: [Ngôn ngữ bố cục GUI PSJ](../../guides/jupiter-ui-design-language.md).

Khảo sát ngày **2026-10-14**, chỉ đọc thư mục template của Jupiter 5.0.4. **1.800 XML**, **1.797 định nghĩa có control GUI**, **1.791 Window**; 1.800/1.800 parse XML thành công. Các nhóm có cả dialog sản phẩm, customer-specific và Test; không đồng nhất số file với số feature/menu/license.

| Nhóm thư mục | XML | Có GUI |
|---|---:|---:|
| root | 38 | 38 |
| AC Modeling | 24 | 24 |
| ALIGNMENTBYOOBB | 1 | 1 |
| Analysis | 134 | 133 |
| Assembly | 13 | 13 |
| CUSTOM | 484 | 483 |
| CommonTools | 59 | 59 |
| Comparison | 3 | 3 |
| Connection | 8 | 8 |
| CustomNote | 2 | 2 |
| Designer | 18 | 18 |
| DriveTrain | 2 | 2 |
| Eng-NVH | 17 | 17 |
| Export | 1 | 1 |
| FXWeld | 8 | 8 |
| Fastener | 7 | 7 |
| Geometry | 92 | 92 |
| Gururi | 1 | 1 |
| HexModeling | 14 | 14 |
| HoopsExchange | 1 | 1 |
| LBC | 246 | 246 |
| MeshCleanup | 29 | 29 |
| MeshEdit | 81 | 81 |
| Meshing | 52 | 52 |
| MidPlane | 9 | 9 |
| MidPlaneEdit | 9 | 9 |
| Misc | 6 | 6 |
| MuxWeld | 21 | 21 |
| Oasis | 5 | 5 |
| PSJ-GUI | 1 | 1 |
| PartExchange | 2 | 2 |
| Peridynamics | 2 | 2 |
| Post | 142 | 142 |
| Pre | 11 | 11 |
| Property | 66 | 66 |
| SearchOpn | 1 | 0 |
| Spot | 5 | 5 |
| Test | 171 | 171 |
| TranslateTools | 2 | 2 |
| Util | 1 | 1 |
| WebGL | 4 | 4 |
| WeldModeling | 7 | 7 |

## Tệp và cách tra cứu

- [jupiter-5.0.4-ui-inventory.json](jupiter-5.0.4-ui-inventory.json): đường dẫn/source SHA-256, title, group titles, control và toàn bộ thuộc tính khai báo của control. Mỗi định nghĩa nằm trên một dòng để dễ tra cứu. Inventory JSON là snapshot đã tạo sẵn; script sinh inventory không thuộc corpus này. Dữ liệu `summary` có thống kê width/height/margin, không phải số đo render. Tìm theo title, tên group hoặc thuộc tính control.

Các control phổ biến xác nhận từ nguồn gồm StackPanel, TaskPane/TaskGroup, GroupBoxCtrl, Label/TextBox, ComboBox, Button, CheckBox/RadioButton; bảng xuất hiện dưới dạng ListView (179), GridCtrl (148), ListBox (388), Table (3). **JDG Table và XML GridCtrl/ListView không phải tên API có thể thay lẫn trực tiếp.**

Inventory không gồm binary-built dialog, thay đổi control/state tại runtime hoặc hình ảnh của toàn bộ tính năng. Không đọc license, không sửa bộ cài. Những file nguồn không chứa control GUI vẫn được lưu để giữ đủ 1.800 XML trong phạm vi quét.
