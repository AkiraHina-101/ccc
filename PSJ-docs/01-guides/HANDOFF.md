# SESSION UPDATE 2026-07-12
#
# Record Current File: GT PASS. A new live record block for Part(565) was
# appended to recorded.py at 01:26:08 after the user pressed PSJ Record.
#
# Root cause fixed: VSCode had opened the parent workspace, while the old
# extension relied on tasks below vscode-psj/.vscode. The extension now finds
# the nearest folder containing record.py and send.py and invokes tools
# directly. The installed extension JavaScript was updated and syntax checked.
# PSJ-Jupiter.code-workspace is optional; status-bar controls no longer depend
# on which parent folder VSCode has opened.
#
# Next priority: choose one representative mixed PSJ/JPL/provider workflow,
# then build the first unified timeline. Do not reopen Record Current File
# unless a regression is reported.

# vscode-psj — HANDOFF ĐẦY ĐỦ

> Tài liệu này TỰ ĐỦ để bất kỳ AI agent nào (Claude, Codex, ...) hoặc người mới
> tiếp tục công việc mà không cần lịch sử chat. Đọc hết trước khi sửa bất cứ gì.
> Cập nhật lần cuối: 2026-07-11.

---

## 1. SỨ MỆNH

Xây cho Jupiter (TechnoStar, phần mềm CAE pre/post) một **trải nghiệm scripting
ngang SpaceClaim**: kỹ sư thao tác GUI → code Python hiện ra trong editor →
sửa tùy ý → chạy lại ngay → tích lũy thành thư viện macro của team.

Tầm nhìn dài hạn: **khắc phục có nguyên tắc các điểm yếu của core Jupiter**
(lệnh không được journal, API hai bề mặt lệch nhau) bằng một lớp tool bên ngoài,
theo chiến lược 3 tầng:

| Loại lệnh | Chiến lược |
|---|---|
| Được journal (ghi vào log) | Record trực tiếp (ĐÃ XONG) |
| Có API nhưng KHÔNG journal (hide/show...) | Snapshot trạng thái đích + snippet chèn tay (ĐANG LÀM) |
| Không có cả API | Ghi danh sách, gửi yêu cầu TechnoStar |

Đích UX cuối: record CHÈN CODE TẠI CON TRỎ như SpaceClaim → cần viết
extension VSCode nội bộ (giai đoạn sau).

## 2. RÀNG BUỘC CỨNG (user đặt ra — VI PHẠM LÀ HỎNG)

1. **KHÔNG sửa/thêm/xóa BẤT KỲ file nào trong `C:\Program Files\TechnoStar\`**
   (kể cả `Lib\site-packages` của python.exe trong đó).
2. **KHÔNG tải thư viện/extension ngoài** trừ khi đã kiểm chứng giấy phép
   miễn phí + cho phép thương mại VÀ user đồng ý. Đã được duyệt: VSCode,
   extension Python + Pylance (Microsoft). psutil PyPI KHÔNG cài — dùng shim.
3. **KHÔNG sửa file trong `jupiterutils/`** (bản gốc TechnoStar giải nén ra) —
   mọi bổ trợ viết file MỚI bên cạnh.
4. Cấm đọc file license của Jupiter (`license/`, JPTR_license.dll...).
5. Theo luật chung workspace: đọc `../CLAUDE.md` + `../docs/AGENT_PLAYBOOK.md`.
   Tóm tắt: test tĩnh (`py_compile`) trước khi giao; user là ground truth;
   một thay đổi logic mỗi vòng; mơ hồ thì HỎI.

## 3. KIẾN TRÚC (đã chạy thật, user xác nhận)

```
VSCode (chỉ là editor + terminal)
  ├─ interpreter = C:\Program Files\TechnoStar\Jupiter_5.0.4\python.exe
  │    (Python 3.9.0 của Jupiter — có sẵn pywin32/numpy/scipy/PySide2/tkinter,
  │     THIẾU psutil → thay bằng psutil.py shim trong folder này)
  ├─ Pylance đọc source jupiterutils/ → autocomplete + tooltip JPT.* (docstring đầy đủ)
  │
  ├─ CHIỀU GỬI:  WM_COPYDATA → cửa sổ tiến trình DCAD_main.exe (Jupiter đang chạy)
  │    JPT_RUN_LINE(str)  : chạy 1 lệnh, CÓ kết quả trả về (2 chiều)
  │    JPT_RUN_CODE(str)  : chạy block, bắn-rồi-quên
  │    JPT_RUN_FILE(path) : Jupiter tự exec cả file, bắn-rồi-quên
  │
  └─ CHIỀU RECORD (chỉ ĐỌC log Jupiter tự sinh trong %TEMP%\TechnoStar\NN\):
       PSJCommands.py : lệnh Python sạch (THIẾU lệnh hiển thị)
       <tên model>.jpl : macro gốc ghi nhiều hơn (View*, select method...)
                         — NHƯNG hide/show cây Assembly KHÔNG có ở cả 2 log
```

### File trong folder này

| File | Vai trò |
|---|---|
| `jupiterutils/` | Bản gốc TechnoStar (từ `Jupiter_5.0.4\tools\jupiterutils-3.9.tar.gz`). KHÔNG SỬA. |
| `psutil.py` | Shim thay psutil PyPI (ctypes Toolhelp32Snapshot). jupiterutils import nó. |
| `record.py` | Record: `live`/`livefull` nhận file đích tùy chọn và khóa đích suốt phiên; mặc định vẫn `recorded.py`. Từ chối ghi vào file tool/jupiterutils, append không ghi đè. Có `--self-test`. |
| `send.py` | Gửi nguyên 1 file vào Jupiter chạy (`JPT_RUN_FILE`). Dùng cho file record. |
| `insert_selection.py` | Provider snapshot đầu tiên: đọc FACE/PART đang chọn qua IPC, sinh `SelectionByIDs` và chép snippet vào clipboard. Có `--self-test`. |
| `insert_visibility.py` | Provider BODY visibility v1: đọc `DItem.isHidden`, sinh baseline Show All rồi Hide từng BODY; strict parser chống IPC stale. Có `--stdout`/`--self-test`. |
| `psj_autocomplete.py` | Typing facade chỉ dùng dưới `if TYPE_CHECKING`: kế thừa toàn bộ gợi ý `JPT.*` và gắn thêm `BoolType`, `DItemType`, `DTableType` để Pylance hiểu cú pháp native mà không shadow `JPT` lúc Jupiter exec. |
| `vscode-extension/` | Extension nội bộ tự viết, không dependency: 4 nút Record/Stop/Run/Insert. Bản 0.3.0 đã cài local; Record save rồi dùng file Python đang mở làm đích. |
| `recorded.py` | Sổ nháp record (append, không ghi đè). Đoạn "chín" thì user cắt sang file macro riêng. |
| `test_hello.py` | Script test đường ống (GetProgramPath + GetSelectedFaces). |
| `.vscode/settings.json` | interpreter + PYTHONPATH + Pylance extraPaths; bật `editor.wordWrap=on` để dòng dài tự bẻ theo chiều rộng editor mà không đổi nội dung/compile. |
| `.vscode/tasks.json` | 6 task; Record Start/Full truyền `${file}` để ghi file hiện tại, Stop không tự mở file khác. PowerShell: lệnh phải có `&` trước path có dấu cách. |

### Phím tắt (nằm ở USER-LEVEL: `%APPDATA%\Code\User\keybindings.json`)

| Phím | Task | Ghi chú |
|---|---|---|
| Ctrl+Alt+R | Record Start (live, nguồn PSJ) | Code hiện dần trong recorded.py ~0.5s |
| Ctrl+Alt+F | Record Full (live, nguồn JPL) | Ghi cả View*, bọc JPT.Exec. Nhiễu nhiều hơn |
| Ctrl+Alt+S | Record Stop (chung cả 2 chế độ) | |
| Ctrl+Shift+B | Send to Jupiter (file đang mở) | Kết quả ở cửa sổ Python API của Jupiter |
| Run ▶ | Chạy script wrapper JPT.* | Kết quả về terminal VSCode |

KHÔNG chạy 2 chế độ live cùng lúc (ghi chung recorded.py, sẽ trộn lẫn).

## 4. HAI "PHƯƠNG NGỮ" SCRIPT — QUY TẮC SỐNG CÒN

1. **Cú pháp PSJ nội bộ** (từ record): `Assembly.RightClick.ChangeEntityColor(crlEntities=[Face(...)], iColor=...)`.
   Chỉ chạy BÊN TRONG Jupiter → dùng Ctrl+Shift+B / `send.py`. Bấm Run ▶ = TypeError.
2. **Cú pháp wrapper** (tự viết): `from jupiterutils import *` + `JPT.GetSelectedFaces()`...
   Chạy bằng Run ▶, mỗi lệnh được wrapper gửi IPC sang Jupiter, kết quả về terminal.

Lý do lệch: wrapper sinh từ nguồn khác với journal (`crlEntity` vs `crlEntities`)
— drift giữa 2 bề mặt API của TechnoStar, KHÔNG sửa được, phải sống chung.

## 5. SỰ THẬT ĐÃ KIỂM CHỨNG (đừng kiểm chứng lại)

- IPC 2 chiều CHẠY THẬT: `JPT_RUN_LINE("JPT.GetProgramPath()")` trả về đúng path;
  `GetSelectedFaces` trả FaceVector qua IPC. User xác nhận trên máy thật.
- Vòng record → sửa → replay ĐÃ KHÉP KÍN, user chạy hoàn hảo bằng phím tắt.
- Extension VSCode chính chủ `nhatvu148.jupiter` ĐÃ BỊ GỠ khỏi Marketplace và
  GitHub (404, API query 0 kết quả) — ĐỪNG tìm lại. Autocomplete qua Pylance là đủ.
- Hide/show cây Assembly KHÔNG được journal (đã test: chỉ ViewSelectMethod lọt vào JPL).
  API thay thế CÓ THẬT (tra từ kho `C:\psj-project\psj_knowledge\INDEX.md`):
  `JPT.ShowHideEntitiesByID(DTableType, id, BoolType)`, `JPT.ShowHideAllParts(BoolType)`,
  `JPT.InverseHideBodies(partID)`.
- GT 2026-07-11: `ShowHideEntitiesByID(DTABLE_BODY, 608, FALSE_VAL/TRUE_VAL)` đã
  Hide rồi Show thật trên Jupiter 5.0.4. API ghi visibility được xác nhận hai chiều.
- GT 2026-07-11: Insert Selection FACE đã PASS cả ID lẫn mắt user với hai face
  `228751986`, `1111573`; clear rồi replay highlight lại đúng hai mặt ban đầu.
- GT 2026-07-11: Extension 0.2.0 `Ctrl+Alt+I`/`PSJ Insert` đã chèn selection thẳng
  tại con trỏ thành công; provider + UX Insert Selection chính thức DONE.
- GT 2026-07-11: API ĐỌC visibility đã tìm và chạy thật. Phải dùng
  `JPT.GetAllByTypeID(JPT.DItemType.BODY)` để lấy `DItem.isHidden`; part 608 đo được
  `False → True → False` khi Show/Hide/Show. `JPT.GetAllParts()` trả `DBody` runtime
  KHÔNG có `isHidden`, dù tài liệu base class dễ gây hiểu nhầm — không dùng đường này.
- File PSJ nội bộ dùng `JPT` global vẫn chạy trong Jupiter nhưng Pylance sẽ gạch đỏ nếu
  không có khai báo. KHÔNG import runtime trực tiếp vì có thể shadow `JPT` native.
  Mẫu đã chốt: `from typing import TYPE_CHECKING` rồi trong block đó import
  `JPT` từ `psj_autocomplete`; facade bù các enum lồng mà wrapper TechnoStar khai báo lệch.
  Không cần cài thư viện mới. Static test facade + `py_compile` PASS.
- Cập nhật 2026-07-11: `psj_autocomplete` export toàn bộ tên public mà package
  `jupiterutils` v5.0.4 biết (đã test có `Assembly`, `PART_COLOR_PAIR`, `Part`, `JPT.*`
  và enum). `record.py` tự chèn block `TYPE_CHECKING` vào `recorded.py` nếu thiếu và
  bỏ qua nếu đã có, nên record nhiều lần không nhân đôi import. Đây là autocomplete
  cho API/documented wrapper đã extract, không cam kết mọi thao tác UI Jupiter đều có API.
- Pylance không theo được một số tên qua wildcard bắc cầu và hiểu sai các hàm wrapper
  thiếu `@staticmethod`. Ca đầu tiên đã sửa trong facade: explicit export `Part` và override
  typing `JPT.Exec(Input1_str: str)`. Không sửa nguồn `jupiterutils`. Static test PASS.
- Máy có Jupiter 5.0.1 và 5.0.4; đang dùng 5.0.4. VSCode 1.127.

## 6. HẠN CHẾ ĐÃ BIẾT (chưa xử lý)

- Kênh trả về của `JPT_RUN_LINE` (PSJ_Interpreter.py): biến global + lọc bỏ
  ký tự non-ASCII + `replace('64)]','')` — tên part tiếng Nhật/Việt sẽ mất chữ,
  kết quả lớn có thể hỏng. Nếu biểu thức Jupiter lỗi/không gửi response, wrapper có thể
  trả lại kết quả cũ trong biến global (`None` stale đã thấy khi probe `DBody.isHidden`),
  nên provider phải validate schema chặt và không coi `None` là trạng thái hợp lệ.
- `SendMessageToJupiter` broadcast tới MỌI cửa sổ của DCAD_main.exe —
  2 phiên Jupiter mở cùng lúc = hành vi khó lường.
- Record live ghi dòng phân cách kể cả khi không có lệnh mới (rác nhẹ trong recorded.py).
- File đích được khóa lúc Record Start; user KHÔNG sửa file trong lúc live, Stop rồi mới sửa.
- `RUN_FILE`/`RUN_CODE` không báo lỗi về VSCode — lỗi chỉ hiện ở cửa sổ
  Python API của Jupiter (Home > Window > Python API).
- ID trong macro record là ID đông cứng — model khác/remesh là sai đối tượng.
- `isHidden` chỉ là show/hide logic; không đại diện cho occlusion, ngoài viewport,
  section/clipping, transparency hay partial visibility. Suppression là state riêng.
- Restore visibility dùng external body `id`; nếu model có ID trùng thì provider v1 phải
  dừng thay vì replay mơ hồ. Snapshot lưu thêm `key` để chẩn đoán nhưng API ghi nhận `id`.

## 7. VIỆC KẾ TIẾP (theo thứ tự ưu tiên, MỘT VIỆC MỖI VÒNG)

1. **Insert Selection helper — DONE (2026-07-11)**:
   `insert_selection.py` đọc ID FACE + PART, sinh dòng dùng
   `JPT.BoolType.TRUE_VAL`, chép clipboard; task `Insert Selection` đã thêm.
   Static test + `py_compile` đã PASS. CHƯA coi là xong cho tới khi user chạy task
   trên Jupiter 5.0.4 và paste nguyên console. Sau khi GT xác nhận mới thêm phím tắt
   user-level và chốt UX.
   Agent tự test cùng ngày: gọi live tới Jupiter thành công khi không có selection,
   nhận FACE/PART rỗng và dừng đúng; clipboard Win32 round-trip PASS, nội dung clipboard
   cũ đã được khôi phục. GT PART/BODY đã PASS trên Jupiter thật: selection ID `608`
   sinh đúng `JPT.SelectionByIDs(JPT.DItemType.BODY, [608], JPT.BoolType.TRUE_VAL)`
   và clipboard khớp. FACE programmatic GT ngày 2026-07-11 cũng PASS với hai ID
   `228751986`, `1111573`: clipboard khớp, `ClearAllSelection` rồi replay snippet trả lại
   đúng cùng hai ID; user đã xác nhận bằng mắt highlight đúng. Extension nội bộ 0.2.0
   đã thêm nút `PSJ Insert` + `Ctrl+Alt+I`, gọi helper `--stdout` và chèn thẳng tại con
   trỏ mà không đổi clipboard; đã cài local, Python/JS/manifest static PASS; user đã
   xác nhận chèn thật thành công.
2. **Snapshot hiển thị BODY v1 — LOGIC DONE (2026-07-11)**:
   đọc bằng `GetAllByTypeID(BODY)` + `DItem.isHidden`; ghi bằng
   `ShowHideEntitiesByID`. `insert_visibility.py` đã sinh đúng snapshot khi ID 608 hidden:
   Show All baseline + Hide 608; replay đọc lại `isHidden=True`, sau test đã khôi phục
   `False`. `py_compile`, self-test, tasks JSON PASS. Chưa DONE cho tới khi user hide một
   BODY thật, chạy task, replay snippet và xác nhận bằng mắt. GT user-driven đã tiến thêm:
   user hide BODY `43`; provider capture đúng `(id=43,key=43)`, agent Show All rồi replay
   chính snippet, verifier đọc lại `isHidden=True`; user xác nhận bằng mắt part 43 đã
   ẩn trở lại đúng. Capture → replay → API verify → visual GT đều PASS. Việc kế tiếp chỉ
   là UX insert-at-cursor cho visibility, chưa mở rộng granularity/state khác.
3. **Record Current File — 0.3.0 STATIC PASS, CHỜ USER GT**:
   nút Record save file hiện tại rồi task truyền `${file}`; recorder append vào đích đã
   khóa, chống ghi đè file tool/jupiterutils. `py_compile`, self-test append, JS/JSON PASS;
   extension 0.3.0 đã cài local. Chờ user reload, record một thao tác và xác nhận code
   xuất hiện trong đúng file đang mở.
4. **Visibility UX**: thêm insert-at-cursor cho provider BODY đã DONE.
5. **Snippet library** team: bắt đầu bằng show/hide part (`JPT.ShowHideEntitiesByID`...).
6. **Bộ làm sạch/tham số hóa** code record (gom lệnh lặp, bỏ nhiễu View*, thay ID bằng biến).

### Bản đồ khoảng trống core cần lớp tool bù (thiết lập 2026-07-11)

- Provider đã bật: snapshot selection FACE/PART → code tái lập selection.
- Provider đang GT: snapshot visibility cho BODY. API đọc đã chốt là
  `GetAllByTypeID(BODY)` → `DItem.isHidden`; API ghi đã xác nhận gồm
  `ShowHideEntitiesByID`, `ShowHideAllParts`, `InverseHideBodies`.
- Sau visibility: khảo sát view/display state và các thao tác có API nhưng không journal;
  chỉ thêm provider khi tìm được API đọc trạng thái đích đáng tin cậy.
- Thao tác không có cả journal lẫn API: ghi danh sách bằng chứng để gửi TechnoStar,
  không giả lập bằng tên hàm tự đoán.

## 8. ROADMAP DÀI HẠN ĐÃ CHỐT — HƯỚNG TỚI TRẢI NGHIỆM SPACECLAIM

### 8.1. Định nghĩa đích đến

Đích sản phẩm không phải là "ghi được nhiều dòng log", mà là vòng lặp có kiểm chứng:

```
GUI Jupiter → code dễ hiểu trong VSCode → sửa tham số → chạy lại → xác nhận trạng thái đích
```

"Hoàn thiện" nghĩa là **100% workflow P0/P1 do user thống nhất** đi hết vòng trên mà
không có lỗi âm thầm. Không cam kết bắt 100% mọi click của Jupiter khi core không cung cấp
journal/API/macro hoặc trạng thái có thể kiểm chứng. Gap như vậy phải được ghi bằng bằng
chứng và chuyển thành yêu cầu rõ ràng cho TechnoStar.

### 8.2. Thang chiến lược cho từng thao tác

Áp dụng từ trên xuống, chỉ xuống tầng sau khi tầng trước không đủ:

1. **PSJ journal**: lấy code trực tiếp, giữ thứ tự.
2. **JPL/macro nội bộ**: bọc `JPT.Exec(...)`, đánh dấu nguồn và độ tin cậy.
3. **State snapshot**: có API đọc + ghi → chụp trước/sau, diff, sinh code trạng thái đích.
4. **GUI adapter có kiểm chứng**: chỉ dùng khi không có API nhưng có thể xác nhận trạng thái
   sau thao tác; ưu tiên Win32 có sẵn, không tải dependency ngoài khi chưa được duyệt.
5. **Core gap**: nếu không có đường đáng tin cậy thì ghi nhận, không giả vờ hỗ trợ.

### 8.3. Kiến trúc mục tiêu

```
Nguồn: PSJ log | JPL log | Snapshot providers
                    ↓
      Timeline hợp nhất + loại trùng + gắn nguồn
                    ↓
       Cleaner + parameterizer + entity resolver
                    ↓
          Script/snippet chèn tại con trỏ
                    ↓
              Replay vào Jupiter
                    ↓
       Verifier: chụp lại và so với trạng thái đích
```

Mỗi khả năng bù core là một provider độc lập với giao ước khái niệm:
`capture_before → capture_after → diff → emit_replay_code → verify`.
Provider hỏng không được làm hỏng recorder/provider đã được user xác nhận.

### 8.4. Các chặng và cổng nghiệm thu

**Chặng A — External IDE ổn định (gần hoàn thành)**

- IPC gửi/nhận, record/replay, Pylance facade, task/phím tắt và extension tối thiểu.
- Cổng: không sửa core Jupiter; mọi tool `py_compile` PASS; lỗi có thông báo `[TAG]`.

**Chặng B — Selection provider (đang làm)**

- FACE/PART/BODY trước; NODE/ELEM/EDGE chỉ thêm theo nhu cầu đã chốt và API đã tra.
- Cổng: static test + GT từng loại + clipboard + replay chọn lại đúng entity.

**Chặng C — Visibility provider (kế tiếp)**

- Tìm API ĐỌC visible; API GHI body đã có GT hai chiều.
- Cổng: snapshot trước/sau, sinh code hide/show, replay và verifier khớp trên model thật.

**Chặng D — Unified Recorder**

- Hợp nhất PSJ + JPL + snapshot theo timeline; loại trùng và nhiễu có rule rõ ràng.
- Cổng: workflow mẫu hỗn hợp giữ đúng thứ tự và không làm mất lệnh có ý nghĩa.

**Chặng E — Code thân thiện người không biết code**

- Cleaner, chú thích tiếng Việt, vùng tham số, formatter danh sách ID, snippet library.
- Cổng: user chỉ cần đổi tên/số/màu/True-False để tái sử dụng macro mẫu.

**Chặng F — Entity resolver chống ID cứng**

- Tên part + loại entity + đặc trưng hình học + quan hệ topology + fallback ID.
- Cổng: không khớp thì dừng/cảnh báo; tuyệt đối không âm thầm chọn nhầm sau remesh.

**Chặng G — Replay Verifier**

- Kiểm selection, visibility, display/view và trạng thái nghiệp vụ có API đọc.
- Cổng: kết quả `PASS/DIFFERENT/MISSING/UNVERIFIABLE` rõ ràng, không chỉ "đã gửi".

**Chặng H — UX VSCode tương xứng SpaceClaim**

- Record/Stop/Run, insert-at-cursor, run selection, provider commands, trạng thái kết nối,
  Clean/Parameterize/Verify; đóng gói extension nội bộ không phụ thuộc Marketplace.
- Cổng: workflow P0 thực hiện được bằng nút/phím, không cần user sửa hạ tầng bằng tay.

**Chặng I — Thư viện team + quản trị core gap**

- Macro đã GT theo nghiệp vụ CAE, metadata phiên bản/model/phạm vi test.
- Danh sách gap có bước tái hiện, log, API cần bổ sung và mức ảnh hưởng để gửi TechnoStar.

### 8.5. Bảng độ bao phủ sống (cập nhật sau mỗi GT)

| Khả năng | Capture | Replay | Verify | GT Jupiter 5.0.4 | Trạng thái |
|---|---|---|---|---|---|
| PSJ journal | Có | Có | Thủ công | PASS | Ổn định |
| JPL journal | Có, nhiều nhiễu | Có qua `JPT.Exec` | Thủ công | PASS cơ bản | Cần cleaner |
| Record current file | PSJ/JPL live | n/a | Kiểm file đích | Static PASS 0.3.0 | Chờ user GT |
| Selection PART/BODY | Snapshot | `SelectionByIDs(BODY)` | Nhìn model | PASS ID 608 | Chờ chốt UX |
| Selection FACE | Snapshot | `SelectionByIDs(FACE)` | ID + nhìn model | PASS: `228751986`, `1111573` | DONE cả UX 0.2 |
| Hide/show BODY | Provider v1 | Có | `DItem.isHidden` | PASS ID 608 + full GT ID 43 | Logic DONE; chờ UX |
| View/display | Một phần qua JPL | Một phần | Chưa | CHƯA | Chờ khảo sát |
| Cleaner/parameterizer | Chưa | n/a | Static + GT | CHƯA | Chặng E |
| Semantic entity resolver | Chưa | Chưa | Chưa | CHƯA | Chặng F |
| Replay verifier | Chưa | n/a | Mục tiêu chính | CHƯA | Chặng G |
| VSCode extension | 4 nút | Run + Insert | Chưa | Insert 0.2 PASS; Record 0.3 chờ GT | Mở rộng tuần tự |

Không tự gán phần trăm độ bao phủ khi chưa có danh mục workflow. User và agent sẽ lập
danh sách workflow P0 (hằng ngày/bắt buộc), P1 (thường dùng), P2 (hiếm); độ bao phủ được
tính theo workflow chạy đúng đầu-cuối, không tính theo số hàm API tìm thấy.

### 8.6. Definition of Done cho mọi tính năng

Một tính năng chỉ được chuyển sang DONE khi đủ tất cả:

1. API/command đã tra trong kho v5.0.4, không bịa.
2. Chỉ một thay đổi logic trong vòng.
3. `py_compile` và static test liên quan PASS.
4. Console có `[TAG]` và lỗi hành động được.
5. User chạy trên Jupiter thật, paste số liệu/console và xác nhận bằng mắt khi cần.
6. Kiểm regression các ca đã PASS trước đó.
7. Cập nhật bảng coverage + bài học + việc kế tiếp trong HANDOFF này.

### 8.7. Thứ tự thực thi đã khóa từ trạng thái hiện tại

1. User Reload Window và GT Record Current File 0.3.0 trên một file macro thử.
2. Sau PASS, thêm visibility insert-at-cursor vào extension bằng provider BODY đã DONE.
3. Tiếp tục inventory/provider UX theo P0/P1, rồi unified timeline/cleaner theo roadmap.
4. Dựng timeline chung PSJ/JPL/provider trên workflow hỗn hợp đầu tiên.
5. Cleaner/parameterizer tối thiểu; sau đó mới mở rộng extension UI.
6. Lập backlog P0/P1/P2 cùng user và lặp provider → GT → coverage cho tới khi P0/P1 đạt DONE.

## 9. QUY TRÌNH LÀM VIỆC VỚI USER

- User KHÔNG rành core phần mềm — giải thích bằng khái niệm, không giả định biết sẵn.
- User là ground truth: mọi tính năng phải được user chạy thật trên Jupiter
  và paste kết quả console xác nhận rồi mới coi là xong.
- Sửa file đang được VSCode mở → dặn user: chọn Revert/Reload khi VSCode hỏi
  "file changed on disk", KHÔNG Save đè (đã mất dữ liệu 1 lần vì vụ này).
- Kho tra cứu PSJ: `C:\psj-project\psj_knowledge\README.md` — TRA trước khi
  viết lệnh PSJ mới, KHÔNG bịa tên hàm/tham số.
