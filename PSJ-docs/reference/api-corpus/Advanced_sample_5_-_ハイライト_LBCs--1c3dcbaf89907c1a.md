# Advanced sample 5 - ハイライト LBCs

Advanced sample 5 - ハイライト LBCs

🎯 イントロダクション​

このチュートリアルでは、テーブルを使用してモデル内のLBCsをハイライトする方法について学びます：

モデルからLBCsを取得し、部品名、部品ID、Load＆BC、Load＆BC ID、テーブルLBCタイプをテーブルに入力します。

部品名または部品IDを選択すると、JPTが選択した部品をハイライトし、他の部品の透明度を設定します。

Loadを選択すると、JPTがLBCの情報と関連部品を取得し、LBCをハイライトします。

📖 チュートリアル​

# 日本語のエンコーディング
# coding: cp932

from pyjdg import *

# キューブ部品と荷重を生成
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('CreateCube([0.02, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_2", 6409934, 0:0)')
JPT.Exec('CreateCube([0, 0.02, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_3", 13259210, 0:0)')
JPT.Exec('PressureGeneral("Pressure2", 1e+08, 0, 0:0, 0, 0, 0:0, "", 0:0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], "", "", "", 1, [6:52], 0:0)')
JPT.Exec('ForceGeneral("Force2", [-100, 1.7976931e+308, 1.7976931e+308], [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], 0, 0, 0:0, 0:0, 0:0, 0, 0, 0:0, "", "", "", "", "", "", [6:23], 0:0)')
JPT.Exec('FixedConstraint("Constraint1", 7, 0:0, 0, 0, 0:0, 0, [6:77], 0:0)')
JPT.Exec('BoundaryTemperature("BoundaryTemperature_1", 293.15, 0:0, [6:78], 0:0)')
JPT.ViewFitToModel()

def select_LBC_by_name(dlg, name, target_cell):
    '''
    選択されたセルの情報を取得し、選択の種類に基づいてビューを返します。
        Parameters:
            dlg: ダイアログ
            name(string): テーブル1の名前
            target_cell(object): テーブル内のセル位置を指定するTableCellIDオブジェクト
        Returns:
            ターゲットLBC/部品を表示するビューを設定します。
        Note:
            この関数はshow_selected_LBC()およびshow_selected_part()の2つの関数を呼び出します。
    '''
    JPT.ClearAllSelection()
    JPT.ClearLog()
    table_cell = dlg.get_table_sel_cell(name="Table1")
    if table_cell[0].col_number == 2:
        id_cell = dlg.get_cell_value(name="Table1", row=table_cell[0].row_number, col=table_cell[0].col_number + 1)
        lbc_type_id_cell = dlg.get_cell_value(name="Table1", row=table_cell[0].row_number, col=table_cell[0].col_number + 2)
        show_selected_LBC(id_cell, lbc_type_id_cell)
    elif table_cell[0].col_number == 3:
        id_cell = dlg.get_cell_value(name="Table1", row=table_cell[0].row_number, col=table_cell[0].col_number)
        lbc_type_id_cell = dlg.get_cell_value(name="Table1", row=table_cell[0].row_number, col=table_cell[0].col_number + 1)
        show_selected_LBC(id_cell, lbc_type_id_cell)
    elif table_cell[0].col_number == 4:
        id_cell = dlg.get_cell_value(name="Table1", row=table_cell[0].row_number, col=table_cell[0].col_number - 1)
        lbc_type_id_cell = dlg.get_cell_value(name="Table1", row=table_cell[0].row_number, col=table_cell[0].col_number)
        show_selected_LBC(int(id_cell), lbc_type_id_cell)
    elif table_cell[0].col_number == 0:
        value_cell = dlg.get_cell_value(name="Table1", row=table_cell[0].row_number, col=table_cell[0].col_number + 1)
        show_selected_part(value_cell)
    elif table_cell[0].col_number == 1:
        value_cell = dlg.get_cell_value(name="Table1", row=table_cell[0].row_number, col=table_cell[0].col_number)
        show_selected_part(value_cell)

def show_all_LBC(dlg):
    '''
    部品とLBCの通常状態/ビューを設定します。
    すべてのLBCを表示します。
        Parameters:
            None
        Returns:
            すべての部品の透明度を通常に設定します。
            すべてのLBCを表示します。
    '''
    for lbc in JPT.GetAllLoadsBCs():
        JPT.ShowHideEntitiesByID(lbc.tableID, lbc.id, JPT.BoolType.TRUE_VAL)
    for body in JPT.GetAllParts():
        body.transparency = 100
    JPT.ViewFitToModel()

def show_selected_part(partid):
    '''
    選択された部品を取得し、選択された部品のハイライトビューを返します。
        Parameters:
            partid: 選択された部品のID
        Returns:
            選択された部品のビューをフィットさせ、他の部品の透明度を10%に設定します。
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

def show_selected_LBC(LBCid, LBCTabletypeid):
    '''
    選択されたLBC/LBCTableのIDを取得し、選択されたLBCのハイライトビューを返します。
        Parameters:
            LBCid: 選択されたLBCのID
            LBCTabletypeid: 選択されたLBCのテーブルID
        Returns:
            選択されたLBCのみを表示し、他のLBCはオフにします。
    '''
    for body in JPT.GetAllParts():
        body.transparency = 100
    for lbc in JPT.GetAllLoadsBCs():
        JPT.ShowHideEntitiesByID(lbc.tableID, lbc.id, JPT.BoolType.FALSE_VAL)
    JPT.ShowHideEntitiesByID(int(LBCTabletypeid), int(LBCid), JPT.BoolType.TRUE_VAL)
    JPT.ViewFitToModel()

def on_click_set_info_cell(dlg):
    '''
    部品の情報を取得し、テーブルにLBC名と部品名を入力します。
        Parameters:
            dlg: ダイアログ
        Returns:
            部品/LBCの情報をテーブルセルに入力します。
    '''
    listFace = []
    listPart = []
    JPT.ClearLog()
    listLBCs = JPT.GetAllLoadsBCs()
    for i in range(listLBCs.sizeVec()):
        lbc = listLBCs[i]
        listFace.append(lbc.targets[0].id)
        dlg.set_cell_value(name="Table1", row=i, col=2, value=lbc.name)
        dlg.set_cell_value(name="Table1", row=i, col=3, value=str(lbc.id))
        dlg.set_cell_value(name="Table1", row=i, col=4, value=str(lbc.tableID))

    for i in range(len(listFace)):
        part = JPT.GetEntitiesByAssociation(JPT.DItemType.FACE, JPT.AssociateType.AS_BODY, int(listFace[i]))
        dlg.set_cell_value(name="Table1", row=i, col=0, value=part[0].name)
        dlg.set_cell_value(name="Table1", row=i, col=1, value=str(part[0].id))

def main():
    dlg = JDGCreator(title="Dialog", resizable=True, validation=True)
    dlg.add_table(name="Table1", rows=4,
        columns=["Name", "ID", "Load", "LBC ID", "TABLE LBC TYPE ID"],
        layout="Window", menus=["clear"], width=560, height=260)
    dlg.add_hlayout(name="footer", layout="Window")
    dlg.add_label(name="Label2", text="1. Applyボタンを選択します", layout="Window")
    dlg.add_label(name="Label3", text="2. セルを選択してイベントをトリガーします", layout="Window")
    dlg.add_label(name="Label4", text="3. Show All LBCsを選択して、部品/LBCsの通常ビューを設定します", layout="Window")
    dlg.add_space(orientation="horizontal", layout="footer")
    dlg.add_button(name="ButtonApply", text="Apply", layout="footer")
    dlg.add_button(name="ButtonShowAllLBC", height=30, text="Show All LBCs", layout="footer")
    dlg.add_button(name="ButtonOk", text="Ok", layout="footer")
    dlg.add_button(name="ButtonCancel", text="Cancel", layout="footer")
    dlg.add_space(orientation="horizontal", layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="ButtonApply", callfunc=on_click_set_info_cell)
    dlg.on_button_clicked(name="ButtonShowAllLBC", callfunc=show_all_LBC)
    dlg.on_table_sel_changed(name="Table1", callfunc=select_LBC_by_name)

if __name__ == '__main__':
    main()
