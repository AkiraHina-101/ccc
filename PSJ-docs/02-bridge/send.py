# Gui nguyen mot file script vao Jupiter dang chay (thuc thi BEN TRONG Jupiter).
# Dung cho file record duoc (cu phap PSJ noi bo) hoac script PSJ bat ky.
#
# Cach dung:  python send.py recorded.py
# Ket qua/loi hien trong cua so Python API cua Jupiter (Home > Window > Python API).
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from jupiterutils import JPT_RUN_FILE  # noqa: E402

if len(sys.argv) != 2:
    sys.exit("Cach dung: python send.py <file.py>")

path = os.path.abspath(sys.argv[1])
if not os.path.isfile(path):
    sys.exit("[SEND] Khong thay file: " + path)

print("[SEND] Gui vao Jupiter:", path)
JPT_RUN_FILE(path)
print("[SEND] Da gui. Xem ket qua o cua so Python API cua Jupiter.")
