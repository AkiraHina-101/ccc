"""Wait for the analyzer and report only its final result to Jupiter."""
import argparse
import ctypes
from ctypes import wintypes


def set_status(hwnd, text):
    ctypes.windll.user32.SetWindowTextW(wintypes.HWND(hwnd), text)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--pid", type=int, required=True)
    ap.add_argument("--status-hwnd", type=int, required=True)
    args = ap.parse_args()

    kernel32 = ctypes.windll.kernel32
    handle = kernel32.OpenProcess(0x00100000 | 0x1000, False, args.pid)
    if not handle:
        return 2
    kernel32.WaitForSingleObject(handle, 0xFFFFFFFF)
    exit_code = wintypes.DWORD()
    kernel32.GetExitCodeProcess(handle, ctypes.byref(exit_code))
    kernel32.CloseHandle(handle)
    if exit_code.value == 0:
        set_status(args.status_hwnd, "READY: Analyzer complete (100%)")
        message = "Analyzer complete."
        icon = 0x40
    else:
        set_status(args.status_hwnd, "FAILED: Analyzer did not complete")
        message = "Analyzer failed. Check the log."
        icon = 0x10
    ctypes.windll.user32.MessageBoxW(
        0, message, "Surface Split v2.5", icon)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
