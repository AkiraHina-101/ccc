# dlg.activate_selector()

dlg.activate_selector()

Description​

Activate selector by selector id.

Syntax​

dlg.activate_selector(...)

Inputs​

selector_id​

An Integer specifying the selector id.

This is a required input.

Return Code​

This function does not have output value.

Sample Code​

from pyjdg import *

def sampleSelection(dlg):
    select1=[]
    select2=[]
    faces=JPT.GetAllFaces()
    for f in faces:
        if f.id % 2 == 0:
            select1.append(f.id)
        else:
            select2.append(f.id)
    JPT.ClearAllSelection()

    dlg.activate_selector(selector_id=0)
    for id in select1:
        JPT.SelectionByID(JPT.DItemType.FACE, id, True)
    dlg.activate_selector(selector_id=1)
    for id in select2:
        JPT.SelectionByID(JPT.DItemType.FACE, id, True)

def main():
    dlg=JDGCreator(title="Dialog")
    dlg.add_face_selector(text="Face 1")
    dlg.add_face_selector(text="Face 2")
    dlg.add_label(
        name="Label2",width=200,height=70,
        text="Click Apply button and open the selection list and confirm that " 
             "selectors with even IDs are selected in Face 1," 
             "and selectors with odd IDs are selected in Face 2.",
        text_halign="left",text_valign="top",layout="Window")

    dlg.generate_window()
    Geometry.Part.Cube()
    dlg.on_dlg_apply(callfunc=sampleSelection)

if __name__=='__main__':
    main()
