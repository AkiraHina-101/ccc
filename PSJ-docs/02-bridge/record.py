# Record thao tac GUI cua Jupiter thanh script Python.
# Nguyen ly: Jupiter tu ghi moi thao tac vao PSJCommands.py (log noi bo).
# Tool nay chi DOC file do — khong sua gi trong Jupiter.
#
# Che do LIVE (khuyen dung, gan voi phim tat):
#   Ctrl+Alt+R -> record.py live : lenh do ve recorded.py NGAY khi thao tac
#   Ctrl+Alt+S -> record.py stop : dung live
#   (Mo san recorded.py trong editor de xem code hien ra realtime.
#    KHONG go/sua file trong luc live — sua sau khi Stop.)
#
# Che do cu (2 buoc, van dung duoc tu terminal):
#   python record.py start  ->  ... thao tac ...  ->  python record.py stop
import glob
import json
import os
import sys
import tempfile
import time

_DIR = os.path.dirname(os.path.abspath(__file__))
STATE_FILE = os.path.join(_DIR, "_record_state.json")
SENTINEL = os.path.join(_DIR, "_record_live_stop")
OUT_FILE = os.path.join(_DIR, "recorded.py")

PROTECTED_TOOL_FILES = {
    "insert_selection.py",
    "insert_visibility.py",
    "psj_autocomplete.py",
    "psutil.py",
    "record.py",
    "send.py",
    "test_hello.py",
}

AUTOCOMPLETE_HEADER = (
    "# Chi cho VSCode/Pylance; Jupiter khong chay import nay.\n"
    "from typing import TYPE_CHECKING\n"
    "if TYPE_CHECKING:\n"
    "    from psj_autocomplete import *  # noqa: F403\n\n"
)

HEADER = ("# Recorded tu Jupiter GUI — sua tuy y.\n"
          "# CHAY LAI: mo file nay roi nhan Ctrl+Shift+B (hoac: python send.py recorded.py)\n"
          "# (KHONG bam nut Run truc tiep — cu phap nay chi chay BEN TRONG Jupiter)\n")


def set_output_file(path):
    """Khoa file dich cho ca phien live; tu choi ghi de file ha tang tool."""
    global OUT_FILE

    target = os.path.abspath(path)
    if os.path.splitext(target)[1].lower() != ".py":
        raise ValueError("File record phai co duoi .py: " + target)

    target_dir = os.path.normcase(os.path.dirname(target))
    tool_dir = os.path.normcase(_DIR)
    jupiterutils_dir = os.path.normcase(os.path.join(_DIR, "jupiterutils"))
    try:
        inside_jupiterutils = os.path.commonpath(
            [target_dir, jupiterutils_dir]
        ) == jupiterutils_dir
    except ValueError:
        inside_jupiterutils = False

    if inside_jupiterutils:
        raise ValueError("Khong duoc record vao jupiterutils: " + target)
    if target_dir == tool_dir and os.path.basename(target).lower() in PROTECTED_TOOL_FILES:
        raise ValueError("Khong duoc record de len file tool: " + target)

    OUT_FILE = target
    return OUT_FILE


def newest_log(kind="psj"):
    # Jupiter tao folder 00/01/02... moi phien — lay file moi sua gan nhat
    # kind="psj": PSJCommands.py (lenh Python sach, KHONG co lenh hien thi)
    # kind="jpl": *.jpl (macro goc, ghi TAT CA ke ca Hide/Show/View...)
    name = "PSJCommands.py" if kind == "psj" else "*.jpl"
    pattern = os.path.expanduser(r"~\AppData\Local\Temp\TechnoStar\*" + "\\" + name)
    files = glob.glob(pattern)
    if not files:
        sys.exit("[RECORD] Khong tim thay {} — Jupiter da mo chua?".format(name))
    return max(files, key=os.path.getmtime)


def _append(text):
    if os.path.exists(OUT_FILE) and os.path.getsize(OUT_FILE) > 0:
        with open(OUT_FILE, "r", encoding="utf-8", errors="replace") as f:
            current = f.read()
        if "from psj_autocomplete import" not in current:
            with open(OUT_FILE, "w", encoding="utf-8") as f:
                f.write(AUTOCOMPLETE_HEADER + current)
    need_header = not os.path.exists(OUT_FILE) or os.path.getsize(OUT_FILE) == 0
    with open(OUT_FILE, "a", encoding="utf-8") as f:
        if need_header:
            f.write(HEADER + "\n" + AUTOCOMPLETE_HEADER)
        f.write(text)


def _to_exec(new_code):
    # Bien moi dong macro JPL thanh JPT.Exec('...') de chay lai duoc trong Jupiter
    out = []
    for line in new_code.splitlines():
        s = line.strip()
        if not s:
            continue
        out.append("JPT.Exec('{}')".format(s.replace("\\", "\\\\").replace("'", "\\'")))
    return ("\n".join(out) + "\n") if out else ""


def live(kind="psj"):
    if os.path.exists(SENTINEL):
        os.remove(SENTINEL)  # don sentinel cu con sot lai
    log = newest_log(kind)
    offset = os.path.getsize(log)
    tag = "RECORD LIVE" if kind == "psj" else "RECORD LIVE FULL(JPL)"
    _append("\n# ===== {} {} =====\n".format(tag, time.strftime("%Y-%m-%d %H:%M:%S")))
    print("[RECORD-LIVE] Dang ghi truc tiep tu:", log)
    print("[RECORD-LIVE] File dich:", OUT_FILE)
    print("[RECORD-LIVE] Thao tac tren Jupiter — lenh se hien dan trong file dich")
    print("[RECORD-LIVE] Nhan Ctrl+Alt+S (hoac tao file _record_live_stop) de DUNG.")
    captured = 0
    while True:
        time.sleep(0.5)
        if os.path.exists(SENTINEL):
            os.remove(SENTINEL)
            print("[RECORD-LIVE] Da dung. Tong cong {} dong.".format(captured))
            return
        try:
            size = os.path.getsize(log)
        except OSError:
            continue  # log tam thoi khong doc duoc
        if size < offset:
            offset = 0  # log bi reset (phien moi) — doc lai tu dau
        if size > offset:
            with open(log, "r", encoding="utf-8", errors="replace") as f:
                f.seek(offset)
                new_code = f.read()
            offset = size
            if new_code:
                text = _to_exec(new_code) if kind == "jpl" else new_code
                _append(text)
                captured += text.count("\n")
                for line in text.splitlines():
                    if line.strip():
                        print("[+]", line)


def start():
    log = newest_log()
    with open(STATE_FILE, "w") as f:
        json.dump({"log": log, "offset": os.path.getsize(log)}, f)
    print("[RECORD] Bat dau ghi tu:", log)
    print("[RECORD] Thao tac tren Jupiter roi chay: python record.py stop")


def stop():
    # Uu tien dung che do live (neu dang chay); khong thi xu ly che do start/stop cu
    if not os.path.exists(STATE_FILE):
        with open(SENTINEL, "w") as f:
            f.write("stop")
        print("[RECORD] Da gui tin hieu dung live record.")
        return
    with open(STATE_FILE) as f:
        state = json.load(f)
    with open(state["log"], "r", encoding="utf-8", errors="replace") as f:
        f.seek(state["offset"])
        new_code = f.read()
    os.remove(STATE_FILE)
    if not new_code.strip():
        print("[RECORD] Khong co lenh moi nao duoc ghi.")
        return
    _append("\n# ===== RECORD {} =====\n".format(time.strftime("%Y-%m-%d %H:%M:%S")) + new_code)
    print("[RECORD] Cac lenh vua thao tac:")
    print("-" * 50)
    print(new_code)
    print("-" * 50)
    print("[RECORD] Da luu vao:", OUT_FILE)


def self_test():
    original = OUT_FILE
    temp_path = None
    try:
        assert set_output_file(os.path.join(_DIR, "my_macro.py")).endswith(
            "my_macro.py"
        )
        for invalid in (
            os.path.join(_DIR, "record.py"),
            os.path.join(_DIR, "jupiterutils", "unsafe.py"),
            os.path.join(_DIR, "not_python.txt"),
        ):
            try:
                set_output_file(invalid)
            except ValueError:
                pass
            else:
                raise AssertionError("phai tu choi file dich {!r}".format(invalid))

        with tempfile.NamedTemporaryFile(
            mode="w", suffix=".py", encoding="utf-8", delete=False
        ) as temp_file:
            temp_file.write("print('before')\n")
            temp_path = temp_file.name
        set_output_file(temp_path)
        _append("print('recorded')\n")
        with open(temp_path, "r", encoding="utf-8") as temp_file:
            result = temp_file.read()
        assert "print('before')" in result
        assert "print('recorded')" in result
        assert result.count("from psj_autocomplete import") == 1
    finally:
        globals()["OUT_FILE"] = original
        if temp_path and os.path.exists(temp_path):
            os.remove(temp_path)
    print("[STATIC-TEST] record target: PASS")


if __name__ == "__main__":
    if len(sys.argv) == 2 and sys.argv[1] == "--self-test":
        self_test()
    elif len(sys.argv) in (2, 3) and sys.argv[1] in ("live", "livefull"):
        if len(sys.argv) == 3:
            try:
                set_output_file(sys.argv[2])
            except ValueError as exc:
                sys.exit("[RECORD-LIVE] LOI: " + str(exc))
        live("jpl" if sys.argv[1] == "livefull" else "psj")
    elif len(sys.argv) == 2 and sys.argv[1] in ("start", "stop"):
        {"start": start, "stop": stop}[sys.argv[1]]()
    else:
        print(
            "Cach dung: python record.py live|livefull [file.py] | start | stop | --self-test"
        )
