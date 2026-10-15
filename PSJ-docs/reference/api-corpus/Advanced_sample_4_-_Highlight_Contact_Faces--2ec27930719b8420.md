# Advanced sample 4 - Highlight Contact Faces

Advanced sample 4 - Highlight Contact Faces

🎯 Introduction​

In this tutorial, you'll learn how a table highlight Contact Face in model:

Get Contacts from model and fill Contact names and IDs into table.

If selects Contact name, JPT gets information of contact faces and associated parts, then highlights the contact faces and sets transparency of parts.

If selects Contact ID, JPT gets information of contact faces and associated parts, then highlights the contact faces and sets transparency of parts.

Please note that displaying language will affect to the returned value of JPT.GetAssemblyEntityData().

The sample is using English language, for other languages, please pass the appropriate character string.

📖 Tutorial​

English

Japanese

# Encoding for Japanese
# coding: cp932

from pyjdg import *

JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('CreateCube([0.01, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_2", 6409934, 0:0)')
JPT.Exec('CreateCube([0.02, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_3", 13259210, 0:0)')
JPT.Exec('BEGIN_TRANSACTION("Add Lbc Contact.")')
JPT.Exec('CreateGroup("ContactNXNastran_1_Manual_Face_M", [6:24], 0:0)')
JPT.Exec('CreateGroup("ContactNXNastran_1_Manual_Face_S", [6:49], 0:0)')
JPT.Exec('ContactNXNastran("ContactNXNastran_1", 0, 0, 10, 1, 0.01, 10, 20, 0.02, 100, 0, 0, 0, 0, 1, 0, 0.01, 0, 10, 1, 0, [79:1-79:2], 0:0, 16711680, 0)')
JPT.Exec('END_TRANSACTION()')
JPT.Exec('BEGIN_TRANSACTION("Add Lbc Contact.")')
JPT.Exec('CreateGroup("ContactNXNastran_2_Manual_Face_M", [6:50], 0:0)')
JPT.Exec('CreateGroup("ContactNXNastran_2_Manual_Face_S", [6:75], 0:0)')
JPT.Exec('ContactNXNastran("ContactNXNastran_2", 0, 0, 10, 1, 0.01, 10, 20, 0.02, 100, 0, 0, 0, 0, 1, 0, 0.01, 0, 10, 1, 0, [79:3-79:4], 0:0, 16711680, 0)')
JPT.Exec('END_TRANSACTION()')
JPT.ViewFitToModel()

def on_click_set_info_cell(dlg):
    """
    Executes to get Contact information, returns and sets Contact Name/ID to table cell
        Parameters:
            dlg: Dialog
        Returns:
            Sets Name of Contact to the first column (col=0)
            Sets ID of Contact to the second column (col=1)
    """
    JPT.ClearLog()
    total_contact = JPT.GetCountByType(JPT.DItemType.CONTACT_NXNASTRAN)
    for i in range(total_contact):
        contact_dict = JPT.GetAssemblyEntityData(JPT.DItemType.CONTACT_NXNASTRAN,i+1)
        dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=0,value=contact_dict["Contact"]["Name"])
        dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=1,value=contact_dict["Contact"]["ID"])
        dlg.set_table_column_width(name="Table1",col=0,width=120)

def associated_part(selection):
    """
    Gets the associated Parts that Contact Face belongs to, returns and sets transparency for those associated Parts
        Parameters:
            selection(list): All selected Faces vector
        Returns:
            Sets transparency to be 10% for the associated Parts that Contact Face belongs to
    """
    all_bodies = JPT.GetAllParts()
    for i in range(all_bodies.sizeVec()):
        all_bodies[i].transparency = 100
    for face in selection:
        part = JPT.GetEntitiesByAssociation(JPT.DItemType.FACE, JPT.AssociateType.AS_BODY, face.id)
        JPT.SelectionByID(JPT.DItemType.BODY, part[0].id, JPT.BoolType.TRUE_VAL)
    selected_bodies = JPT.GetSelectedParts()
    for i in range(selected_bodies.sizeVec()):
        selected_bodies[i].transparency = 10
    JPT.ClearAllSelection()

def select_face_in_contact_by_name(contact_name, contact_id):
    """
    Gets Contact's Name from the cell, returns the Face entity of Contact
        Parameters:
            contact_name(string): Name of the Contact in the first column of the table (col=0)
            contact_id(string): ID of the Contact in the second column of the table (col=1)
        Returns:
            Selects all Face entities of Contact
    """
    contact = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_CONTACT, contact_name, 1)
    for c in JPT.GetAllByTypeID(JPT.DItemType.CONTACT_NXNASTRAN):
        JPT.UpdateCheckboxAssembly(JPT.DItemType.CONTACT_NXNASTRAN, c.id, 0)
        JPT.UpdateCheckboxAssembly(JPT.DItemType.CONTACT_NXNASTRAN, contact[0].id, 1)
    if contact.sizeVec() > 0:
        if contact[0].masters.sizeVec()>0 and contact[0].slaves.sizeVec() > 0:
            for entity_m, entity_s in zip(contact[0].masters, contact[0].slaves):
                JPT.SelectionByID(JPT.DItemType.FACE, entity_m.targets[0].id, JPT.BoolType.TRUE_VAL)
                JPT.SelectionByID(JPT.DItemType.FACE, entity_s.targets[0].id, JPT.BoolType.TRUE_VAL)
    associated_part(JPT.GetAllSelected())

def select_face_in_contact_by_id(contact_id):
    """
    Gets Contact's ID from the cell, returns the Face entity of Contact
        Parameters:
            contact_id(int): ID of the Contact in the second column of the table (col=1)
        Returns:
            Selects all Face entities of Contact
    """
    contact = JPT.GetEntitiesByID(JPT.DItemType.CONTACT_NXNASTRAN,int(contact_id)) #Contact NXNastran
    for c in JPT.GetAllByTypeID(JPT.DItemType.CONTACT_NXNASTRAN):
        JPT.UpdateCheckboxAssembly(JPT.DItemType.CONTACT_NXNASTRAN, c.id, 0)
        JPT.UpdateCheckboxAssembly(JPT.DItemType.CONTACT_NXNASTRAN, contact[0].id, 1)
    if contact.sizeVec() > 0:
        if contact[0].masters.sizeVec()>0 and contact[0].slaves.sizeVec() > 0:
            for entity_m, entity_s in zip(contact[0].masters, contact[0].slaves):
                JPT.SelectionByID(JPT.DItemType.FACE, entity_m.targets[0].id, JPT.BoolType.TRUE_VAL)
                JPT.SelectionByID(JPT.DItemType.FACE, entity_s.targets[0].id, JPT.BoolType.TRUE_VAL)
    associated_part(JPT.GetAllSelected())

def on_sel_change(dlg,name,target_cell):
    """
    Takes the value of cell, returns the View and highlight the Contact Faces
        Parameters:
            dlg: Dialog
            name(string): Name of the Table
            target_cell(object): TableCellID object specifying the location of cell in table
        Returns:
            Sets View that shows the target Face
        Note:
            This function calls the 2 functions: select_face_in_contact_by_name & select_face_in_contact_by_id
    """
    JPT.ClearAllSelection()
    target_cell = dlg.get_table_sel_cell(name="Table1")
    target_name = dlg.get_cell_value(name="Table1",cell_row_id=target_cell[0].row_number,cell_column_id=target_cell[0].col_number)
    target_id = dlg.get_cell_value(name="Table1",cell_row_id=target_cell[0].row_number,cell_column_id=target_cell[0].col_number)
    target_id_s = dlg.get_cell_value(name="Table1",cell_row_id=target_cell[0].row_number,cell_column_id=1)
    if target_cell[0].col_number==0:
        select_face_in_contact_by_name(target_name, target_id_s)
    elif target_cell[0].col_number==1:
        select_face_in_contact_by_id(target_id)
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

# Encoding for Japanese
# coding: cp932

from pyjdg import *

JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('CreateCube([0.01, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_2", 6409934, 0:0)')
JPT.Exec('CreateCube([0.02, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_3", 13259210, 0:0)')
JPT.Exec('BEGIN_TRANSACTION("Add Lbc Contact.")')
JPT.Exec('CreateGroup("ContactNXNastran_1_Manual_Face_M", [6:24], 0:0)')
JPT.Exec('CreateGroup("ContactNXNastran_1_Manual_Face_S", [6:49], 0:0)')
JPT.Exec('ContactNXNastran("ContactNXNastran_1", 0, 0, 10, 1, 0.01, 10, 20, 0.02, 100, 0, 0, 0, 0, 1, 0, 0.01, 0, 10, 1, 0, [79:1-79:2], 0:0, 16711680, 0)')
JPT.Exec('END_TRANSACTION()')
JPT.Exec('BEGIN_TRANSACTION("Add Lbc Contact.")')
JPT.Exec('CreateGroup("ContactNXNastran_2_Manual_Face_M", [6:50], 0:0)')
JPT.Exec('CreateGroup("ContactNXNastran_2_Manual_Face_S", [6:75], 0:0)')
JPT.Exec('ContactNXNastran("ContactNXNastran_2", 0, 0, 10, 1, 0.01, 10, 20, 0.02, 100, 0, 0, 0, 0, 1, 0, 0.01, 0, 10, 1, 0, [79:3-79:4], 0:0, 16711680, 0)')
JPT.Exec('END_TRANSACTION()')
JPT.ViewFitToModel()

def on_click_set_info_cell(dlg):
    """
    Executes to get Contact information, returns and sets Contact Name/ID to table cell
        Parameters:
            dlg: Dialog
        Returns:
            Sets Name of Contact to the first column (col=0)
            Sets ID of Contact to the second column (col=1)
    """
    JPT.ClearLog()
    total_contact = JPT.GetCountByType(JPT.DItemType.CONTACT_NXNASTRAN)
    for i in range(total_contact):
        contact_dict = JPT.GetAssemblyEntityData(JPT.DItemType.CONTACT_NXNASTRAN,i+1)
        dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=0,value=contact_dict["接触"]["名前"])
        dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=1,value=contact_dict["接触"]["ID"])
        dlg.set_table_column_width(name="Table1",col=0,width=120)

def associated_part(selection):
    """
    Gets the associated Parts that Contact Face belongs to, returns and sets transparency for those associated Parts
        Parameters:
            selection(list): All selected Faces vector
        Returns:
            Sets transparency to be 10% for the associated Parts that Contact Face belongs to
    """
    all_bodies = JPT.GetAllParts()
    for i in range(all_bodies.sizeVec()):
        all_bodies[i].transparency = 100
    for face in selection:
        part = JPT.GetEntitiesByAssociation(JPT.DItemType.FACE, JPT.AssociateType.AS_BODY, face.id)
        JPT.SelectionByID(JPT.DItemType.BODY, part[0].id, JPT.BoolType.TRUE_VAL)
    selected_bodies = JPT.GetSelectedParts()
    for i in range(selected_bodies.sizeVec()):
        selected_bodies[i].transparency = 10
    JPT.ClearAllSelection()

def select_face_in_contact_by_name(contact_name, contact_id):
    """
    Gets Contact's Name from the cell, returns the Face entity of Contact
        Parameters:
            contact_name(string): Name of the Contact in the first column of the table (col=0)
            contact_id(string): ID of the Contact in the second column of the table (col=1)
        Returns:
            Selects all Face entities of Contact
    """
    contact = JPT.GetEntitiesByName(JPT.DTableType.DTABLE_CONTACT, contact_name, 1)
    for c in JPT.GetAllByTypeID(JPT.DItemType.CONTACT_NXNASTRAN):
        JPT.UpdateCheckboxAssembly(JPT.DItemType.CONTACT_NXNASTRAN, c.id, 0)
        JPT.UpdateCheckboxAssembly(JPT.DItemType.CONTACT_NXNASTRAN, contact[0].id, 1)
    if contact.sizeVec() > 0:
        if contact[0].masters.sizeVec()>0 and contact[0].slaves.sizeVec() > 0:
            for entity_m, entity_s in zip(contact[0].masters, contact[0].slaves):
                JPT.SelectionByID(JPT.DItemType.FACE, entity_m.targets[0].id, JPT.BoolType.TRUE_VAL)
                JPT.SelectionByID(JPT.DItemType.FACE, entity_s.targets[0].id, JPT.BoolType.TRUE_VAL)
    associated_part(JPT.GetAllSelected())

def select_face_in_contact_by_id(contact_id):
    """
    Gets Contact's ID from the cell, returns the Face entity of Contact
        Parameters:
            contact_id(int): ID of the Contact in the second column of the table (col=1)
        Returns:
            Selects all Face entities of Contact
    """
    contact = JPT.GetEntitiesByID(JPT.DItemType.CONTACT_NXNASTRAN,int(contact_id)) #Contact NXNastran
    for c in JPT.GetAllByTypeID(JPT.DItemType.CONTACT_NXNASTRAN):
        JPT.UpdateCheckboxAssembly(JPT.DItemType.CONTACT_NXNASTRAN, c.id, 0)
        JPT.UpdateCheckboxAssembly(JPT.DItemType.CONTACT_NXNASTRAN, contact[0].id, 1)
    if contact.sizeVec() > 0:
        if contact[0].masters.sizeVec()>0 and contact[0].slaves.sizeVec() > 0:
            for entity_m, entity_s in zip(contact[0].masters, contact[0].slaves):
                JPT.SelectionByID(JPT.DItemType.FACE, entity_m.targets[0].id, JPT.BoolType.TRUE_VAL)
                JPT.SelectionByID(JPT.DItemType.FACE, entity_s.targets[0].id, JPT.BoolType.TRUE_VAL)
    associated_part(JPT.GetAllSelected())

def on_sel_change(dlg,name,target_cell):
    """
    Takes the value of cell, returns the View and highlight the Contact Faces
        Parameters:
            dlg: Dialog
            name(string): Name of the Table
            target_cell(object): TableCellID object specifying the location of cell in table
        Returns:
            Sets View that shows the target Face
        Note:
            This function calls the 2 functions: select_face_in_contact_by_name & select_face_in_contact_by_id
    """
    JPT.ClearAllSelection()
    target_cell = dlg.get_table_sel_cell(name="Table1")
    target_name = dlg.get_cell_value(name="Table1",cell_row_id=target_cell[0].row_number,cell_column_id=target_cell[0].col_number)
    target_id = dlg.get_cell_value(name="Table1",cell_row_id=target_cell[0].row_number,cell_column_id=target_cell[0].col_number)
    target_id_s = dlg.get_cell_value(name="Table1",cell_row_id=target_cell[0].row_number,cell_column_id=1)
    if target_cell[0].col_number==0:
        select_face_in_contact_by_name(target_name, target_id_s)
    elif target_cell[0].col_number==1:
        select_face_in_contact_by_id(target_id)
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
