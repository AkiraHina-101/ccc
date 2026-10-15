# Ngôn ngữ bố cục GUI Jupiter / PSJ

Ngày khảo sát: **2026-10-14**. Nguồn đang cài: **Jupiter 5.0.4**.

GUI tool PSJ nên giống một form kỹ thuật gọn: nhãn rõ, các ô cùng cột, nhóm theo công việc và kết quả đặt ngay dưới phần nhập. Học cấu trúc của Jupiter rồi chọn phần phù hợp với tool; không bê toàn bộ màn hình tùy chọn mesher vào một công cụ chỉ cần vài thao tác.

## Phạm vi và độ chắc chắn

Đã đọc và parse **toàn bộ 1.800 XML dưới `template/`**, ghi nhận **1.797 định nghĩa có thành phần GUI**, trong đó **1.791 có `Window`**. Inventory bao gồm 41 thư mục nhóm tính năng và các XML tại root. Cả 1.800 file đều parse thành công; không cần suy đoán từ XML lỗi. Đã đọc sâu **17 form đại diện** bên dưới, cùng help của Layout, TextBox, GroupBox và Table.

Đây là khảo sát **định nghĩa nguồn**, không phải chứng nhận đã mở và nhìn mọi dialog đang chạy. Một tính năng có thể có nhiều XML, nhiều trang hoặc được ghép thêm bởi code; tên `Test`/`CUSTOM` không bảo đảm tính năng xuất hiện trong menu đang dùng. Một số màn hình có thể được dựng trong binary hoặc động ở runtime, ngoài phạm vi `template/`. Số lượng XML không phải số lượng tính năng được cấp phép.

Không chạy feature, không thao tác model, không chụp màn hình hoặc điều khiển Windows. Không sửa file cài đặt; không đọc license. Hai ảnh người dùng cung cấp là bằng chứng về diện mạo native tại phiên của họ, không phải bộ ảnh khảo sát toàn phần mềm.

Tra cứu toàn bộ nguồn qua [inventory theo nhóm](../reference/ui-design/README.md) và [inventory JSON](../reference/ui-design/jupiter-5.0.4-ui-inventory.json). JSON lưu đường dẫn nguồn, title, group, các control/thuộc tính, kích thước khai báo, số byte và SHA-256 từng XML.

## Những mẫu đã xác nhận từ nguồn

| Mẫu | Bằng chứng | Điều nên học |
|---|---|---|
| Form tọa độ nhiều hàng | Transform Part / 3 Points (`template/Test/3points.xml`) | Ba hàng lặp cùng nhãn rộng 20, hai ô rộng 100, margin `5,3,0,0`; cột không đổi theo nội dung từng hàng. Đây là template trùng title của ảnh mới. |
| Form tùy chọn dọc | Transform Part / Position (`template/Geometry/TransformPart/Transform_Body_Position.xml`) | Nhãn rộng 120 lặp lại, checkbox đặt trên cùng một trục; nhóm Operation và Position riêng. |
| Giá trị đo đặt dọc | Distance / 2Points (`template/CommonTools/Measurements/Distance/2Points.xml`) | Distance, Delta X/Y/Z, Input Unit dùng nhãn 120 và ô 90 thống nhất; nhóm Output riêng. |
| Form kỹ thuật dài | Create Cylinder (`template/Geometry/CreateEntity/Parts/Cylinder.xml`) | Tọa độ, radius, height dùng nhãn 130/ô 90; đặt thuộc tính part tách khỏi thông số hình học. |
| Nhiều nhóm mesher | SurfMeshing2D (`template/Meshing/Meshing/SurfMeshing/SurfMeshing2D.xml`) | Hàng nhãn 130/ô 90; các nhóm có cùng quy tắc cột, ghép đôi khi cần chiều rộng. |
| Form mesher gọn | SolidMeshing (`template/Meshing/Meshing/SolidMeshing.xml`) | Nhãn 100/ô 60, các nhóm Mesh Type, Attributes, Force Clean; số cột vừa nhu cầu, không bắt buộc hai cột. |
| Cleanup cục bộ | Remesh Element (`template/MeshCleanup/Manual/Remesh_Elem_Tri3_Quad4.xml`) | Hai nhóm ngắn, nhãn 140/ô 90; không tạo một vùng trống dài để đạt chiều cao tùy ý. |
| Đối tượng chọn có danh sách | LBC RBE2 (`template/LBC/Connection/RBE2.xml`) | Nút Select Body/Node/Face, danh sách ID và ô count đi cùng nhau; option của công cụ tổng quát nhiều hơn nhu cầu tool chuyên biệt. |
| Renumber có preview | Renumber By Selection (`template/CommonTools/RenumberSpecific.xml`) | Start ID/Increment cùng cột; Preview Table và nút Preview nằm trong nhóm riêng; không trộn một thao tác ID với dữ liệu đo hình học. |
| Renumber bảng property | Property Renumber (`template/Property/ElemRelatedInfo/RenumberPropertyTable.xml`) | Bảng phía trên, option ID phía dưới, footer riêng; thao tác của bảng ở gần bảng. |
| Dialog phụ nhỏ | Set Column Width (`template/PSJ-GUI/SetColumnWidthDlg.xml`) | Một hàng Label/TextBox và hai nút 60×20; dialog không bắt buộc dùng kích thước của form chính. |
| Import một giá trị | Import STL (`template/Pre/ImportSTL.xml`) | Một nhóm Face Split, một hàng Element Angle và OK/Cancel; chỉ hiện lựa chọn liên quan. |
| Tìm kiếm và bảng kết quả | Find Contact (`template/Connection/FindContact.xml`) | Nhãn 120/ô 150; Find Contact sát phần nhập, ListView phía dưới có cột đặt tên cụ thể. |
| Dữ liệu nhiều dòng | Abaqus Time points (`template/Analysis/Abaqus/Abaqus_step_time_points.xml`) | GridCtrl được dùng cho dữ liệu lặp; trang tương ứng được đặt trong StackPaneCtrl/PageItem. |
| Bảng chọn kết quả | Modes Select (`template/Post/DynamicAnalysis/ModesSelect.xml`) | ListView có cột Name/Frequency; Check All và Set Sel Check sát danh sách; footer OK/Cancel. |
| Post-processing gọn | Comparison Contour Setting (`template/Post/Comparison/ContourSetting.xml`) | Ba nhóm nhỏ, nhãn 100/ô 100 lặp; cột không phụ thuộc nhãn dài hay ngắn. |
| Bảng vật liệu có đơn vị | Specific Heat (`template/Property/Material/Specific_Heat_Setting_dialog.xml`) | Option, Unit rồi GridCtrl; đơn vị được mô tả rõ, không suy ra từ số trong ô. |

Các width/height/margin trên là **giá trị khai báo trong template**. Help gọi đơn vị là pixel và width/height của nhiều component là kích thước tối thiểu. Không lấy chúng làm số pixel thực sau Windows DPI, font, theme hoặc resize. Khi dùng JDG cần kiểm chứng cách API hiện tại chuyển kích thước khai báo thành bố cục thật.

Một lần kiểm chứng JDG ghi nhận cột khai báo **42/72/72** được getter đọc lại thành **53/90/90**. Tỉ lệ gần **1,25** nhất quán với scale 125%; đây là suy luận từ giá trị đọc lại, không phải kết quả dò cài đặt Windows. Khi so sánh các bảng, dùng cùng số cột/width và cùng tỉ lệ; không giả định getter luôn bằng width khai báo hoặc nhân DPI lần nữa trước khi đưa vào builder.

## Bố cục nên dùng cho tool PSJ

### 1. Một trục căn cột cho cả form

Chọn chiều rộng nhãn và ô một lần cho từng loại hàng rồi tái sử dụng. Các hàng Journal và Pin dùng cùng chiều rộng nhãn, cùng điểm bắt đầu và kết thúc ô nhập. Nếu ô selector là chuỗi ID dài, cho nó rộng hơn ô số nhưng hai selector vẫn có cùng width. Không để độ dài nhãn tự đẩy ô bên phải.

Ô nhập dài cùng loại phải trùng cả mép trái và mép phải. Ô số ngắn phải bám một mép của cột nhập đã chọn; ví dụ Increment bám mép trái của các ô Center IDs. Tách checkbox sang cột kế bên. Không cộng width của checkbox/label để suy ra textbox đã align: native có thể scale label, textbox và nút khác nhau.

Với dữ liệu lặp, xác định lưới ở cấp bảng rồi dùng chung cho header và mọi cell. Có thể một đối tượng là một hàng, hoặc một đối tượng là một cột nếu cần so sánh cùng vài thuộc tính. Crank hiện dùng Pin ở trên, Journal ở dưới, mỗi bảng có hàng Radius/Width và cột #1…#x theo số face; thứ tự tăng theo tọa độ X của tâm. Đơn vị mm đặt ở tiêu đề nhóm. Đừng tạo từng cell bằng kích thước độc lập hoặc sửa lệch bằng khoảng trắng trong text.

### 2. Sắp xếp theo thứ tự thao tác

Một công cụ chọn hai nhóm nên đặt phần chọn nhóm thứ nhất rồi nhóm thứ hai theo chiều dọc. Bảng kích thước nằm dưới phần chọn để người dùng đọc theo thứ tự: chọn → đo/kiểm tra → thực hiện. Hai cột chỉ nên dùng khi cần đối chiếu dữ liệu có cùng cấu trúc hoặc form thực sự có nhiều option. Nguồn native có cả một cột lẫn hai cột, không có quy tắc bắt mọi tool chia đôi.

Khoảng cách lớn chỉ nên phân tách nhóm công việc. Không dùng height lớn cho một group ít control để cân bằng với group khác; không đặt spacer dọc kéo dài giữa trạng thái và nút.

### 3. Thu gọn khoảng cách bằng quy tắc chung

Inventory ghi nhận TextBox khai báo height **18 hoặc 20** rất thường xuyên; margin **`5,3,0,0`**, **`5,0,0,0`**, **`5,5,5,5`** lặp nhiều. Đây là điểm bắt đầu để thử form gọn, không phải bộ token bắt buộc cho mọi dialog.

Với một form cụ thể, nên dùng cùng chiều cao ô cho các hàng cùng chức năng, một khoảng cách hàng nhỏ, một khoảng cách nhóm lớn hơn khoảng cách hàng. Footer nút chính thường khai báo **80×30**. Có dialog phụ dùng 60×20 hoặc footer 80×25; chọn theo vai trò, không áp dụng một kích thước lên mọi control.

Thu gọn group/status theo nội dung. Vẫn phải chừa đủ chỗ cho focus, nội dung số dài nhất, đơn vị và thông báo một dòng. Không giảm font để che lỗi bố cục; sửa cột và margin trước.

### 4. Giữ diện mạo native

Ảnh người dùng cung cấp có header nhóm xanh nhạt, nền Windows trung tính và focus rõ. Các template đã đọc dùng `TaskPane`/`TaskGroup` hoặc `GroupBoxCtrl`, không khai báo RGB/font tùy chỉnh cho header của những form đó. Vì vậy ưu tiên group/control native để theme Jupiter quyết định màu, font và focus. Chưa có bằng chứng nguồn để chốt một mã hex hoặc tên font chung cho toàn phần mềm.

Không tự vẽ highlight vàng/tím như ảnh selector: màu runtime đó biểu thị trạng thái chọn/focus trong một dialog cụ thể, không phải màu trang trí áp lên mọi input. Kiểm chứng trạng thái picker qua PSJ/JDG trước khi dùng.

### 5. Phân biệt nhập, đo và trạng thái

Giá trị người dùng được sửa dùng control nhập. Giá trị Width/Radius đo từ CAD nên là read-only và vẫn copy được; không dùng ô disabled khiến kết quả khó đọc nếu API có read-only. Help TextBox xác nhận `ReadOnly` ngăn sửa nhưng vẫn cho phép copy, khác với `Enable=false` khiến control xám.

TextBox read-only không chứng minh Table có setter read-only theo cell. Trong lượt sửa Crank này, API JDG công khai được khảo sát không có setter đó; tool dùng `disable_item` cho bảng kết quả để ngăn sửa. Đây là phương án theo API thực có, cần kiểm tra nội dung vẫn đọc được. Không tuyên bố bảng disabled vẫn copy được nếu chưa kiểm chứng native.

Đặt đơn vị trong nhãn hoặc header cột (`Width (mm)`, `Radius (mm)`). Một ô là một giá trị; không gộp mọi Width hoặc Radius thành chuỗi dài làm mất liên hệ với từng đối tượng. Hàng chưa có dữ liệu để trống hoặc dùng ký hiệu trạng thái rõ; không dùng `0` thay cho chưa đo.

### 6. Chỉ hiện quyết định mà người dùng cần đổi

Native RBE2 và Surface Meshing là công cụ tổng quát nên có nhiều tham số. Tool Crank chuyên biệt không phải thể hiện toàn bộ option đó. Theo yêu cầu hiện tại của người dùng, surface profile, 40 segments, W/radial 6 lớp, ratio W cố định, ring 2, tạo RBE2 và 6 DOF là cấu hình ngầm; không đưa trở lại GUI chỉ vì template native có chúng.

Renumber là một hành động riêng: giữ nút riêng và để auto renumber mặc định tắt khi workflow yêu cầu người dùng chủ động xác nhận. Quy tắc ID phụ thuộc ứng dụng; tra cứu và kiểm tra hợp đồng của tool trước khi áp dụng.

### 7. Trạng thái gọn và thông báo có hành động

Chỉ một control trạng thái cho đang chờ/đang chạy/hoàn tất/lỗi. Cập nhật chính dòng này, ví dụ `Ready | 1/12: Validate faces` hoặc `Done | 12/12: Mesh crankshaft TET10`; lỗi thay nội dung bằng nguyên nhân có thể xử lý. Không thêm dòng Completed hay dòng Select lặp lại trạng thái chọn đã có trong control. Chuẩn hóa newline thành khoảng trắng để status luôn một dòng. Timer in console theo yêu cầu; không tạo thêm vùng GUI cho thời gian.

Khóa control khi việc sửa sẽ làm sai workflow đang chạy hoặc dữ liệu đã tạo; tránh khóa sớm ở bước chỉ chọn/đọc. Không đưa popup cho mọi checkpoint hoặc API trả về trung gian. Cảnh báo phải giúp người dùng sửa một giá trị hay lựa chọn cụ thể. Đây là quy tắc cho tool PSJ theo yêu cầu người dùng, không phải kết luận rằng mọi dialog vendor đều đã thực hiện đúng.

### 8. Nút và hành vi phải đi cùng nhau

Footer tách khỏi input/bảng. Các nút cùng vai trò dùng cùng kích thước, một hàng và khoảng cách đều. Nút thao tác bảng như Clear/Preview đặt gần bảng tương ứng. Giữ tên hành động nhất quán giữa nút, trạng thái và console.

Các template cho thấy ID `IDAPPLY`, `IDOK`, `IDCANCEL`, nhưng riêng XML không chứng minh chính xác lifecycle của handler. Không giả định Apply/OK/Cancel của một tool PSJ tự có cùng hành vi chỉ vì đặt tên giống. Cũng không copy nút `>` của panel chọn nếu tool không triển khai selection panel đó.

## API/help hữu ích khi triển khai

| Nguồn | Nội dung được tài liệu xác nhận |
|---|---|
| [Layout](../sources/chm/5.0.4/JPT_API_Help_EN/html/GUI_CommandBuilder_Component-Parameter_Layout.html) | Horizontal/Vertical, margin Left/Top/Right/Bottom; `show_layout` và `hide_layout`. |
| [TextBox](../sources/chm/5.0.4/JPT_API_Help_EN/html/GUI_CommandBuilder_Component-Parameter_TextBox.html) | Align, ReadOnly, Enable, type String/Double/Integer, minimum width/height; `set_item_text`/`get_item_text`. |
| [GroupBox](../sources/chm/5.0.4/JPT_API_Help_EN/html/GUI_CommandBuilder_Component-Parameter_GroupBox.html) | Trạng thái collapse và Enable; dùng grouping native. |
| [Table](../sources/chm/5.0.4/JPT_API_Help_EN/html/GUI_CommandBuilder_Component-Parameter_Table.html) | Grid line, row number, total row count, column settings; đọc/ghi cell và context menu. |

Tên tham số/chữ ký JDG phải được kiểm tra bằng API/runtime 5.0.4 đang dùng. Không chuyển thẳng `GridCtrl` XML thành lời gọi `add_table` suy đoán hoặc lấy ví dụ help làm bảo đảm mọi setter hoạt động như mong muốn.

## Kiểm chứng một GUI mới

1. Đọc builder/helper dùng chung của tool và ghi nhận chiều rộng cột, chiều cao hàng, margin ở một nơi.
2. Kiểm tra tĩnh mọi hàng chọn/dữ liệu dùng đúng bộ cột; header và ô dữ liệu trùng trục. Kiểm tra bảng có đúng số hàng/cột được yêu cầu.
3. Dùng PSJ/JDG trên đúng phiên để tạo dialog của tool. Đọc lại defaults, read-only/enabled, bảng và callback; kiểm tra chuỗi ID dài, số đo có nhiều chữ số và dữ liệu chưa đo.
4. Kiểm tra trạng thái trước chọn, sau chọn, sau đo, đang chạy, hoàn tất và lỗi có thể sửa; không gọi lệnh mesh để chỉ kiểm tra alignment.
5. **Bắt buộc chụp GUI thật và mở ảnh để review trước khi xác nhận đã căn đúng.** Với workflow cần ảnh GUI native, dùng công cụ capture phù hợp và PrintWindow của đúng dialog/PID. Capture phải dùng bounds theo physical DPI để tránh ảnh bị cắt. Không dựng ảnh minh họa rồi coi đó là bằng chứng native.
6. Trên ảnh, kiểm tra mép trái/phải của các ô cùng cột, header/cell cùng trục, thứ tự cột, chữ có bị cắt, status đúng một dòng, khoảng cách nhóm và footer. Đối chiếu bounds control nếu có. Sửa → mở lại dialog → chụp lại cùng trạng thái/viewport → review lại đến khi đạt. Lưu PNG và report kèm phạm vi (phiên, kích thước, số face).
7. Thử dữ liệu trống, số face thường dùng và số face vượt viewport; xác minh grow/shrink không mất cột hoặc giữ số cũ. Bảng disabled không bảo đảm scrollbar/copy hoạt động: nếu dùng resize để xem nhiều cột, ghi rõ giới hạn đó. Không báo "đã kiểm tra ở mọi DPI" từ một ảnh.

Trong một lần kiểm tra native, API chèn vector cột làm đảo header; chèn từng cột theo index đã sửa được thứ tự #1…#x. Cell readback đúng không đủ để xác nhận header hoặc alignment đúng.

Các inventory này có thể được tái tạo bằng công cụ metadata tương ứng của tài liệu MCP, nếu công cụ đó có sẵn trong môi trường làm việc. Việc tái tạo không thuộc phạm vi của corpus tra cứu này.
