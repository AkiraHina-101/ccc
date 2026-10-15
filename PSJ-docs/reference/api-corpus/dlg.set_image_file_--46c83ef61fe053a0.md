# dlg.set_image_file()

dlg.set_image_file()

説明​

ImageCtrlに画像を設定します。

構文​

dlg.set_image_file(...)

入力​

name​

ImageCtrlコンポーネントの名前を指定する String の値です。

この入力は必須です。

image_path​

画像のフルパスを指定する String の値です。

この入力は必須です。

戻り値​

この関数には出力値がありません。

サンプルコード​

from pyjdg import *

def onChangeButtonClicked(dlg):
    new_pic = JPT.GetProgramPath() + r"SampleData\PSJ\PSJ-GUI\CreateBolt\CreatingBolt_Pics\M4.JPG"
    dlg.set_image_file(name="ImageCtrl",image_path=new_pic)

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    image = JPT.GetProgramPath() + \
        r"SampleData\PSJ\PSJ-GUI\CreateBolt\CreatingBolt_Pics\M3.JPG"
    dlg.add_imagectrl(name="ImageCtrl",image_file=image,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ChangePic",text="Change",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_command(name="ChangePic",callfunc=onChangeButtonClicked)

if __name__=='__main__':
    main()
