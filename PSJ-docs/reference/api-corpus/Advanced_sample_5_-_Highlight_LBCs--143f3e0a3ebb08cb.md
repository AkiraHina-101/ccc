# Advanced sample 5 - Highlight LBCs

Advanced sample 5 - Highlight LBCs

🎯 Introduction​

In this tutorial, you'll learn how a table highlight LBCs in model:

Get LBCs from model and fill part names, part IDs, Load&BC, Load&BC IDs, Table LBC Type into table.

If selects part name/part ID, JPT highlights the selected parts by setting transparency other parts.

If selects Load, JPT gets information of LBC and associated part, then highlights the LBC.

📖 Tutorial​

# Encoding for Japanese
# coding: cp932

from pyjdg import *

#Generate the Cube Parts and Loads
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('CreateCube([0.02, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_2", 6409934, 0:0)')
JPT.Exec('CreateCube([0, 0.02, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_3", 13259210, 0:0)')
JPT.Exec('PressureGeneral("Pressure2", 1e+08, 0, 0:0, 0, 0, 0:0, "", 0:0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], "", "", "", 1, [6:52], 0:0)')
JPT.Exec('ForceGeneral("Force2", [-100, 1.7976931e+308, 1.7976931e+308], [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 0, 0, 0:0, 0:0, 0:0, 0, 0, 0:0, "", "", "", "", "", "", [6:23], 0:0)')
JPT.Exec('FixedConstraint("Constraint1", 7, 0:0, 0, 0, 0:0, 0, [6:77], 0:0)')
JPT.Exec('BoundaryTemperature("BoundaryTemperature_1", 293.15, 0:0, [6:78], 0:0)')
JPT.ViewFitToModel()

def select_LBC_by_name(dlg,name,target_cell):
    '''
    Gets information of selected cell, returns the view based on the type of selection
        Parameters:
            dlg: Dialog
            name(string): Name of the Table1
            target_cell(object): TableCellID object specifying the location of cell in table
        Returns:
            Sets View that shows the target LBC/Part
        Note:
            This function calls the 2 functions: show_selected_LBC() & show_selected_part()
    '''
    JPT.ClearAllSelection()
    JPT.ClearLog()
    table_cell = dlg.get_table_sel_cell(name="Table1")
    if table_cell[0].col_number == 2:
        id_cell = dlg.get_cell_value(name="Table1",cell_row_id=table_cell[0].row_number,cell_column_id=table_cell[0].col_number+1)
        lbc_type_id_cell = dlg.get_cell_value(name="Table1",cell_row_id=table_cell[0].row_number,cell_column_id=table_cell[0].col_number+2)
        show_selected_LBC(id_cell,lbc_type_id_cell)
    elif table_cell[0].col_number == 3:
        id_cell = dlg.get_cell_value(name="Table1",cell_row_id=table_cell[0].row_number,cell_column_id=table_cell[0].col_number)
        lbc_type_id_cell = dlg.get_cell_value(name="Table1",cell_row_id=table_cell[0].row_number,cell_column_id=table_cell[0].col_number+1)
        show_selected_LBC(id_cell,lbc_type_id_cell)
    elif table_cell[0].col_number == 4:
        id_cell = dlg.get_cell_value(name="Table1",cell_row_id=table_cell[0].row_number,cell_column_id=table_cell[0].col_number-1)
        lbc_type_id_cell = dlg.get_cell_value(name="Table1",cell_row_id=table_cell[0].row_number,cell_column_id=table_cell[0].col_number)
        show_selected_LBC(int(id_cell),lbc_type_id_cell)
    elif table_cell[0].col_number == 0:
        value_cell = dlg.get_cell_value(name="Table1",cell_row_id=table_cell[0].row_number,cell_column_id=table_cell[0].col_number+1)
        show_selected_part(value_cell)
    elif table_cell[0].col_number == 1:
        value_cell = dlg.get_cell_value(name="Table1",cell_row_id=table_cell[0].row_number,cell_column_id=table_cell[0].col_number)
        show_selected_part(value_cell)

def show_all_LBC(dlg):
    '''
    Sets the normal state/view of Parts and LBCs
    Shows all LBCs
        Parameters:
            None
        Returns:
            Sets the transparency of all Parts to be normal
            Shows all LBCs
    '''
    for lbc in JPT.GetAllLoadsBCs():
        JPT.ShowHideEntitiesByID(lbc.tableID, lbc.id, JPT.BoolType.TRUE_VAL)
    for body in JPT.GetAllParts():
        body.transparency = 100
    JPT.ViewFitToModel()

def show_selected_part(partid):
    '''
    Gets the selected Part, returns the highlighted view of the selected Part
        Parameters:
            partid: ID of the selected Part
        Returns:
            Highlights/Sets the View to be fit with the selected Part
            Sets transparent to be 10% for the other Parts
    '''
    for lbc in JPT.GetAllLoadsBCs():
        JPT.ShowHideEntitiesByID(lbc.tableID, lbc.id, JPT.BoolType.FALSE_VAL)
    JPT.SelectionByID(JPT.DItemType.BODY, int(partid), JPT.BoolType.TRUE_VAL)
    selected_body = JPT.GetSelectedParts()
    for body in JPT.GetAllParts():
        if body.id == selected_body[0].id:
            body.transparency = 100
        elif body.id != partid:
            body.transparency = 10
    JPT.ViewFitToModel()

def show_selected_LBC(LBCid,LBCTabletypeid):
    '''
    Gets the selected id of LBC/LBCTable, returns the highlighted view of the selected LBC
        Parameters:
            LBCid: ID of the selected LBC
            LBCTabletypeid: ID of the table of the selected LBC
        Returns:
            Shows only the selected LBC
            Turns off other LBCs
    '''
    for body in JPT.GetAllParts():
        body.transparency = 100
    for lbc in JPT.GetAllLoadsBCs():
        JPT.ShowHideEntitiesByID(lbc.tableID, lbc.id, JPT.BoolType.FALSE_VAL)  #JPT.BoolType.TRUE/FALSE_VAL
    JPT.ShowHideEntitiesByID(int(LBCTabletypeid), int(LBCid), JPT.BoolType.TRUE_VAL)
    JPT.ViewFitToModel()

def on_click_set_info_cell(dlg):
    '''
    Gets information of Parts, returns LBC Name and Part Name and fill to the table
        Parameters:
            dlg: Dialog
        Returns:
            Fills information of Parts/LBCs into table cell
    '''
    listFace = []
    listPart = []
    JPT.ClearLog()
    listLBCs = JPT.GetAllLoadsBCs()
    for i in range(listLBCs.sizeVec()):
        lbc = listLBCs[i]
        listFace.append(lbc.targets[0].id)
        dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=2,value=lbc.name)
        dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=3,value=str(lbc.id))
        dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=4,value=str(lbc.tableID))

    for i in range(len(listFace)):
        part = JPT.GetEntitiesByAssociation(JPT.DItemType.FACE,JPT.AssociateType.AS_BODY, int(listFace[i]))
        dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=0,value=part[0].name)
        dlg.set_cell_value(name="Table1",cell_row_id=i,cell_column_id=1,value=str(part[0].id))

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",rows=4,
        columns=["Name","ID","Load","LBC ID","TABLE LBC TYPE ID"],
        layout="Window",menus=["clear"],width=560,height=260)
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_label(name="Label2",text="1. Select the Apply Button",layout="Window")
    dlg.add_label(name="Label3",text="2. Choose the cell to trigger event",layout="Window")
    dlg.add_label(name="Label4",text="3. Select Show All LBCs to set normal view of Parts/LBCs",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonApply",text="Apply",layout="footer")
    dlg.add_button(name="ButtonShowAllLBC",height=30,text="Show All LBCs",layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="ButtonApply",callfunc=on_click_set_info_cell)
    dlg.on_button_clicked(name="ButtonShowAllLBC",callfunc=show_all_LBC)
    dlg.on_table_sel_changed(name="Table1",callfunc=select_LBC_by_name)

if __name__=='__main__':
    main()
