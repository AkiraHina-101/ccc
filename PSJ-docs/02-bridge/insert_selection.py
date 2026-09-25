"""Tao snippet PSJ tu selection hien tai trong Jupiter va chep vao clipboard.

Provider hien tai: FACE va BODY (part). Cau truc ``PROVIDERS`` duoc giu nho de
cac snapshot khac, nhu visibility, co the duoc them theo tung vong GT sau nay.
"""
import ast
import ctypes
import os
import sys


PROVIDERS = (
    ("FACE", "JPT.GetSelectedFaces()"),
    ("BODY", "JPT.GetSelectedParts()"),
)


def parse_id_list(raw):
    """Parse ket qua IPC dang list[int], tu choi moi du lieu khac."""
    try:
        value = ast.literal_eval(raw)
    except (SyntaxError, ValueError) as exc:
        raise ValueError("ket qua IPC khong phai list ID: {!r}".format(raw)) from exc
    if not isinstance(value, list) or any(
        isinstance(item, bool) or not isinstance(item, int) for item in value
    ):
        raise ValueError("ket qua IPC khong phai list ID: {!r}".format(raw))
    return value


def make_snippet(selections):
    """Build mot dong SelectionByIDs cho moi provider co ID."""
    lines = []
    for item_type, ids in selections:
        if ids:
            lines.append(
                "JPT.SelectionByIDs(JPT.DItemType.{}, {}, "
                "JPT.BoolType.TRUE_VAL)".format(item_type, ids)
            )
    return "\n".join(lines)


def copy_to_clipboard(text):
    """Copy Unicode text bang Win32 API; khong can thu vien ngoai."""
    if os.name != "nt":
        raise RuntimeError("clipboard helper hien chi ho tro Windows")

    user32 = ctypes.windll.user32
    kernel32 = ctypes.windll.kernel32
    global_alloc = kernel32.GlobalAlloc
    global_lock = kernel32.GlobalLock
    global_unlock = kernel32.GlobalUnlock
    global_free = kernel32.GlobalFree

    global_alloc.argtypes = (ctypes.c_uint, ctypes.c_size_t)
    global_alloc.restype = ctypes.c_void_p
    global_lock.argtypes = (ctypes.c_void_p,)
    global_lock.restype = ctypes.c_void_p
    global_unlock.argtypes = (ctypes.c_void_p,)
    global_free.argtypes = (ctypes.c_void_p,)
    user32.SetClipboardData.argtypes = (ctypes.c_uint, ctypes.c_void_p)
    user32.SetClipboardData.restype = ctypes.c_void_p
    data = (text + "\0").encode("utf-16-le")
    handle = global_alloc(0x0002, len(data))  # GMEM_MOVEABLE
    if not handle:
        raise OSError("GlobalAlloc that bai")

    opened = False
    transferred = False
    try:
        pointer = global_lock(handle)
        if not pointer:
            raise OSError("GlobalLock that bai")
        try:
            ctypes.memmove(pointer, data, len(data))
        finally:
            global_unlock(handle)

        if not user32.OpenClipboard(None):
            raise OSError("OpenClipboard that bai")
        opened = True
        if not user32.EmptyClipboard():
            raise OSError("EmptyClipboard that bai")
        if not user32.SetClipboardData(13, handle):  # CF_UNICODETEXT
            raise OSError("SetClipboardData that bai")
        transferred = True  # Windows tu quan ly handle sau SetClipboardData
    finally:
        if opened:
            user32.CloseClipboard()
        if not transferred:
            global_free(handle)


def read_current_selection(run_line):
    selections = []
    for item_type, getter in PROVIDERS:
        expression = "[item.id for item in {}]".format(getter)
        selections.append((item_type, parse_id_list(run_line(expression))))
    return selections


def main(stdout_only=False):
    from jupiterutils import JPT_RUN_LINE

    if not stdout_only:
        print("[INSERT-SELECTION] Dang doc selection tu Jupiter...")
    try:
        selections = read_current_selection(JPT_RUN_LINE)
        snippet = make_snippet(selections)
        if not snippet:
            print(
                "[INSERT-SELECTION] Khong co FACE hoac PART nao dang duoc chon.",
                file=sys.stderr if stdout_only else sys.stdout,
            )
            return 2
        if not stdout_only:
            copy_to_clipboard(snippet)
    except Exception as exc:
        print(
            "[INSERT-SELECTION] LOI:",
            exc,
            file=sys.stderr if stdout_only else sys.stdout,
        )
        return 1

    if stdout_only:
        print(snippet)
        return 0

    print("[INSERT-SELECTION] Da chep vao clipboard:")
    print(snippet)
    print("[INSERT-SELECTION] Dat con tro trong script va nhan Ctrl+V.")
    return 0


def self_test():
    assert parse_id_list("[22, 26, 31]") == [22, 26, 31]
    assert parse_id_list("[]") == []
    for invalid in ("FaceVector()", "[1, '2']", "True"):
        try:
            parse_id_list(invalid)
        except ValueError:
            pass
        else:
            raise AssertionError("phai tu choi {!r}".format(invalid))

    result = make_snippet((("FACE", [22, 26]), ("BODY", [1, 2])))
    assert result == (
        "JPT.SelectionByIDs(JPT.DItemType.FACE, [22, 26], "
        "JPT.BoolType.TRUE_VAL)\n"
        "JPT.SelectionByIDs(JPT.DItemType.BODY, [1, 2], "
        "JPT.BoolType.TRUE_VAL)"
    )
    assert make_snippet((("FACE", []), ("BODY", []))) == ""
    print("[STATIC-TEST] insert_selection: PASS")


if __name__ == "__main__":
    if len(sys.argv) == 2 and sys.argv[1] == "--self-test":
        self_test()
    elif len(sys.argv) == 2 and sys.argv[1] == "--stdout":
        sys.exit(main(stdout_only=True))
    elif len(sys.argv) == 1:
        sys.exit(main())
    else:
        sys.exit("Cach dung: python insert_selection.py [--stdout | --self-test]")
