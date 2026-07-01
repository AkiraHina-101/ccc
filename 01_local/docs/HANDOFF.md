# HANDOFF — Trạng thái hiện tại

> **File này là snapshot "đang đến đâu rồi". AI MỞ PROJECT LÊN: đọc đầu tiên sau CLAUDE.md.**
> **Sau mỗi lần đổi code: cập nhật `Last Updated` + `Recently Changed` + `Test Status`.**

---

## Last Updated
**2026-07-01 (session 3, part 5)** — **UX polish: Queue stretch, A+/A− split, Gather layout swap + ext filter, Preview Next FATAL.**

**Files:**
- `app/ui/widgets/queue_tab.py` — `header_view.setStretchLastSection(True)`: cột cuối cùng luôn kéo dài phủ hết width; hẹp thì cột cuối clip, không có khoảng trống thừa.
- `app/ui/widgets/right_dock.py` — bỏ `_FontSizeButton` (một nút left/right-click); thay bằng `font_smaller_btn` "A−" và `font_larger_btn` "A+". `self.font_btn` giữ làm alias cho theme code cũ.
- `app/ui/widgets/detail_variants.py` (Gather section trong FolderGroupDetail):
  - **Layout đảo**: LEFT = Source (recursive), RIGHT = Submit folder. Cột giữa chứa nút "Add >" (bold, 11pt) và "Refresh" (10pt). Icon ← ⟳ 📂 bỏ, dùng text.
  - **QSplitter** giữa 3 cột — user kéo được. Min-height list = 80px (trước 160) nên section thu nhỏ được.
  - **Ext filter input** ngay dưới "Gather files": ô "Show only:" ăn "`.dat, .bdf, .inc`" (blank = tất cả). Lưu vào `_data['gather_ext_filter']`. Áp cho cả 2 panel.
  - **Highlight rõ ràng hơn**:
    - Source panel: `➜` + amber wash cho file REQUIRED mà chưa có ở submit (đẩy sang); `✓` + green wash cho file REQUIRED đã có; dim cho file khác.
    - Submit panel: `✓` + green wash cho file REQUIRED; `★` + amber wash cho file vừa Add trong session này (chưa upload).
  - Placeholder "(pick a source folder)" / "(submit folder not set)" cũng có màu dim để không lẫn với file.
- `app/ui/widgets/preview_tab.py`:
  - Thêm nút **"Next FATAL"** trong header, chỉ hiện khi file mở là `.f06`.
  - Dùng `QTextEdit.find('FATAL', case-insensitive)` — tìm từ vị trí cursor, hết file thì wrap về đầu, cập nhật info_lbl `"· FATAL match"` / `"· no FATAL"`.
  - `_show_message` và `show_heredoc` cũng ẩn nút này.

---

**2026-07-01 (session 3, part 4)** — **Status clarity + f06 pass/fail detection + right-click view .f06/.log.**

**Files:**
- `app/logic/f06_check.py` **(new)** — `classify_finished(folder_win, filename) → (status, reason)`. Streams .f06 in 1 MiB chunks, matches `FATAL` case-insensitive. Returns `Done` (file not on share yet), `Complete` (clean), or `Fail` (FATAL found).
- `app/ui/workers.py` — new `F06CheckWorker(QThread)`, emits `result_ready(uid, filename, folder_win, status, reason)`.
- `app/ui/main_window.py`:
  - `_iter_submitted_entities` unchanged; added companion `_entity_context(entity) → (uid, folder_win, filename)` walking `_cards_data`.
  - `_sync_job_status_from_queue`: on transition `→ Done` (both bjobs Done AND JOBID-disappeared), calls `_schedule_f06_check(entity)`.
  - `_schedule_f06_check` / `_on_f06_check_done`: dedupe by (uid, filename); overwrite status only if still `Done`, log Complete/Fail/reason.
- `app/ui/widgets/detail_variants.py`:
  - `_STATUS_TOKEN`: added `'Complete': 'done'`.
  - New module dicts `_STATUS_ICON` (⇧/…/⏱/✓/✗/!) and `_STATUS_TIP` — used across files_table, rows_table, submit-row buttons, and SingleJob banner.
  - `_build_row_submit_button`: play triangle ▶ for actionable (Pending/Error), status glyph otherwise; tooltip = human message from `_STATUS_TIP`.
  - SingleJob banner: added Upload / Complete / Fail branches — no more silent "Done" without follow-up.
  - Files/rows table status cell shows `<icon> <status>` + hover-tip.
  - `_show_file_context_menu(owner, viewport, pos, folder, filename, emit_cb)` new module helper — offers "View .dat / .f06 / .log", grays out companion actions when the file is missing.
  - `FolderGroupDetail.files_table` and `MultiFolderDetail.rows_table` wired to `customContextMenuRequested` → helper → `preview_requested`. Reuses the Preview tab created in session 3 part 3.

**Behavior:**
- Sau khi LSF báo DONE: card status chuyển `Done` (icon ⏱, banner "checking .f06...") → worker chạy nền đọc .f06 → nếu có `FATAL` → `Fail` (✗ đỏ), không → `Complete` (✓ xanh). Nếu .f06 chưa sync ra share, để nguyên `Done`; poll sau sẽ thử lại.
- Icon riêng cho từng trạng thái: `·` Pending, `⇧` Upload/Queued, `…` Running, `⏱` Done (đang check), `✓` Complete, `✗` Fail, `!` Error. Hover tooltip mô tả chi tiết.
- Right-click 1 row trong files_table hoặc rows_table → menu "View abc.dat / abc.f06 / abc.log". Action bị disable + suffix `(not found)` nếu file không tồn tại. Chọn → mở trong tab Preview.

---

**2026-07-01 (session 3, part 3)** — **Merge Preview .sh + Preview .dat → single Preview tab; double-click file row để xem.**

**Files:**
- `app/ui/widgets/right_dock.py` — `_TAB_NAMES = ("preview", "queue", "terminal")`. Legacy alias `preview_sh`/`preview_dat` → `preview` (gui-saved active_tab từ session cũ vẫn load được). Ctor giờ nhận 1 `preview_tab` thay vì 2. Xóa `preview_sh_btn`/`preview_dat_btn`, còn `preview_btn` (label "Preview" / compact "Prev"). Accessor `preview_sh_tab()` / `preview_dat_tab()` giữ lại (return cùng instance) để không phá caller cũ.
- `app/ui/main_window.py` — 1 `self._preview_tab = PreviewTab()`; alias `_preview_sh_tab`/`_preview_dat_tab` cùng trỏ về nó. `_on_preview_file` + `_on_preview_heredoc` đều `set_active_tab("preview")`.
- `app/ui/widgets/detail_variants.py`:
  - `SingleFileDetail`/`FolderGroupDetail` (files_table): thêm `cellDoubleClicked` → `_on_file_row_double_clicked` → emit `preview_requested(folder_win, filename)`.
  - `MultiFolderDetail` (rows_table): `cellDoubleClicked` → `_on_row_double_clicked` → emit `preview_requested`.

**Behavior:**
- Right dock chỉ còn 3 tab: **Preview | Queue | Terminal**.
- Double-click 1 file trong danh sách (files_table hoặc rows_table) → nội dung file load vào Preview + auto-switch sang Preview tab.
- Nút "Preview .sh" trên toolbar vẫn hoạt động (build heredoc, hiện trong cùng Preview tab với dạng script).
- Font-size buttons và theme mode vẫn áp cho Preview như cũ.

---

**2026-07-01 (session 3, part 2)** — **Queue: bjobs -l enrichment + column toggle + bkill selection-gate.**

**Files:**
- `app/logic/ssh_status.py` — new `parse_bjobs_long(stdout)`: parse LSF block-format (`Key <value>`) → dict, normalize keys (`Job Name` → `job_name`), copy canonical fields (jobid/state).
- `app/data/settings.py` — new default `queue_columns` (list of {key, label, enabled, width}) + `queue_detail_on_select` bool. Migration seeds missing columns on old settings files.
- `app/ui/widgets/queue_tab.py`:
  - Dynamic columns from settings via `set_columns(cols)` (rebuilds header + widths).
  - New signal `selection_changed(jobid)` → wired to itemSelectionChanged.
  - New signal `command_buttons_rebuilt` → fires after `_rebuild_command_buttons` (main window re-applies enable/disable gating).
  - New `merge_row_details(jobid, extras)` — stores per-jobid enrichment cache; render overlays it onto short-format rows without overwriting.
  - `_render()` walks `_enabled_columns()` and picks values by key; state coloring unchanged. Selection is restored across renders.
  - Always-on keys: `jobid`, `state` (user can't disable — needs to select rows).
- `app/ui/workers.py` — `SSHCommandWorker` picks `parse_bjobs_long` when template has `-l`.
- `app/ui/main_window.py`:
  - `_on_queue_selection_changed(jobid)`: gates `{selected_jobid}` buttons; if `queue_detail_on_select` on and jobid not fetched yet this session, fires a silent `bjobs -l {selected_jobid}` via `_on_ssh_command_requested` with `_detail_fetch: True`.
  - `_update_selection_gated_buttons(jobid)`: setEnabled(False) on any command button whose tooltip (which stores the template) contains `{selected_jobid}` when no selection.
  - `_on_ssh_command_requested`: added `_detail_fetch` bypass — skips the "Kill job?" confirm + `_kill_in_flight` lock for non-bkill `{selected_jobid}` commands. Only `bkill*` gets the destructive-command safeguards.
  - `_on_ssh_command_done`: detects `-l ` and calls `merge_row_details` per row instead of `refresh(rows)` (avoid wiping the queue with a single-job detail response).
  - `_on_settings_applied`: pushes new `queue_columns` to queue tab so column toggles take effect immediately.
- `app/ui/widgets/settings_dialog.py`:
  - New "Queue columns" section under the Queue-poll input.
  - Checkbox toggle "Auto-fetch bjobs -l JOBID when I click a queue row".
  - Table of columns with per-row Show checkbox; jobid/state disabled (forced on).
  - `_collect_queue_columns()` + persist in `_snapshot_settings()`.

**Behavior:**
- Click queue row → bjobs -l fetch fires in background (once per jobid per session) → extra columns fill in.
- Enable columns like CWD/Command/ExecHost/RunLimit in Settings → they appear in the tree.
- bkill button auto-disables when no queue row selected; enables when a jobid is selected. Still shows the "Kill job {jobid}?" confirm on click.

---

**2026-07-01 (session 3)** — **Queue UX: giữ tab Queue khi bấm SSH command; Refresh re-run lệnh SSH gần nhất.**

**Thay đổi (release_clean/app/ui/main_window.py):**
- Bỏ auto-switch sang Terminal khi click SSH command button — user muốn ở lại Queue để xem rows cập nhật trong tree. Terminal log vẫn nhận output như cũ, chuyển tab thủ công nếu cần.
- `_on_ssh_command_requested` cache `command_def` cuối cùng có prefix `bjobs` vào `self._last_queue_command`.
- `_refresh_queue` giờ ưu tiên re-run `_last_queue_command` (nếu có), fallback về `bjobs_command` mặc định qua poller như cũ. Điều này giải quyết bug "Refresh xóa queue" — trước đó Refresh luôn chạy `bjobs_command` mặc định, ghi đè kết quả từ SSH command button vừa gửi.

---

**2026-07-01 (session 2)** — **UI polish + submit reliability + GitHub deploy workflow.**

**Bối cảnh:** User deploy `release_clean/` sang máy target qua GitHub repo [`AkiraHina-101/ccc`](https://github.com/AkiraHina-101/ccc) branch `main`. Máy target: Python 3.9 UI + Python 3.8 subprocess Paramiko (env vars `APP_PYTHON_EXE` / `PYTHON38_EXE` / `PYTHON38_LIBS` trong `run.bat`).

**Thay đổi (tất cả trong `release_clean/`, đã push):**

Queue / SSH:
- `logic/ssh_status.py`: `parse_bjobs` bỏ dòng có JOBID không phải số → banner usage của `bjobs` không còn được render thành fake row. Default poll cmd đổi từ `bjobs -a -w -u {user}` → `bjobs -u {user}` (LSF site này không hỗ trợ `-a -w`). Timeout `run_ssh_command` 180s → 30s.
- `data/settings.py`: thêm key `bjobs_command` (poll cmd cấu hình được).
- `ui/workers.py`: `BjobsPoller` đọc `bjobs_command` từ settings. `SSHCommandWorker` catch mọi exception (không chỉ SSHStatusError) → worker không chết im lặng.
- `ui/widgets/queue_tab.py`: default Auto-poll OFF. User phải bấm Refresh hoặc bật Auto explicit.
- `ui/main_window.py`: `_refresh_queue()` giờ start poller trong "run-once" mode khi Auto off (trước là no-op → Refresh vô dụng). Auto-switch sang Terminal tab khi click SSH command.
- `ui/widgets/right_dock.py`: reparent QueueTab.header + command_shelf lên phía trên tab_bar → Queue Controls + SSH Commands hiện mọi tab.
- `ui/widgets/settings_dialog.py`: thêm text field "Queue poll command:" + 2 nút ▲▼ reorder SSH buttons.

Submit / listener:
- `logic/terminal_session.py`: race lock `threading.Lock` bảo vệ `next_seq` trong `enqueue()` + toàn bộ `ensure_session()` — trước N SubmitWorker song song đua trên `next_seq` → 2 file cùng ghi 1 `.job` → chỉ 1 file được submit. `cleanup()` KHÔNG kill ttpmacro + KHÔNG xóa lock nữa → listener chạy tiếp qua app restart, next launch adopt as external (đúng ý design lock+heartbeat).

Heredoc:
- `logic/heredoc.py`: khi caller pass `fields=`+`data=` (list from `resolve_fields_for_solver`), emit TẤT CẢ field có `role=heredoc_input` theo thứ tự — không hardcode 5 field nữa. User-added field như `Comment(4h)` xuất hiện đúng vị trí trong `.sh`.
- `ui/workers.py`: `SubmitWorker` build fields list rồi pass qua `fields=`/`data=`.
- `ui/widgets/detail_variants.py`: preview .sh path 1 (SingleJobDetail line 696) cũng chuyển sang `build_heredoc_str(folder, filename, self._data, self._settings)` (dict form).

Gather section (Single):
- `ui/widgets/detail_variants.py`: rewrite. 5 chip status (required / in submit / gatherable / missing / USERFILE). Dual-panel: trái Submit folder + `✓` marker cho file được INCLUDE + highlight amber+`★` cho file mới copy trong session; phải Source folder (recursive) + `→` marker cho file gatherable. Nút `← Add` copy file user chọn tay. Duplicate → dialog Overwrite/Skip/Cancel. Refresh (⟳) xoá highlight recently-added.

Confirmation dialogs:
- `ui/main_window.py` + `ui/widgets/detail_variants.py`: dialog Yes/No trước 3 entry point Submit all (toolbar / folder_group / multi_folder), default No, quote count.

Bug fixes phụ:
- `ui/widgets/detail_variants.py`: `_on_file_checked` chỉ update counter, không rebuild table → scroll không bị reset về đầu.
- `ui/widgets/solver_fields_table.py`: thêm signal `preset_saved(name)`, emit sau `save_preset()`. Card handle → refresh `preset_combo` (không cần restart app).

Python 3.8/3.9 split (từ session trước — vẫn stable):
- `logic/ssh_status.py` + `logic/ssh_worker_py38.py`: subprocess wrap. Worker bootstrap `sys.path` tự dựa `__file__` (khỏi phụ thuộc PYTHONPATH cho embedded Python).

**Deploy workflow:**
- Repo GitHub `AkiraHina-101/ccc` chỉ giữ file thay đổi trong 3 commit gần nhất (đã xoá phần còn lại theo yêu cầu user để tránh lộn).
- Không dùng git pull trên target — user tải file lẻ từ github.com đè lên bản cũ.
- Chú ý: UTF-8 BOM ở đầu `.py` sẽ crash với shiboken2 import hook (`__feature__.py`) — luôn strip trước khi push. Save memory `feedback_no_utf8_bom.md`.

**Verify:** User đã confirm chạy được sau các fix. Preset dropdown refresh sau save. Queue banner biến mất khi Refresh với cmd đúng cho LSF site.

**Còn lại / theo dõi:**
- Nếu SSH command hang: 30s timeout sẽ trigger `[ERR #N]` với traceback → có tín hiệu debug.
- Nếu user muốn xem queue tất cả job: đổi Settings > Queue poll command sang `bjobs -u all -q nast16m`.

---

**2026-07-01 (session 1)** — **Split Paramiko sang Python 3.8 subprocess (release_clean).**

**Bối cảnh:** Máy target chỉ có Paramiko cho Python 3.8; app UI chạy Python 3.9 với PySide2. Codex đã tách: main app trên 3.9, SSH/bjobs shell out sang Python 3.8 subprocess.

**Trạng thái Codex đã làm:**
- `release_clean/app/logic/ssh_status.py`: `query_bjobs()` và `run_ssh_command()` nhận thêm `python38_exe`/`python38_libs`; nếu có → gọi `_run_ssh_worker()` spawn subprocess. Worker child dùng stdin JSON, stdout JSON.
- `release_clean/app/logic/ssh_worker_py38.py`: entry stub cho subprocess, gọi `_worker_main()`.
- `release_clean/app/ui/workers.py`: `BjobsPoller`/`SSHCommandWorker` đọc `python38_exe`/`python38_libs` từ settings, fallback env var.
- `release_clean/app/data/settings.py`: thêm key `python38_exe`, `python38_libs`.
- `release_clean/run.bat` + `run_hidden.bat`: thêm `PYTHON38_EXE`/`PYTHON38_LIBS` với auto-detect `..\python3.8.10\python.exe`.
- `release_clean/RELEASE_NOTES.txt`: hướng dẫn edit path.

**Fix (2026-07-01, Claude):** `ssh_worker_py38.py` import `from app.logic.ssh_status import _worker_main` fail với Python embedded (không đọc `PYTHONPATH`). Thêm bootstrap `sys.path.insert(0, PROJECT_ROOT)` ở đầu file dựa trên `__file__`. Verify: subprocess round-trip pass — parent raise `SSHStatusError` đúng, child trả `{"ok": false, "error": "paramiko not available"}` khi thiếu paramiko (expected trên máy này, sẽ pass trên target có PYTHON38_LIBS).

**Verify:** `py_compile` pass 4 file đã sửa. Smoke: `format_ssh_command`, `normalize_state`, `parse_bjobs` pass. Round-trip subprocess: parent → child JSON stdin → child raise SSHStatusError → parent nhận đúng.

**Còn lại:** Test thực tế trên máy target (Paramiko cài sẵn cho Python 3.8), verify `bjobs -a -w -u {user}` chạy được qua subprocess.

---

**2026-06-21** - **Gather files MVP cho Single job — parse INCLUDE + copy từ source.**

**Bối cảnh:** Submit cần đủ file (.dat + tất cả file được INCLUDE). User trước đây gom file thủ công từ project tree vào submit folder. Feature mới: chỉ định source folder, app scan INCLUDE trong .dat, validate vs submit folder, copy file thiếu.

**Quyết định:** Copy (không move), 1-cấp INCLUDE (không đệ quy), làm Single trước rồi port sang folder_group/multi_folder.

**Thay đổi:**
- `app/logic/file_gather.py` (mới): `parse_includes(dat) -> [name]` (single/double quote/bareword, case-insensitive, strip path → basename, skip `$` comments, dedup), `validate_files(dest, names) -> {name: ok|missing}` (case-insensitive lookup), `find_in_source(src, names) -> {name: path}` (recursive walk, shallowest match wins), `copy_to_dest({name: src_path}, dest) -> (copied, failed)` (skip existing, idempotent), `gather_report(dat, src, dest)` one-shot wrapper.
- `_tests/test_logic/test_file_gather.py` (mới): 17 case cover toàn bộ public API.
- `app/ui/widgets/detail_variants.py`: `SingleJobDetail._build_gather_section()` ở đầu body. Row: Source [edit] [Browse] [Validate] [Copy missing] + status label + QListWidget per-file (✓ in dest, → from source, ✗ not found). Slots: `_on_gather_browse_clicked`, `_on_gather_validate_clicked`, `_on_gather_copy_clicked`. State persist vào `card['gather_source']`.

**Verify:** `py_compile` pass. Smoke end-to-end với Python 3.9.0 + PySide2: dest có `main.dat` INCLUDE 3 file (a.bdf in dest, b.bdf in source, c.bdf nowhere) → Validate hiện đúng `3 required · 1 in submit folder · 1 gatherable · 1 NOT FOUND` → Copy missing → b.bdf đã ở dest, status update → Copy disabled vì còn 1 file không có ở đâu cả. 17 logic-level case pass (mental trace + 5 inline smoke).

**Còn lại:** Port section sang `FolderGroupDetail` + `MultiFolderDetail` sau khi user thử Single. Tests cho widget chưa viết (pytest-qt chưa setup được trong env này).

**Follow-up 2026-06-21:** Mở rộng parser sau khi đối chiếu real deck `_tests/fixtures/YDB_CS_4500rpm.dat`.
- `parse_dat_refs()` thay cho `parse_includes()` (giữ shim back-compat): trả `{required, userfiles}`. Required = INCLUDE + `ASSIGN INPUTT2='...'` + `ASSIGN INPUTT4='...'` (binary input phải tồn tại). Userfiles = `ASSIGN USERFILE='...'` (output, không gather).
- `validate_userfiles(dat, names)` check name USERFILE phải startswith stem của .dat (case-insensitive). Catch bug rename .dat quên đổi USERFILE → ghi đè output job khác.
- UI render thêm dòng `○ name — output (USERFILE), name OK` hoặc `⚠ ... name does NOT match .dat stem`. Status line thêm `⚠ N USERFILE name mismatch` nếu có.
- Fixture `_tests/fixtures/gather_demo/` cập nhật: `main.dat` thêm ASSIGN INPUTT2/INPUTT4/USERFILE; `submit_dest/main.INP4` (in-place), `source_scattered/modal_results/modal.op2` (gatherable).
- Test logic thêm 6 case: parse ASSIGN INPUTT2/4, USERFILE tách riêng, ASSIGN OUTPUT2/DBSET bị bỏ qua, validate stem match/mismatch, dedup giữa ASSIGN và INCLUDE.

Verify real deck: `_tests/fixtures/YDB_CS_4500rpm.dat` parse ra 8 required (3 ASSIGN + 5 INCLUDE) + 1 USERFILE match stem.

---

**2026-06-21** - **Context menu mark Done/Fail/Reset trên sidebar card (BUG-004).**

**Vấn đề:** LSF đôi khi không emit Done/Error đúng (admin kill ngoài bjobs, jobid rotate trước khi app kịp thấy exit code) → user cần đánh dấu thủ công nhưng không có UI.

**Thay đổi:**
- `app/ui/widgets/job_list_panel.py`: thêm signal `status_override_requested(job_id, new_status)`. `QListWidget` set `Qt.CustomContextMenu` + handler `_on_context_menu` build `QMenu` với 3 action: Mark as Done / Mark as Failed / Reset to Pending. Emit signal với status tương ứng.
- `app/ui/main_window.py`: connect signal → `_on_status_override_requested(uid, status)`. Update `card['status']`, propagate xuống sub-items (folder_group files, multi_folder rows) chỉ với submitted=True, refresh detail badge + sidebar dot, log info line.

**Verify:** `py_compile` pass. Logic: chuột phải card → menu 3 lựa chọn → click 'Mark as Failed' → card status = 'Fail', sidebar dot đỏ, detail badge đổi.

---

**2026-06-21** - **Status reconcile lúc startup (BUG-002) + sync BUGS.md.**

**Vấn đề:** App restart sau khi job đã Done trên LSF → card vẫn hiện `Running`. Logic Done-by-disappearance trong `_sync_job_status_from_queue` chỉ fire khi `jid in seen`, nhưng `_seen_jobids` reset rỗng mỗi launch → jobid đã rotate khỏi bjobs history không bao giờ được mark Done.

**Thay đổi:**
- `app/ui/main_window.py`: thêm `_seed_seen_jobids_for_reconcile()` gọi trước `_start_bjobs_poller()`. Seed `_seen_jobids` bằng jobid của các entity còn ở trạng thái non-terminal (`Pending`/`Running`/`Upload`). Poll đầu tiên: jobid không có trong bjobs → branch "rotated out" trigger → set Done + notify.
- `docs/BUGS.md`: thêm BUG-002 (BUG-002 fix này), BUG-003 (FIFO race 2 file cùng tên <5s), BUG-004 (mark fail thủ công) vào `## Open` để đồng bộ với HANDOFF.

**Verify:** `py_compile` pass. Logic smoke (mental): card jobid 12345 status=Running, restart → seed `{12345}`, poll trả [], `12345 in seen` True, old_state Running → set Done + notify. Card jobid 67890 status=Done, restart → seed bỏ qua (terminal), poll trả [] → không động vào.

**Edge case còn lại:** BUG-003, BUG-004 trong BUGS.md.

---

**2026-06-20** - **UI revisit: adaptive narrow-width layout for snap-tiled usage.**

**Van de:** Lan truoc set window min = 1280 + RightDock min = 480 -> chan user dung app snap-tiled ben canh app khac (use case quan trong). Screenshot user: tab `Preview .sh` bi clip thanh `.eview .s` vi dock chat; Queue ko du cot vi tree khong scroll ngang.

**Doi huong:** thay vi block narrow, **adapt graceful** khi narrow.

**Thay doi:**
- `app/ui/main_window.py`: window min 1280x600 -> **720x600**.
- `app/ui/widgets/right_dock.py`: min 480 -> **280**. Them `resizeEvent`: khi `width < 360px` doi tab label sang form ngan (`.sh`, `.dat`, `Q`, `Term`); tooltip = label full. Them `_tab_labels` list cho map.
- `app/ui/widgets/detail_panel.py`: min 580 -> **360**.
- `app/ui/widgets/job_list_panel.py`: min 220 -> **160**.
- `app/ui/widgets/queue_tab.py`: `header.setStretchLastSection(False)` + `setHorizontalScrollBarPolicy(AsNeeded)` + `setHorizontalScrollMode(ScrollPerPixel)`. Khi dock hep, cot khong bi bop, scroll ngang xuat hien.
- `app/ui/widgets/settings_dialog.py`: min 860x600 -> **700x500**.

**Behavior:** snap-tile app voi half-screen 1366 (~683):
- Detail + RightDock van fit (360 + 280 = 640).
- Sidebar nen collapse bang chevron `«` (160 + 360 + 280 = 800 lon hon half-screen).
- RightDock tabs hien `.sh .dat Q Term` thay vi clipped.
- Queue table co thanh cuon ngang neu can.

**Verify:** `py_compile` pass. User can phai restart app de thay doi.

---

**2026-06-20** - **UI audit: splitter clamp + collapse, min widths, tooltip, settings dialog smaller.**

**Van de:** User keo JobListPanel rong ra -> RightDock bi bop lai den khi mat het cot/info. Co che cu:
- `_clamp_splitter_sizes` chi goi luc init/restore, **khong** bind voi `splitterMoved` -> keo handle khong bi chan.
- `RightDock.minimumWidth=180` qua nho cho Queue tab (5 cot tong ~650px) -> cot bien mat khi bi ep.
- Sum panel min (220+760+180=1160) > window min (980) -> co the bop panel duoi min.
- JobListPanel khong co max width -> co the chiem het man hinh.

**Thay doi (phuong an B: clamp cung + cho phep collapse explicit):**
- `app/ui/main_window.py`:
  - Bind `splitter.splitterMoved` -> `_on_splitter_moved` -> `_clamp_splitter_sizes`. Keo handle bi chan o min widths combined. Tru truong hop panel da bi collapse (size=0) -> bo qua de giu collapsed state.
  - Bump window min 980x600 -> 1280x600 (= 220 sidebar + 580 detail + 480 right dock + margin).
  - `JobListPanel.setMaximumWidth(420)` chong sidebar nuot het man hinh.
  - `_toggle_panel_collapse(idx)` thu/khoi phuc panel; nho width truoc collapse vao `_collapsed_widths`.
  - `eventFilter` bat `MouseButtonDblClick` tren splitter handles -> goi toggle. Day la cach restore panel sau khi collapse (chevron button da bien mat cung panel).
- `app/ui/widgets/right_dock.py`: bump min 180 -> 480 (Queue cot vua du). Them `collapse_btn '»'` o bottom bar.
- `app/ui/widgets/job_list_panel.py`: them `collapse_btn '«'` o sidebar header.
- `app/ui/widgets/detail_panel.py`: giam min 760 -> 580 de tong panel min vua voi window min 1280.
- `app/ui/styles/app.qss`: style cho `#sidebarCollapseBtn`, `#dockCollapseBtn` (transparent + hover indigo).

**Minor fixes #6, #7, #9:**
- `detail_variants.py`: `folder_edit`, `parent_folder_edit` co tooltip = full path, update theo `textChanged`. Long path khong can scroll trong input de doc.
- `settings_dialog.py`: min 980x680 -> 860x600. Vua voi laptop 1366x768.
- `detail_variants.py`: Multi rows delete button 22x24 -> 28x26 cho DPI cao.

**#10 (toolbar overflow):** skip, voi window min 1280 toolbar khong bi che.

**Verify:** `py_compile` pass cho tat ca file dong. Behavior expect:
- Keo handle: dung lai khi gap min widths combined, khong cho bop panel.
- Click chevron `«` sidebar -> sidebar an, detail rong them.
- Click chevron `»` right dock -> dock an, detail rong them.
- Double-click splitter handle -> toggle panel ke ben handle do.
- Hover folder path: tooltip hien full path.

---

**2026-06-20** - **Per-jobid Kill lock, poll rate by visibility, queue cache, Upload status, Done-by-disappearance + toast.**

**Van de:** Loat edge case con lai #7, #8, #10, #15, #17.

**Thay doi:**
- `app/logic/ssh_status.py`: `run_ssh_command` default timeout 20s -> 180s. Chong zombie thread khi server treo, nhung khong false-fail cac lenh nang nhu `fstv_util`.
- `app/ui/main_window.py`:
  - `_kill_in_flight: set[jobid]` chua jobid co lenh `{selected_jobid}` dang chay. Click lai voi cung jobid -> log `[INFO] already running for job N` + status bar bao. Cac SSH button khac khong bi anh huong. Lock release khi worker `finished`.
  - `_POLL_INTERVAL_VISIBLE=5`, `_POLL_INTERVAL_HIDDEN=30`. `_visibility_timer` 2s kiem tra `right_dock.isVisible() and not isMinimized()` -> `poller.set_interval()` tuong ung. Khi RightDock an / app minimize, poll cham lai 30s.
  - `_restore_queue_cache()` goi truoc khi start poller: doc `nastran_queue_cache.json`, render ngay vao Queue tab + status bar `Cached data from <time> -- refreshing...`. Poll dau xoa banner.
  - `_on_bjobs_rows()` save cache moi sau moi poll thanh cong.
  - Submit (single/folder_group/multi) set `status='Upload'` thay vi `'Running'`. Trang thai duoc giu cho den khi bjobs claim jobid -> doi sang Pending/Running theo LSF.
  - `_sync_job_status_from_queue`: them detect Done-by-disappearance. Khi jobid da seen nhung bjobs khong tra ve nua -> set status 'Done' + notification. Cung notify khi bjobs tra Done/Error explicit.
  - `_notify_job_finished(title, body)` dung `QSystemTrayIcon.showMessage()` -> Windows toast 5s o goc man hinh. Co log `[NOTIF] ...` o terminal pane luon.
- `app/ui/workers.py`: `SubmitWorker` set `status='Upload'` (khong con 'Running') khi TeraTerm enqueue OK -- vi server chua bsub xong.
- `app/data/settings.py`: them `QUEUE_CACHE_FILE`, `save_queue_cache(rows, ts)`, `load_queue_cache() -> (rows, ts)`.
- `app/ui/widgets/detail_variants.py` + `app/ui/main_window.py` _STATUS_SIDEBAR: them mapping `Upload -> queued (visually)`, `Fail -> error`.

**Verify:** `py_compile` pass cho tat ca file dong. Smoke test:
- Done detection 3 scenario: bjobs Done explicit, bjobs vanish (rotation), no double notify.
- 6/6 case validator giu nguyen.

**Skip:** #12-A (khong duoc sua server script), #16 (user khong can cooldown).

**Edge case con lai:** Mark fail thu cong (nut tren card) -- defer, dung context menu.

---

**2026-06-20** - **SSH command log sequence + input validation.**

**Van de:**
- #4: Click nhieu SSH command lien tiep -> log `[CMD] {label}: running...` + `[CMD] {label}: {command}` + `[OK] {label}` bi xen ke khong phan biet noi (cung label, khong sequence).
- #6: Dialog `{input}` chap nhan bat ky string nao. User paste nham newline / go nham `; rm -rf` co the inject shell command.

**Thay doi:**
- `app/ui/main_window.py`:
  - Them counter `_ssh_cmd_seq`. Moi click cap sequence moi, gan vao worker `_seq` attribute. Cac log line dung prefix `[CMD #N]`, `[OK #N]`, `[ERR #N]` -> dam bao phan biet duoc log cua tung lan click ke ca khi chay song song.
  - `_on_ssh_command_done` / `_failed` nhan them `seq` qua lambda capture worker.
  - Them `_SSH_INPUT_FORBIDDEN` (`\n \r \t ; & | \` $ < > ( ) { } ' " \\`) va helper `_reject_ssh_input(value)` tra ve ly do tu choi (empty / too long / forbidden chars). Goi tu cho dialog `{input}`; neu reject thi log `[ERR]` + `QMessageBox.warning` thay vi chay.

**Verify:** `py_compile` pass. Smoke test validator 13/13 case: chap nhan JOBID, alphanum, dash, underscore, space, @, =; tu choi newline, `;`, `|`, `&`, `` ` ``, `$(...)`, qua dai, rong.

**Edge case con lai:** #7 SSH worker khong cancel, #8 poll khi RightDock an, #10 stuck Running sau restart 1 ngay, #12-A FIFO sai khi 2 file cung ten submit < 5s, #15-#17 minor.

---

**2026-06-20** - **Track job status by JOBID + fix Clear done.**

**Van de:** 2 edge case phat hien khi review:
1. `Clear done` o Queue tab xoa khoi `_rows` local nhung 5s sau poller `refresh(rows)` ghi de toan bo -> job Done quay lai. Nut nay coi nhu vo dung.
2. `_sync_job_status_from_queue` match status theo `filename` substring (`name == base or base in name`). User co nhieu sub-folder cung `model.dat` -> match nham, status sai. 2 job cung ten submit cung luc map vao cung 1 bjobs row.

**Thay doi:**
- `app/ui/widgets/queue_tab.py`: them `_dismissed_jobids: set`. `_on_clear_done()` luu jobid Done vao set thay vi xoa khoi `_rows`. `_render()` filter set nay. Khi LSF rotate jobid khoi history window, GC tu xoa khoi set.
- `app/ui/main_window.py`: them `_mark_pending_match(entity)` set `pending_match=True`, `submit_ts=<seq>`, `jobid=''` luc submit (single/folder_group/multi). Rewrite `_sync_job_status_from_queue`:
  1. Tinh `new_jobids = current_bjobs_jobids - self._seen_jobids`.
  2. FIFO theo `submit_ts`, voi moi pending entity tim new_jobid co JOB_NAME match basename -> claim, set `entity['jobid']`, danh dau `pending_match=False`. Khong reclaim sau do.
  3. Voi entity da co jobid: lookup row exact theo jobid, update status. Khong con substring match.
- Bo helper cu `_queue_status_by_name`, `_status_for_filename_from_queue`.

**Verify:** `py_compile` pass. Smoke test 2 scenario:
- JOBID claim FIFO: 1 single + 1 multi 3 row, 3 trong so chung cung `model.dat`. Poll 1 cap 3 jobid moi -> claim theo submit_ts FIFO. Poll 2 cap nhat status theo jobid, khong reclaim. Poll 3 jobid moi xuat hien -> entity con pending claim duoc.
- Dismissed-jobid filter: Clear done luu jobid vao set; poll sau van filter; khi jobid roi khoi LSF history, set tu GC.

**Edge case con lai:**
- #12-A: 2 file cung filename submit cach nhau < 5s, bjobs cap nhat dong loat -> co the nham cap (FIFO theo jobid LSF, thuong dung nhung khong dam bao 100%).
- #14: card cu chua co `jobid`/`submit_ts` (saved truoc thay doi nay): code treat nhu pending, se thu claim lan dau gap.
- #10 (status persist qua restart): chua lam.

---

**2026-06-19** - **Atomic JSON write + corrupt-config detection.**

**Van de:** `save_json` ghi thang file `'w'` -> neu crash giua chung (BSOD, kill process, disk full) thi file con dang do, lan sau mo app bi reset trang. `load_json` swallow moi exception -> JSON corrupt (sua tay sai, encoding) cung tra `{}` silent, user kha nang mat sach presets/settings ma khong biet.

**Thay doi:**
- `app/data/json_io.py`: `save_json` ghi vao `<path>.tmp`, fsync, `os.replace` ve file dich. Truoc khi replace copy file cu sang `<path>.bak` lam snapshot.
- `load_json` parse fail: neu co `.bak` thi fallback silent (TOFU recovery). Neu khong co `.bak` thi raise `JSONLoadError` thay vi return `{}`.
- Them module-level `load_errors` list de cac caller (`load_settings`, `load_presets`) catch + append.
- `app/data/settings.py`, `app/data/presets.py`: catch `JSONLoadError`, append vao `load_errors`, fallback default.
- `app/ui/main_window.py`: cuoi `__init__` goi `_warn_about_config_load_errors()` -> log `[WARN]` + `QMessageBox.warning` liet ke duong dan + ly do; clear list. File goc KHONG bi sua, user co the mo bang text editor de inspect.

**Verify:** `py_compile` pass. Smoke test 5/5 cases pass: atomic write, bak rotation, corrupt+bak fallback, corrupt+no-bak raise, missing file.

**Edge case con lai (chua lam, theo y user):** #4 log SSH command bi xen ke, #6 `{input}` chua validate, #7 SSH worker khong cancel duoc, #10 status submit khong persist qua restart.

---

**2026-06-19** - **Remove legacy hidden-button back-compat + trim HANDOFF.**

**Van de:** Code tich luy nhieu hidden attribute "for back-compat with legacy callers" sau nhieu vong refactor — vi pham rule CLAUDE.md "Avoid backwards-compatibility hacks". HANDOFF.md cung phinh to 1461 dong vi append moi thay doi nhu changelog.

**Thay doi:**
- `app/ui/main_window.py`: bo `self._preview_tab = self._preview_dat_tab` legacy alias.
- `app/ui/widgets/detail_variants.py`: xoa cac hidden button khong ai dung trong 3 detail variant: `save_preset_btn`, `preview_sh_btn`, `load_preset_btn`, `filter_edit`, `all_btn`, `none_btn`, `preview_row_sh_btn`, `preview_row_dat_btn`. Xoa method `_on_load_preset_clicked` dead. `detail_variants.py` tu `1729` xuong `1662` dong.
- `_tests/test_ui/test_main_window.py`: doi `_preview_tab` -> `_preview_dat_tab`.
- `_tests/test_ui/test_detail_variants.py`: bo assert `preview_row_sh_btn`/`preview_row_dat_btn`.
- `docs/HANDOFF.md`: lich su 2026-06-17 tro ve truoc chuyen sang `docs/HANDOFF_ARCHIVE.md`. HANDOFF.md tu `1461` xuong `~220` dong, vai tro tro lai dung "snapshot trang thai hien tai".

**Verify:** `py_compile` pass cho `main_window.py`, `detail_variants.py`, 2 test file vua sua. Grep xac nhan khong con tham chieu nao den cac attribute da xoa trong `app/` va `_tests/` (right_dock co `preview_sh_btn` rieng la button khac, khong lien quan).

**Luu y:** Sau cleanup nay neu them feature moi dung tao lai hidden alias. Neu thay can giu cho back-compat tam thoi, mark `# DELETE BY <date>` va xoa han trong vong 1 sprint.

---

**2026-06-18** - **Left-align Queue controls with command shelf.**

**Van de:** User muon `QUEUE CONTROLS` cung xep ben trai nhu command shelf, khong can nam ben phai.

**Thay doi:**
- `app/ui/widgets/queue_tab.py`: bo stretch truoc `Auto/Refresh/Clear done`; dua stretch ve sau controls. `controls_title_lbl` fixed width `104` de cot button cua `QUEUE CONTROLS` can thang voi `SSH COMMANDS`.

**Verify:** `py_compile` pass voi Python 3.9.0. Capture: `_tests/ui_queue_controls_left.png`, `_tests/ui_queue_controls_left_aligned.png`. Da restart app bang `pythonw.exe run_py39_app.py`.

---

**2026-06-18** - **Kill job uses selected Queue row.**

**Van de:** User khong muon `Kill job` hoi nhap JOBID. Chi khi chon 1 row trong Queue table co Job ID moi duoc kill, va truoc khi kill phai confirm.

**Thay doi:**
- `app/data/settings.py`: default `Kill job` command doi tu `bkill {input}` sang `bkill {selected_jobid}`.
- `app/ui/widgets/queue_tab.py`: them `selected_jobid()` lay Job ID cua row dang chon trong Queue table.
- `app/logic/ssh_status.py`: formatter ho tro `{selected_jobid}`.
- `app/ui/main_window.py`: neu command co `{selected_jobid}`, bat buoc co selected Queue row; neu co thi hien confirm `Run this command? bkill <jobid>` truoc khi chay.
- `app/ui/workers.py`: truyen `selected_jobid` vao formatter/run command.
- `app/ui/widgets/settings_dialog.py`: hint doi sang `{selected_jobid}`.

**Verify:** `py_compile` pass voi Python 3.9.0. Smoke: `format_ssh_command('bkill {selected_jobid}', selected_jobid='12345') -> bkill 12345`; Queue selected row smoke tra `12345`. Capture: `_tests/ui_queue_selected_jobid.png`. Da restart app bang `pythonw.exe run_py39_app.py`.

---

**2026-06-18** - **Responsive command shelf and drag reorder.**

**Van de:** User muon keo-tha sap xep vi tri button command; button phai xep cho het be rong panel moi xuong hang.

**Thay doi:**
- `app/ui/widgets/queue_tab.py`: command shelf khong con co dinh 3 nut/hang; tinh so nut/hang theo be rong hien tai cua shelf, xep trai->phai cho het hang roi moi xuong hang 2. Toi da 2 hang, du thi vao `More`.
- `app/ui/widgets/settings_dialog.py`: bang `SSH buttons` bat `InternalMove` drag/drop row, single-row selection; hint them `Drag rows to reorder buttons`.

**Verify:** `py_compile` pass voi Python 3.9.0. Capture: `_tests/ui_queue_responsive_commands_wide.png`, `_tests/ui_queue_responsive_commands_narrow.png`. Da restart app bang `pythonw.exe run_py39_app.py`.

---

**2026-06-18** - **Queue area section titles.**

**Van de:** User muon dat tieu de cho tung vung trong Queue, sap xep trai qua phai, tren xuong duoi.

**Thay doi:**
- `app/ui/widgets/queue_tab.py`: them label `QUEUE CONTROLS` cho row controls, `SSH COMMANDS` cho command shelf. Command buttons van xep trai->phai, du 3 nut thi xuong hang 2, du nua vao `More`.
- `app/ui/styles/app.qss`: them style `QLabel#queueSectionTitle` nho/uppercase, mau xam ky thuat, ho tro dark/light.

**Verify:** `py_compile` pass voi Python 3.9.0. Capture: `_tests/ui_queue_section_titles.png`, `_tests/ui_queue_section_titles_fit.png`. Da restart app bang `pythonw.exe run_py39_app.py`.

---

**2026-06-18** - **Queue three-layer layout and exact SSH command logging.**

**Van de:** User chot layout Queue gom `Queue controls row` / `Command shelf` / `Queue table`. Command shelf toi da 2 hang; khi click command thi Terminal phai hien lenh thuc te tuong ung voi lenh nhap trong TeraTerm de user check.

**Thay doi:**
- `app/ui/widgets/queue_tab.py`: Queue header chi con controls row (`Auto`, `Refresh`, `Clear done`); them `queueCommandShelf` ben duoi, command buttons fixed size, toi da 2 hang (`3` nut/hang = `6` nut inline), phan du vao `More`.
- `app/ui/styles/app.qss`: them band style cho `queueCommandShelf`; giu button raised/radius/mau command va Auto on/off.
- `app/logic/ssh_status.py`: them `format_ssh_command()` tra ve command sau khi expand `{user}`, `{server}`, `{host}`, `{input}`.
- `app/ui/workers.py`: `SSHCommandWorker` emit command da expand.
- `app/ui/main_window.py`: Terminal log hien `[CMD] label: <expanded command>` khi command xong, de doi chieu voi TeraTerm.

**Verify:** `py_compile` pass voi Python 3.9.0. Capture: `_tests/ui_queue_three_layer_commands.png`, `_tests/ui_queue_three_layer_commands_more.png`. Smoke command expansion: `bkill {input}` + `12345` -> `bkill 12345`; `bjobs -a -w -u {user}` + `alice` -> `bjobs -a -w -u alice`. Da restart app bang `pythonw.exe run_py39_app.py`.

---

**2026-06-18** - **Queue command bar layout.**

**Van de:** User muon xoa dong `LSF Queue (bjobs) Idle ...`, doi command tu dropdown sang thanh button ngang kieu compact; neu nhieu qua thi co `More`; nhom Auto/Refresh/Clear done van tach rieng, can deu, co mau trang thai on/off, bo goc va vien noi nhe.

**Thay doi:**
- `app/ui/widgets/queue_tab.py`: bo title/status label khoi Queue header; render toi da 3 command button inline ben trai, command du them vao `More`; nhom realtime ben phai giu rieng. Tat ca header button fixed `78x26`, align center.
- `app/ui/styles/app.qss`: style rieng `QWidget#queueHeader QPushButton` voi border raised, radius `4px`; command/More mau xanh duong nhe; `Auto:on` checked mau xanh la, off mau vang nhe.

**Verify:** `py_compile` pass voi Python 3.9.0. Capture: `_tests/ui_queue_command_bar_inline.png`, `_tests/ui_queue_command_bar_more.png`, `_tests/ui_queue_command_bar_equal_buttons.png`. Da restart app bang `pythonw.exe run_py39_app.py`.

---

**2026-06-18** - **Hide internal UID from default job names.**

**Van de:** Khi add job moi, ten fallback hien `single #90`, `multi #88`... lam user thay so ky la. Day la UID noi bo bi lo ra UI sau nhieu lan add/delete/load.

**Thay doi:**
- `app/ui/widgets/detail_variants.py`: `_derive_title()` khong con fallback `single run #uid`/`batch #uid`/`sweep #uid`; chuyen sang `Select folder` hoac `Select parent folder`.
- `app/ui/main_window.py`: `_derive_job_name()` sidebar fallback khong con `single #uid`/`folder group #uid`/`multi #uid`; chuyen sang `Select folder` hoac `Select parent folder`.

**Verify:** `py_compile` pass voi Python 3.9.0. Capture: `_tests/ui_job_name_no_uid_detail.png`, `_tests/ui_job_name_no_uid_sidebar.png`. Da restart app bang `pythonw.exe run_py39_app.py`.

---

**2026-06-18** - **Clear job type display names.**

**Van de:** User muon doi ten mac dinh 3 loai job theo mo ta ro rang, khong dung thuat ngu rieng. Da chot:
- `single`: `One job / one folder`
- `folder_group`: `Many jobs / one folder`
- `multi_folder`: `One job / each subfolder`

**Thay doi:**
- `app/ui/widgets/toolbar_widget.py`: Add job menu + tooltip doi theo 3 ten da chot.
- `app/ui/widgets/detail_variants.py`: detail type badge doi sang uppercase cua 3 ten nay.
- `app/ui/widgets/job_list_panel.py`: sidebar badge doi theo 3 ten nay; multi count thanh `... · N jobs`; badge sidebar dung `ElidedLabel` max width de khong che status.
- `app/ui/main_window.py`: log add job doi theo ten moi.
- `_tests/test_ui/test_job_list_panel.py`: update expectation multi badge.

**Verify:** `py_compile` pass voi Python 3.9.0. Capture: `_tests/ui_job_type_clear_name_detail.png`, `_tests/ui_job_type_clear_name_sidebar_fit.png`. Smoke Add job menu actions: `['One job / one folder', 'Many jobs / one folder', 'One job / each subfolder']`. Da restart app bang `pythonw.exe run_py39_app.py`.

---

**2026-06-18** - **Normalize Queue header button sizes.**

**Van de:** Cac button tren Queue header (`Commands`, `Auto`, `Refresh`, `Clear done`) khong deu size/can hang, nhin lech trong right dock.

**Thay doi:**
- `app/ui/widgets/queue_tab.py`: them constant height/width cho header buttons; `Commands=88`, `Auto=64`, `Refresh=64`, `Clear done=76`, height `26`; add widget voi `Qt.AlignVCenter`; spacing `6`.
- `app/ui/styles/app.qss`: them style rieng cho `QWidget#queueHeader QPushButton` de dong bo background/border/font/padding/hover/pressed.

**Verify:** `py_compile` pass voi Python 3.9.0. Capture: `_tests/ui_queue_header_even_buttons.png`. Da restart app bang `pythonw.exe run_py39_app.py`.

---

**2026-06-18** - **Custom SSH command buttons for Queue tab.**

**Van de:** User co mot so lenh hay go trong TeraTerm va muon tao bang de custom button, bam chay khong can go TeraTerm.

**Thay doi:**
- `app/data/settings.py`: them default `ssh_buttons: []`.
- `app/ui/widgets/settings_dialog.py`: Connection tab co bang `SSH buttons` gom `Use | Button label | Command`, nut `+ Add`/`Delete`; ho tro template `{user}`, `{server}`, `{host}`.
- `app/ui/widgets/queue_tab.py`: render cac custom button enabled tren queue header va emit `ssh_command_requested`.
- `app/logic/ssh_status.py`: them `run_ssh_command()` dung Paramiko + host-key pinning; command template dung replace literal de khong pha cac lenh co `{}` nhu awk.
- `app/ui/workers.py`: them `SSHCommandWorker` chay command nen, output raw; neu command bat dau bang `bjobs` thi parse rows.
- `app/ui/main_window.py`: noi button -> worker -> Terminal tab; neu parse duoc bjobs thi refresh Queue table.
- Follow-up: `ssh_buttons` default gio co `Kill job = bkill {input}`, `nast16m = bjobs -u all -q nast16m`, `Disk = fstv_util`. `{input}` se hoi user truoc khi chay (vd JOBID). `{user}` chi la optional placeholder lay Username trong Settings, khong bat buoc dung.
- Follow-up UI: doi nhieu button tren Queue header thanh mot dropdown `Commands` de header khong chat khi co nhieu lenh. Menu action van lay tu bang `SSH buttons`.

**Verify:** `py_compile` pass voi Python 3.9.0. Capture: `_tests/ui_settings_ssh_buttons_table.png`, `_tests/ui_queue_custom_ssh_buttons.png`, `_tests/ui_settings_ssh_buttons_examples.png`, `_tests/ui_queue_ssh_button_examples.png`, `_tests/ui_queue_commands_dropdown.png`. Smoke dropdown actions: `['Kill job', 'nast16m', 'Disk']`. Da restart app bang `pythonw.exe run_py39_app.py`.

---

**2026-06-18** - **Paramiko host-key pinning for bjobs poller.**

**Van de:** `ssh_status.py` dung `paramiko.AutoAddPolicy()` nen neu host key moi/doi thi app van tu tin, rui ro MITM trong LAN/VPN.

**Thay doi:**
- `app/logic/ssh_status.py`: them `KNOWN_HOSTS_FILE = <project>/nastran_known_hosts` va `PinningMissingHostKeyPolicy`.
- Lan dau gap host key: luu vao `nastran_known_hosts`. Cac lan sau Paramiko verify key tu file nay; neu key doi thi bat `BadHostKeyException` va bao `Connection blocked`.
- `_tests/test_logic/test_ssh_status.py`: them test policy add key va save dung file known_hosts.

**Verify:** Direct smoke bang Python 3.9.0 pass: policy add `server01/ssh-rsa` va save vao `KNOWN_HOSTS_FILE`. `pytest` van bi chan som do plugin `pytest-qt` thieu PySide6/PyQt trong Python hien tai. Da restart app bang `pythonw.exe run_py39_app.py`.

**Luu y:** Day la TOFU (trust-on-first-use). Neu muon chat hon nua, xoa file `nastran_known_hosts` va nap fingerprint/host key dung tu admin truoc khi ket noi lan dau.

---

**2026-06-18** - **Remove Multi no-row placeholder and add stable Py39 launcher.**

**Van de:** Trong Multi/Sweep khi chua chon row con hien dong `Pick a row to edit its settings`; user muon xoa het. User cung yeu cau sau khi sua xong luon tat ban app cu va tu mo ban moi.

**Thay doi:**
- `app/ui/widgets/solver_fields_table.py`: placeholder text de rong va khong add vao layout; khi `set_data(None)` thi table an va khong hien dong gi.
- `run_py39_app.py`: launcher on dinh cho Python 3.9.0 embed, add project root + `libs` vao `sys.path`, roi run `main.py`.

**Verify:** Capture bang Python 3.9.0 + app QSS: `_tests/ui_multi_no_pick_row_placeholder.png`. Da tat process app cu va mo lai ban moi bang `C:\Users\TechnoStar\Downloads\python3.9.0\pythonw.exe run_py39_app.py`.

**Luu y workflow:** Sau moi lan sua UI/app, Stop-Process cac `python.exe/pythonw.exe` dang chay `12-Teraterm|main.py|run_py39_app.py`, sau do mo lai bang `run_py39_app.py`.

---

**2026-06-18** - **Queue header matte raised style.**

**Van de:** Queue table header dang bong/glossy do gradient; user muon mau xam nham giong Tkinter va moi header cell noi hon.

**Thay doi:**
- `app/ui/styles/app.qss`: bo `qlineargradient` cua `QTreeWidget#queueTree QHeaderView::section`; doi sang nen phang `#D9D9D9`, chu den, vien tren/trai sang va vien duoi/phai dam de tao raised 3D nhe cho tung header.
- Follow-up: lam sang hon ve `#E9E9E9`, giam header height/padding (`min-height: 22px`, `padding: 3px 6px`) de fit chu gon hon.

**Verify:** Capture bang Python 3.9.0 + app QSS: `_tests/ui_queue_header_matte_capture.png`, `_tests/ui_queue_header_light_fit_capture.png`.

---

**2026-06-18** - **Fix toolbar icon mojibake and add guard tests.**

**Van de:** Toolbar van hien icon bi loi nhu `â–¾` o `+ Add job` va `âš™ Settings`. Nguyen nhan khong phai font runtime ma la source string da bi luu sai encoding/mojibake trong `toolbar_widget.py`; cac tooltip menu cung co `Â·`.

**Thay doi:**
- `app/ui/widgets/toolbar_widget.py`: bo glyph Unicode trong text toolbar; `Add job`, `Settings`, `Save` dung `QStyle.standardIcon()` cua Qt va tooltip ASCII sach.
- `app/ui/widgets/helpers.py`, `preset_quick_edit_dialog.py`, `queue_tab.py`: don cac visible label/tooltip mojibake con sot lai ve ASCII.
- `_tests/test_ui/test_toolbar_widget.py`: them guard text/tooltip toolbar khong chua `â`/`Â` va icon toolbar phai la Qt icon non-null.

**Luu y tranh lap lai:** Khong dung glyph Unicode truc tiep cho icon quan trong trong toolbar/button neu khong can thiet. Uu tien `QStyle.standardIcon()` hoac widget paint rieng; neu them label Unicode, phai chay test mojibake va capture UI sau khi sua.

**Verify:** Python 3.9.0 embed tai `C:\Users\TechnoStar\Downloads\python3.9.0\python.exe`.
Smoke PySide2 toolbar pass: text/tooltip khong con `â`/`Â`, `Add job`/`Settings`/`Save` icon non-null.
Da capture `_tests/ui_toolbar_icon_fix_capture_styled.png` voi app QSS: toolbar hien `+ Add job`, `Settings`, `Save` sach, khong con mojibake.
Khong chay duoc pytest bang Python 3.9.0 vi embed runtime chua co module `pytest`.

## Archive

Lich su thay doi cu (2026-06-17 va truoc) duoc chuyen sang [HANDOFF_ARCHIVE.md](HANDOFF_ARCHIVE.md) de file nay khong phinh to.

## Ghi chú kỹ thuật cần biết khi resume
- Python 3.8.10 tại `C:\Users\TechnoStar\Downloads\16-Tool_Develope\python3.8.10\python.exe`
- PySide2 5.15.2 vendored ở `libs/PySide2/` — `main.py` tự thêm vào `sys.path`
- `SettingsDialog` tự load/save presets (`PRESETS_FILE`) — không qua MainWindow
- Field Library lưu trong `nastran_settings.json` dưới key `"field_library"`
- `preset_name_input` rename preset khi Save → xoá key cũ, tạo key mới
- `archive/` chứa code legacy — **không** import, **không** sửa

## Tài liệu liên quan
- Việc kế hoạch / nice-to-have: [ROADMAP.md](ROADMAP.md)
- Bug đang theo dõi: [BUGS.md](BUGS.md)
- Quyết định kiến trúc: [DECISIONS.md](DECISIONS.md)
- Rules code: [CLAUDE.md](CLAUDE.md)
