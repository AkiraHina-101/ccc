# Advanced sample 3 - Highlight Assemble Faces

Advanced sample 3 - Highlight Assemble Faces

🎯 Introduction​

In this tutorial, you'll learn how a table highlight Assemble Face in model:

Get groups from model and fill group names and IDs into table.

If selects group name, JPT gets information of assemble faces and associated part, then highlights the assemble faces and sets transparency of parts.

If selects group ID, JPT gets information of assemble faces and associated part, then highlights the assemble faces and sets transparency of parts.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

from pyjdg import *

JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('CreateCube([0.01, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_2", 6409934, 0:0)')
JPT.Exec('CreateCube([0.02, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_3", 13259210, 0:0)')
JPT.Exec('AssembleFaceMatingStep([], [], [3:1, 3:2, 3:3], 0.0001)')
JPT.Exec('AssembleFaceEx([49, 24, 50, 75], 0.0001, 0, 0)')
JPT.ViewFitToModel()

def on_click_set_info_cell(dlg):
    """
    Executes to get Group information, returns and sets Group Name/ID to table cell
        Parameters:
            No direct parameters, but requires the Groups in Group Tree must exit
        Returns:
            Sets Name of Group to the first column (col=0)
            Sets ID of Group to the second column (col=1)
    """
    JPT.ClearLog()
    listGroups = JPT.GetAllGroups()
    for i in range(listGroups.sizeVec()):
        group = listGroups[i]
        dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=0,value=group.name)
        dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=1,value=str(group.id))

def associated_part(selection):
    """
    Gets the associated Parts that face belong to, returns and sets transparency for those associated Parts
        Parameters:
            All selected Faces(vector)
        Returns:
            Sets transparency to be 10% for the associated Parts that Face belong to
    """
    all_bodies = JPT.GetAllParts()
    for i in range(all_bodies.sizeVec()):
        all_bodies[i].transparency = 100
    associate_body = JPT.GetEntitiesByAssociation(JPT.DItemType.FACE, JPT.AssociateType.AS_BODY, int(selection[0].id))
    for i in range(associate_body.sizeVec()):
        JPT.SelectionByID(JPT.DItemType.BODY, associate_body[i].id, JPT.BoolType.TRUE_VAL)
    selected_body = JPT.GetSelectedParts()
    for i in range(selected_body.sizeVec()):
        selected_body[i].transparency = 10
    JPT.ClearAllSelection()

def select_face_in_group_by_name(group_name):
    """
    Get Group's Name from the cell, returns the entity Face of Group
        Parameters:
            Group Name(string): Name of the Group in the first column of the table (col=0)
        Returns:
            Selects the Face entity of Group
    """
    groups = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_GROUP, group_name, 1)
    if groups.sizeVec() > 0:
        if groups[0].targets.sizeVec() > 0:
            for entity in groups[0].targets:
                JPT.SelectionByID(JPT.DItemType.FACE, entity.id, JPT.BoolType.TRUE_VAL)
                selected_face = JPT.GetAllSelected()
                associated_part(selected_face)
                JPT.SelectionByID(JPT.DItemType.FACE, entity.id, JPT.BoolType.TRUE_VAL)

def select_face_in_group_by_id(group_id):
    """
    Get Group's ID from the cell, returns the entity Face of Group
        Parameters:
            Group ID(int): ID of the Group in the second column of the table (col=1)
        Returns:
            Selects the Face entity of Group
    """
    group_entity = JPT.GetEntitiesByID(JPT.DItemType.GROUP,int(group_id))
    if group_entity.sizeVec() > 0:
        if group_entity[0].targets.sizeVec() > 0:
            for entity in group_entity[0].targets:
                JPT.SelectionByID(JPT.DItemType.FACE, entity.id, JPT.BoolType.TRUE_VAL)
                selected_face = JPT.GetAllSelected()
                associated_part(selected_face)
                JPT.SelectionByID(JPT.DItemType.FACE, entity.id, JPT.BoolType.TRUE_VAL)

def on_sel_change(dlg,name,target_cell):
    """
    Takes the value of cell, returns the View and highlights the Face
        Parameters:
            dlg: Dialog
            name(string): Name of the Table
            target_cell(object): TableCellID object specifying the location of cell in table
        Returns:
            Sets View that shows the target Face
        Note:
            This function calls the 2 functions: select_face_in_group_by_name & select_face_in_group_by_id
    """
    JPT.ClearAllSelection()
    target_cell = dlg.get_table_sel_cell(name="Table1")
    target_name = dlg.get_cell_value(name="Table1",cell_row_id=target_cell[0].row_number,cell_column_id=target_cell[0].col_number)
    target_id = dlg.get_cell_value(name="Table1",cell_row_id=target_cell[0].row_number,cell_column_id=target_cell[0].col_number)
    if target_cell[0].col_number==0:
        select_face_in_group_by_name(target_name)
    elif target_cell[0].col_number==1:
        select_face_in_group_by_id(target_id)
    JPT.ViewFitToModel()

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_layout(name="Layout1",orientation=orientation.vertical,layout="Window")
    dlg.add_table(name="Table1",rows=5,columns=["Name","Index"],layout="Window",width=260,height=260)
    dlg.add_label(name="Label3",text="1. Select the 'GetGroup' Button",layout="Layout1")
    dlg.add_label(name="Label4",text="2. Select the cell",layout="Layout1")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="GetGroup",text="GetGroup",width=70,height=30,layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="GetGroup",callfunc=on_click_set_info_cell)
    dlg.on_table_sel_changed(name="Table1",callfunc=on_sel_change)

if __name__=='__main__':
    main()
