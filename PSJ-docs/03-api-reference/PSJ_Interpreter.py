import win32con, win32api, win32gui, ctypes, ctypes.wintypes, sys, struct, win32process
from array import array
import psutil 
import os

WM_DATA_JUPITER_INDEX = 4                                    
LISTENER_WINDOW_CLASS = 'jupiter_listener_class_name'        
LISTENER_WINDOW_CAPTION = 'win32gui_jupiter_listener_caption'
JUPITER_EXE = 'DCAD_main.exe'
DEBUG_TYPE = "debug; "                                        
FILE_TYPE = "file; "                                         
CODE_TYPE = "line; "                                         
ACTIVE = " true"
DEACTIVE = " false"
trimMsg = ""

isWindow64bit = sys.maxsize > 64
if isWindow64bit:
  class SHARED_MEMORY(ctypes.Structure):
    _fields_ = [('dwData', ctypes.c_ulonglong),
     ('cbData', ctypes.wintypes.DWORD),
     ('lpData', ctypes.c_void_p)]
else:
  class SHARED_MEMORY(ctypes.Structure):
    _fields_ = [('dwData', ctypes.wintypes.DWORD),
     ('cbData', ctypes.wintypes.DWORD),
     ('lpData', ctypes.c_void_p)]
PSHARED_MEMORY = ctypes.POINTER(SHARED_MEMORY)

def FindProcessIDByName(procName):
    for proc in psutil.process_iter():
        if proc.name() == procName:
            return proc.pid
        pass
    pass
            
def GetHwndsFromProcessID(pid):
    def callback(hwnd, hwnds):
        if win32gui.IsWindowVisible(hwnd) and win32gui.IsWindowEnabled(hwnd):
          _, found_pid = win32process.GetWindowThreadProcessId(hwnd)
          if found_pid == pid:
            hwnds.append(hwnd)
        return True
        
    hwnds = []
    win32gui.EnumWindows(callback, hwnds)
    return hwnds
    pass

def ToWideString(jsonMsg):
    return jsonMsg.encode('utf-16')
    pass

def Help():
    print("Usage: PSJ_Interpreter.py filePath activeJupiter")

def ToBoolPython(strBool):
    ret = True if strBool == 'True' else False
    return ret
    
def SendMessageIPC(winHandle, message):
    isWindow = win32gui.IsWindow(int(winHandle))
    if isWindow != 1:
        print("[Error] This is not a valid window hwnd")
        return
    pass
    
    # print("Send message to Jupiter...")
    buf = ctypes.create_string_buffer(message)
    copydata = SHARED_MEMORY()
    copydata.dwData = WM_DATA_JUPITER_INDEX
    copydata.cbData = buf._length_
    copydata.lpData = ctypes.cast(buf, ctypes.c_void_p)
    v = ctypes.windll.user32.SendMessageA(
        int(winHandle), win32con.WM_COPYDATA, 0,
        ctypes.byref(copydata))
    pass
    
def JupiterMessageHandler(msg):
    print(msg)

# it must be initiated before sending message to Jupiter    
class JupiterListener:
    def __init__(self, self_hinst=None, self_classAtom=None):
        message_map = {
            win32con.WM_COPYDATA: self.OnCopyData
        }
        wc = win32gui.WNDCLASS()
        wc.lpfnWndProc = message_map
        wc.lpszClassName = LISTENER_WINDOW_CLASS
        self.self_hinst = hinst = wc.hInstance = win32api.GetModuleHandle(None)
        self.self_classAtom = classAtom = win32gui.RegisterClass(wc)
        self.hwnd = win32gui.CreateWindow(
            classAtom,
            LISTENER_WINDOW_CAPTION,
            0,
            0, 
            0,
            win32con.CW_USEDEFAULT, 
            win32con.CW_USEDEFAULT,
            0, 
            0,
            hinst, 
            None
        )
        # print("\n######## NEW PSJ RUN SESSION ##########################################")
        #print("JupiterListener is listening for shared memory on hwnd %d" % self.hwnd)
    pass
        
    def OnCopyData(self, hwnd, msg, wparam, lparam):
    
        # for debug 
        # print("--> Received some message from Jupiter:")
        # print(hwnd)
        # print(msg)
        # print(wparam)
        # print(lparam)
        # print(pCDS.contents.dwData)
        # print(pCDS.contents.cbData)
        # for debug 
        
        pCDS = ctypes.cast(lparam, PSHARED_MEMORY)
        msg = ctypes.wstring_at(pCDS.contents.lpData)
        
        if pCDS.contents.dwData != WM_DATA_JUPITER_INDEX:
            print("[Error] This is not a message from Jupiter")
            return
        pass
            
        global trimMsg
        trimMsg = ''.join(filter(lambda x: ord(x) < 128, msg))
        trimMsg = trimMsg.replace('64)]', '')
        # JupiterMessageHandler(trimMsg)
        return 1
    pass
    
    def OnDestroy(self, hwnd, msg, wparam, lparam):
        nid =(self.hwnd, 0)
        Shell_NotifyIcon(NIM_DELETE, nid)
        PostQuitMessage(0) # Terminate the app.
    pass

def SendMessageToJupiter(sendMsg):
    pid = FindProcessIDByName(JUPITER_EXE)
    if pid == None:
        print("[Error] Jupiter is not running now!")
        return
    pass
    
    #print("Jupiter process ID: %d" % pid)
    for hwnd in GetHwndsFromProcessID(pid):
        SendMessageIPC(hwnd, ToWideString(sendMsg))
    pass

# for run debug mode from external IDE, can run continuously    
def RUN_DEBUG(line, activeJupiter):
    active = ACTIVE if activeJupiter == True else DEACTIVE
    connector = JupiterListener()
    message = DEBUG_TYPE + line + ";" + active
    SendMessageToJupiter(message)
    win32gui.DestroyWindow(connector.hwnd)
    win32gui.UnregisterClass(connector.self_classAtom, connector.self_hinst) 
    return trimMsg
    pass

# for run a file from external IDE  
def RUN_FILE(filePath, activeJupiter):
    active = ACTIVE if activeJupiter == True else DEACTIVE
    connector = JupiterListener() 
    message = FILE_TYPE + filePath + ";" + active
    SendMessageToJupiter(message)
    win32gui.DestroyWindow(connector.hwnd)
    win32gui.UnregisterClass(connector.self_classAtom, connector.self_hinst) 
    # win32gui.PumpMessages()
    pass

# for run a block code from external IDE 
def RUN_CODE(line, activeJupiter):
    active = ACTIVE if activeJupiter == True else DEACTIVE
    connector = JupiterListener() 
    message = CODE_TYPE + line + ";" + active
    SendMessageToJupiter(message)
    win32gui.DestroyWindow(connector.hwnd)
    win32gui.UnregisterClass(connector.self_classAtom, connector.self_hinst) 
    # win32gui.PumpMessages()  
    pass
    
if len(sys.argv) != 3:
    # Help()
    pass
else:
    file = sys.argv[1]
    activeJPT = sys.argv[2]
    RUN_FILE(file.strip(), ToBoolPython(activeJPT.strip()))
        
# test cases    
# RUN_FILE('/SampleData/PSJ/PSJ-Utility/Jupiter_Path_Information.py', False)
# RUN_CODE('print("hello world")', False)
# RUN_DEBUG('Geometry.Part.Cube()', False)
