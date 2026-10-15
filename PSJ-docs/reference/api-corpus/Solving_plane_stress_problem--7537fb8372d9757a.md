# Solving plane stress problem

Solving plane stress problem

This sample contains topics as follows:

How to get number of parts.

How to rename parts.

How to create mesh.

How to define materials.

How to use Combo box (GUI)

How to use the Code​

Import CAD file or create some parts in a document.

Run the attached code.

Code​

# coding=utf-8

import sys
import os
from pyjdg import *

#------------------------------------------------
def defBody(dlg):

    global partname

    listParts = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, aname, JPT.BoolType.FALSE_VAL) 

    partname = [""]*npart

    for i in range(npart):
    # ----- Rename CAD ------
        nameOld = pnam[i]
        nameNew = dlg.get_item_text(name="textname"+str(i))
        print(nameOld + ' to  ' + nameNew)
        listParts[i].name = nameNew
        partname[i] = nameNew

    # ----- Generate mesh -----
        inValue = dlg.get_item_text(name="textmesh"+str(i))  # ElemSize [meter]
        aveSize = float(inValue)/1000.0
        maxSize = 1.5 * aveSize         # max should be >= 1.4*aveSize
        minSize = 0.6 * aveSize         # min should be <= 0.7*aveSize

        if aveSize > 0:
            surface_status = Meshing.SurfaceMeshing(crlParts=[Part(nid[i])], 
                           surfaceMesh=SURFACE_MESH(dAvgElemSize=aveSize, 
                                                    dMaxElemSize=maxSize,
                                                    dMinElemSize=minSize))
            JPT.Debugger(surface_status)

            meshing_status = Meshing.SolidMeshing(crlParts=[Part(nid[i])], 
                                                  bTet10=False)
            print("Meshing "+pnam[i])
            JPT.Debugger(meshing_status)
        else:       
            print("----------------------------------------------------")
            print("Please check element size of "+pnam[i])
            print("----------------------------------------------------")

    # ------ Material ------
    matid = 0
    for i in range(npart):

      strmatname = dlg.get_item_text(name="combobox"+str(i))  # material 

      for j in range(nmat):
        if strmatname == matname[j]:     # ' UserMat1 ' => 'UserMat1'
          matid = j
          print(matname[j])

      created_prop =  Properties.Solid(strName="Solid Property"+str(i+1), 
                                   iPropertyId=i+1,
                                   crMaterial=Material(matid+1),            
                                   iCordM=-2, 
                                   dDispHG=DFLT_DBL, 
                                   crlTargets=[Part(nid[i])],               
                                   iFLG=-1)

    print("--- Finish mesh creation ----")

#------------------------------------------------
def materialList():
    global structure_steel, alminum_alloy, cushion, cardboard
    global nmat, matname

    #length:mm   weight:ton   force:N
    #Density:ton/mm3   YoungsModulus:N/mm2

    nmat = 4
    matname = ['']*nmat
    matname[0] = "Structural_Steel"
    matname[1] = "Alminum_Alloy"
    matname[2] = "UserMaterial1"
    matname[3] = "UserMaterial2"

    structure_steel = Properties.Material.Add(matname[0], 
                        [Density([(DENSITY, 7.85e-09)]),
                         Elastic([(YOUNGS_MODULUS, 200000.0),(POISSONS_RATIO, 0.3)])])

    alminum_alloy = Properties.Material.Add(matname[1], 
                        [Density([(DENSITY, 2.77e-09)]),
                         Elastic([(YOUNGS_MODULUS, 71000.0), (POISSONS_RATIO, 0.3)])])

    usermat1 = Properties.Material.Add(matname[2], 
                        [Density([(DENSITY, 2.00e-10)]),
                         Elastic([(YOUNGS_MODULUS, 2000.0), (POISSONS_RATIO, 0.3)])])

    usermat2 = Properties.Material.Add(matname[3], 
                        [Density([(DENSITY, 1.00e-10)]),
                         Elastic([(YOUNGS_MODULUS, 500.0), (POISSONS_RATIO, 0.3)])])

    print("--- Finish material definition ----")

#------------------------------------------------
def partsPanel():
    global pnam, nid, npart
    global aname

    pnam = ['']*100
    nid = [-1]*100
    aname = ''

    print('  - Get name of parts -')
    # parts名に、aname(ファイル名）が含まれるパーツのリスト 
    listParts = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_BODY, aname, JPT.BoolType.FALSE_VAL)  
    npart = len(listParts)   # CAD内の部品数  n\

    # JPT.Boo Type.TRUE_VAL = True あるいは Falseの操作情報が残る 
    # JPT.BoolType.TRUE_VALとJPT.BoolType.FALSE_VALのリセット 
    if JPT.BoolType.TRUE_VAL == False:
        JPT.BoolType.TRUE_VAL = True
        print('JPT.BoolType.TRUE_VAL is set True')

    if JPT.BoolType.FALSE_VAL == True:
        JPT.BoolType.FALSE_VAL = False
        print('JPT.BoolType.False_VAL is set False')

    JPT.ShowHideAllParts(JPT.BoolType.TRUE_VAL)  

    dlg=JDGCreator(title="Browser parts",resizable=True,validation=True)

    dlg.add_layout(name="title",orientation=orientation.horizontal,layout="Window")
    dlg.add_label(name="title1",text="Old Name",width=100,text_halign="left",text_valign="top",layout="title")
    dlg.add_label(name="title3",text="New Name", width=100,layout="title")
    dlg.add_label(name="title4",text="Mesh size \n (average)", width=100,height=30, layout="title")
    dlg.add_label(name="title5",text="Material",width=100,text_halign="left",text_valign="top",layout="title")

    materialList()
    optcomb = []
    for i in range(nmat):
        optcomb.append(matname[i])

    for num in range(npart):
        laynam = 'Layout'+str(num)
        pnam[num] = 'n.a.'
        checkFlag = False
        if num < npart : 
           nid[num] = listParts[num].id
           laynam = 'ID '+str(nid)
           pnam[num] = listParts[num].name
           checkFlag = True
        dlg.add_layout(name=laynam,orientation=orientation.horizontal,layout="Window")
        dlg.add_label(name="label"+str(num),text=pnam[num],width=80,text_halign="left",text_valign="top",layout=laynam)
        dlg.add_textbox(name="textname"+str(num),text=pnam[num],width=120,layout=laynam)
        dlg.add_textbox(name="textmesh"+str(num),text="10",type="double",width=100,layout=laynam)
        dlg.add_combobox(name="combobox"+str(num),options=optcomb,index=1,layout=laynam)
        dlg.add_label(name="label2"+str(num),text=' ',width=10,layout=laynam)

    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonOK",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()

    dlg.on_button_clicked(name="ButtonOK", callfunc=createBody)
    dlg.on_button_clicked(name="ButtonCancel", callfunc=closeWindow)

#-----------------------------------------------
def createBody(dlg):   # File DialogでOKボタン時 \n
    print('-- Start to create body --')
    defBody(dlg)

#-----------------------------------------------
def closeWindow(dlg):   # File DialogでCancelボタン時
    print('-- Cancel job  --')
    dlg.close()

#-----------------------------------------------
if __name__=='__main__':

    partsPanel()
