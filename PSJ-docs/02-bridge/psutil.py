# psutil shim — thay the psutil (PyPI) de KHONG phai tai thu vien ngoai.
# jupiterutils/PSJ_Interpreter.py chi dung: psutil.process_iter() -> proc.name(), proc.pid
# Shim nay dung ctypes (thu vien chuan Python) voi Toolhelp32Snapshot API cua Windows.
import ctypes
import ctypes.wintypes as wt

TH32CS_SNAPPROCESS = 0x00000002
MAX_PATH = 260


class PROCESSENTRY32(ctypes.Structure):
    _fields_ = [
        ("dwSize", wt.DWORD),
        ("cntUsage", wt.DWORD),
        ("th32ProcessID", wt.DWORD),
        ("th32DefaultHeapID", ctypes.POINTER(ctypes.c_ulong)),
        ("th32ModuleID", wt.DWORD),
        ("cntThreads", wt.DWORD),
        ("th32ParentProcessID", wt.DWORD),
        ("pcPriClassBase", ctypes.c_long),
        ("dwFlags", wt.DWORD),
        ("szExeFile", ctypes.c_char * MAX_PATH),
    ]


class _Proc:
    def __init__(self, pid, name):
        self.pid = pid
        self._name = name

    def name(self):
        return self._name


def process_iter():
    kernel32 = ctypes.windll.kernel32
    snapshot = kernel32.CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
    if snapshot == -1:
        return
    try:
        entry = PROCESSENTRY32()
        entry.dwSize = ctypes.sizeof(PROCESSENTRY32)
        if not kernel32.Process32First(snapshot, ctypes.byref(entry)):
            return
        while True:
            yield _Proc(entry.th32ProcessID, entry.szExeFile.decode("mbcs"))
            if not kernel32.Process32Next(snapshot, ctypes.byref(entry)):
                break
    finally:
        kernel32.CloseHandle(snapshot)
