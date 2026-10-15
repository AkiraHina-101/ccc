# dlg.activate_selector()

dlg.activate_selector()

説明​

セレクタIDでセレクタをアクティブ化します。

構文​

dlg.activate_selector(...)

入力​

selector_id​

セレクタIDを指定する Integer です。

これは必須の入力です。

戻り値​

この関数には出力値がありません。

サンプルコード​

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
        text="Applyボタンをクリックし、選択リストを開いて、「偶数のIDを持つセレクタがFace 1で選択され、" 
             "奇数のIDを持つセレクタがFace 2で選択されている」ことを確認してください。",
        text_halign="left",text_valign="top",layout="Window")

    dlg.generate_window()
    Geometry.Part.Cube()
    dlg.on_dlg_apply(callfunc=sampleSelection)

if __name__=='__main__':
    main()
