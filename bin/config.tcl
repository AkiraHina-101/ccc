# ═══════════════════════════════════════════════════════════════════════════
# config.tcl — Chỉnh sửa các đường dẫn ở đây khi copy sang máy mới.
# Sau khi sửa, mở HM và nạp lại button — KHÔNG cần cài Python package.
# ═══════════════════════════════════════════════════════════════════════════

namespace eval ::nc::config {}

# ─── 1. Thư mục gốc chứa tool (folder này) ─────────────────────────────────
# Tự dò từ vị trí file config.tcl — chỉ đổi nếu bạn di chuyển các file rời.
set ::nc::config::tool_dir [file normalize [file dirname [info script]]]

# ─── 2. Python 3.5 của HyperMesh (dùng để tạo thumbnail + xuất/nhập xlsx) ──
# Danh sách candidate — dò thứ tự, cái nào tồn tại thì lấy.
set ::nc::config::python_candidates {
    {C:/Program Files/Altair/2022/common/python/python3.5/win64/python.exe}
    {C:/Program Files/Altair/2022.0/common/python/python3.5/win64/python.exe}
    {C:/Program Files/Altair/2023/common/python/python3.5/win64/python.exe}
}

# ─── 3. Folder chứa Python packages đi kèm (Pillow + openpyxl) ─────────────
# Trỏ tới vendor/ trong deploy — tool tự thêm vào PYTHONPATH, KHÔNG cần cài.
# Đặt "" nếu bạn đã cài package thẳng vào Altair Python site-packages.
set ::nc::config::vendor_site_packages \
    [file join $::nc::config::tool_dir vendor python35_site-packages]

# ═══════════════════════════════════════════════════════════════════════════
# Bên dưới là logic áp dụng config — KHÔNG cần sửa.
# ═══════════════════════════════════════════════════════════════════════════

proc ::nc::config::resolve_python {} {
    variable ::nc::config::python_candidates
    foreach c $::nc::config::python_candidates {
        if {[file exists $c]} { return $c }
    }
    return ""
}

proc ::nc::config::apply {} {
    set vendor $::nc::config::vendor_site_packages
    if {$vendor ne "" && [file isdirectory $vendor]} {
        set native [file nativename $vendor]
        set current ""
        if {[info exists ::env(PYTHONPATH)]} { set current $::env(PYTHONPATH) }
        if {[string first $native $current] < 0} {
            if {$current eq ""} {
                set ::env(PYTHONPATH) $native
            } else {
                set ::env(PYTHONPATH) "$native;$current"
            }
        }
    }
}

::nc::config::apply
