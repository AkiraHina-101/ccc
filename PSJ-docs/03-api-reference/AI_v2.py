from pyjdg import *
import ctypes

# === Global State ===
step_flag = 0                  # 0: First click (pick), 1: Second click (apply)
selected_faces = []           # List of face IDs selected in first step
picked_nodes = []             # Node IDs associated with the selected faces

# === Get face IDs from current selection ===
def get_selected_face_ids():
    return [face.id for face in JPT.GetSelectedFaces()]

# === Step 0: Pick nodes from selected faces ===
def handle_step_0():
    global step_flag, selected_faces, picked_nodes

    selected_faces = get_selected_face_ids()
    JPT.Exec("Show_Ref_Only()")

    face_refs = ', '.join([f"6:{fid}" for fid in selected_faces])
    picked_nodes = JPT.Exec(f'AssociatedPick([{face_refs}], "Node", "UNKNOWN")')

    print("Picked nodes:", picked_nodes)
    step_flag = 1  # Switch to apply mode

# === Step 1: Assign picked nodes to a new face ===
def handle_step_1():
    global step_flag

    JPT.Exec("Show_Mesh_Only()")
    faces = JPT.GetAllSelected()

    if len(faces) < 2:
        print("Please select at least 2 faces.")
        return

    outer_id = faces[1].id
    internal_id = JPT.GetInternalIDRefItem(JPT.DItemType.REF_FACE, outer_id)

    JPT.Exec(f'CadProject_NodeToFace([15:{outer_id}-{internal_id}], {picked_nodes}, 0, 0, -1, 0)')

    step_flag = 0
    JPT.ClearAllSelection()

# === Apply button handler that switches by state ===
def on_apply(dlg):
    if step_flag == 0:
        handle_step_0()
    elif step_flag == 1:
        handle_step_1()
    else:
        print("Invalid step flag.")

# === Simulate pressing Space to activate selector ===
def simulate_space_key():
    ctypes.windll.user32.keybd_event(0x20, 0, 0, 0)  # Key down
    ctypes.windll.user32.keybd_event(0x20, 0, 2, 0)  # Key up

# === Main GUI definition ===
def main():
    dlg = JDGCreator(title="Node to Face Mapper")

    dlg.add_face_selector()
    dlg.add_groupbox(name="FaceGroup", text="Step 1: Pick Face → Step 2: Assign Nodes", layout="Window")

    simulate_space_key()

    dlg.on_dlg_apply(callfunc=on_apply)
    dlg.generate_window()

if __name__ == '__main__':
    main()
