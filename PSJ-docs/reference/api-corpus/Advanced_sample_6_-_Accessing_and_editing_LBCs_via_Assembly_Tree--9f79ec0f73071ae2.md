# Advanced sample 6 - Accessing and editing LBCs via Assembly Tree

Advanced sample 6 - Accessing and editing LBCs via Assembly Tree

🎯 Introduction​

In this tutorial, you'll learn how to access/edit LBCs in Assembly Tree with table:

Get LBCs from model and fill LBCs names, IDs and its components value into table.

Gets value from user input and pass to macro to execute changes.

Please note that displaying language will affect to the returned value of JPT.GetAssemblyEntityData().

The sample is using English language, for other languages, please pass the appropriate character string.

📖 Tutorial​

English

Japanese

# Encoding for Japanese
# coding: cp932

from pyjdg import *

#Generate the Cube Parts and Force/Pressure/TemperatureBoundary
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('ForceGeneral("Force2", [-100, 1.7976931e+308, 1.7976931e+308], [1.7976931e+308, 1.7976931e+308, 1.7976931e+308],\
    0, 0, 0:0, 0:0, 0:0, 0, 0, 0:0, "", "", "", "", "", "", [6:23], 0:0)')
JPT.Exec('PressureGeneral("Pressure1", 1e+08, 0, 0:0, 0, 0, 0:0, "", 0:0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308],\
    "", "", "", 1, [6:24], 0:0)')
JPT.Exec('BoundaryTemperature("BoundaryTemperature_1", 373.15, 0:0, [6:26], 0:0)')
JPT.ViewFitToModel()

def on_button_update(dlg):
    '''
    Gets value of Force/Pressure/TemperatureBoundary components, returns the macro to edit Force/Pressure/TemperatureBoundary item
        Parameters:
            dlg: Dialog
        Returns:
            Returns the macro to edit Force/Pressure/TemperatureBoundary item
    '''
    JPT.ClearLog()
    Force_X = dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=2)
    Force_Y = dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=3)
    Force_Z = dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=4)
    Moment_X = dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=5)
    Moment_Y = dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=6)
    Moment_Z = dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=7)
    Pressure_value = dlg.get_cell_value(name="Table1",cell_row_id=1,cell_column_id=8)
    Temp_value = dlg.get_cell_value(name="Table1",cell_row_id=2,cell_column_id=9)
    Force_X = 0 if not Force_X else dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=2)
    Force_Y = 0 if not Force_Y else dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=3)
    Force_Z = 0 if not Force_Z else dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=4)
    Moment_X = 0 if not Moment_X else 0.001*float(dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=5))
    Moment_Y = 0 if not Moment_Y else 0.001*float(dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=6))
    Moment_Z = 0 if not Moment_Z else 0.001*float(dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=7))
    Pressure_value = 0 if not Pressure_value else float(dlg.get_cell_value(name="Table1",cell_row_id=1,cell_column_id=8))*pow(10,6)
    Temp_value = 0 if not Temp_value else float(dlg.get_cell_value(name="Table1",cell_row_id=2,cell_column_id=9))
    JPT.Exec('ForceGeneral("Force2", [{}, {}, {}], [{}, {}, {}], 0, 0, 0:0, 0:0, 0:0, 0, 0, 0:0, "", "", "", "", "", "", [6:23], 29:1)'
        .format(Force_X,Force_Y,Force_Z,Moment_X,Moment_Y,Moment_Z))
    JPT.Exec('PressureGeneral("Pressure1", {}, 0, 0:0, 0, 0, 0:0, "", 0:0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], "", "", "", 1, [6:24], 40:2)'
        .format(Pressure_value))
    JPT.Exec('BoundaryTemperature("BoundaryTemperature_1", {}, 0:0, [6:26], 53:1)'
        .format(JPT.ConvertFromDocUnit(Temp_value, JPT.UnitType.Unit_Temperature)))
    JPT.ClearLog()

def on_click_set_info_cell(dlg):
    '''
    Gets information of Force/Pressure/TemperatureBoundary, returns Force/Pressure/TemperatureBoundary Name,ID and its components and fill into table cell
        Parameters:
            dlg: Dialog
        Returns:
            Fills information of Force/Pressure/TemperatureBoundary into table cell
    '''
    JPT.ClearLog()
    ForceDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_FORCE,1)
    PressureDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_G_PRESSURE,2)
    TempDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_TEMP_BOUNDARY,1)
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=0,value=ForceDict["Force"]["Name"])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=1,value=ForceDict["Force"]["ID"])
    dlg.set_cell_value(name="Table1",cell_row_id=1,cell_column_id=0,value=PressureDict["Pressure"]["Name"])
    dlg.set_cell_value(name="Table1",cell_row_id=1,cell_column_id=1,value=PressureDict["Pressure"]["ID"])
    dlg.set_cell_value(name="Table1",cell_row_id=2,cell_column_id=0,value=TempDict["Boundary Temperature"]["Name"])
    dlg.set_cell_value(name="Table1",cell_row_id=2,cell_column_id=1,value=TempDict["Boundary Temperature"]["ID"])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=2,value=ForceDict["Force"]["Forces"]["Force X"].rsplit("N")[0])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=3,value=ForceDict["Force"]["Forces"]["Force Y"].rsplit("N")[0])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=4,value=ForceDict["Force"]["Forces"]["Force Z"].rsplit("N")[0])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=5,value=ForceDict["Force"]["Moments"]["Moment X"].rsplit("N*mm")[0])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=6,value=ForceDict["Force"]["Moments"]["Moment Y"].rsplit("N*mm")[0])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=7,value=ForceDict["Force"]["Moments"]["Moment Z"].rsplit("N*mm")[0])
    dlg.set_cell_value(name="Table1",cell_row_id=1,cell_column_id=8,value=PressureDict["Pressure"]["Value"].rsplit("MPa")[0])
    Temperature_value = TempDict["Boundary Temperature"]["Temperature"]
    dlg.set_cell_value(name="Table1",cell_row_id=2,cell_column_id=9,value=Temperature_value.rsplit("K")[0] if Temperature_value[-1] == "K" else Temperature_value.rsplit("deg C")[0])

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",menus=["clear"],width=1050,height=100,columns=["Load","ID","Force X (N)","Force Y (N)","Force Z (N)","Moment X (N*mm)","Moment Y (N*mm)","Moment Z (N*mm)","Pressure Value","Temperature Value"],rows=3,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_label(name="Label2",text="1. Select the Get Info button to get information of load",layout="Window")
    dlg.add_label(name="Label3",text="2. Input cell value to set Force",layout="Window")
    dlg.add_label(name="Label4",text="3. Select the Update button to update new Force",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonGetInfo",text="Get Info",width=80,height=30,layout="footer")
    dlg.add_button(name="ButtonUpdate",text="Update",width=80,height=30,layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="ButtonGetInfo",callfunc=on_click_set_info_cell)
    dlg.on_button_clicked(name="ButtonUpdate",callfunc=on_button_update)

if __name__=='__main__':
    main()

# Encoding for Japanese
# coding: cp932

from pyjdg import *

#Generate the Cube Parts and Force/Pressure/TemperatureBoundary
JPT.Exec('CreateCube([0, 0, 0], [0.01, 0.01, 0.01], [10, 10, 10], "Cube_1", 7105764, 0:0)')
JPT.Exec('ForceGeneral("Force2", [-100, 1.7976931e+308, 1.7976931e+308], [1.7976931e+308, 1.7976931e+308, 1.7976931e+308],\
    0, 0, 0:0, 0:0, 0:0, 0, 0, 0:0, "", "", "", "", "", "", [6:23], 0:0)')
JPT.Exec('PressureGeneral("Pressure1", 1e+08, 0, 0:0, 0, 0, 0:0, "", 0:0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308],\
    "", "", "", 1, [6:24], 0:0)')
JPT.Exec('BoundaryTemperature("BoundaryTemperature_1", 373.15, 0:0, [6:26], 0:0)')
JPT.ViewFitToModel()

def on_button_update(dlg):
    '''
    Gets value of Force/Pressure/TemperatureBoundary components, returns the macro to edit Force/Pressure/TemperatureBoundary item
        Parameters:
            dlg: Dialog
        Returns:
            Returns the macro to edit Force/Pressure/TemperatureBoundary item
    '''
    JPT.ClearLog()
    Force_X = dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=2)
    Force_Y = dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=3)
    Force_Z = dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=4)
    Moment_X = dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=5)
    Moment_Y = dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=6)
    Moment_Z = dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=7)
    Pressure_value = dlg.get_cell_value(name="Table1",cell_row_id=1,cell_column_id=8)
    Temp_value = dlg.get_cell_value(name="Table1",cell_row_id=2,cell_column_id=9)
    Force_X = 0 if not Force_X else dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=2)
    Force_Y = 0 if not Force_Y else dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=3)
    Force_Z = 0 if not Force_Z else dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=4)
    Moment_X = 0 if not Moment_X else 0.001*float(dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=5))
    Moment_Y = 0 if not Moment_Y else 0.001*float(dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=6))
    Moment_Z = 0 if not Moment_Z else 0.001*float(dlg.get_cell_value(name="Table1",cell_row_id=0,cell_column_id=7))
    Pressure_value = 0 if not Pressure_value else float(dlg.get_cell_value(name="Table1",cell_row_id=1,cell_column_id=8))*pow(10,6)
    Temp_value = 0 if not Temp_value else float(dlg.get_cell_value(name="Table1",cell_row_id=2,cell_column_id=9))
    JPT.Exec('ForceGeneral("Force2", [{}, {}, {}], [{}, {}, {}], 0, 0, 0:0, 0:0, 0:0, 0, 0, 0:0, "", "", "", "", "", "", [6:23], 29:1)'
        .format(Force_X,Force_Y,Force_Z,Moment_X,Moment_Y,Moment_Z))
    JPT.Exec('PressureGeneral("Pressure1", {}, 0, 0:0, 0, 0, 0:0, "", 0:0, [1.7976931e+308, 1.7976931e+308, 1.7976931e+308], "", "", "", 1, [6:24], 40:2)'
        .format(Pressure_value))
    JPT.Exec('BoundaryTemperature("BoundaryTemperature_1", {}, 0:0, [6:26], 53:1)'
        .format(JPT.ConvertFromDocUnit(Temp_value, JPT.UnitType.Unit_Temperature)))
    JPT.ClearLog()

def on_click_set_info_cell(dlg):
    '''
    Gets information of Force/Pressure/TemperatureBoundary, returns Force/Pressure/TemperatureBoundary Name,ID and its components and fill into table cell
        Parameters:
            dlg: Dialog
        Returns:
            Fills information of Force/Pressure/TemperatureBoundary into table cell
    '''
    JPT.ClearLog()
    ForceDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_FORCE,1)
    PressureDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_G_PRESSURE,2)
    TempDict = JPT.GetAssemblyEntityData(JPT.DItemType.LBC_TEMP_BOUNDARY,1)
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=0,value=ForceDict["力"]["名前"])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=1,value=ForceDict["力"]["ID"])
    dlg.set_cell_value(name="Table1",cell_row_id=1,cell_column_id=0,value=PressureDict["圧力"]["名前"])
    dlg.set_cell_value(name="Table1",cell_row_id=1,cell_column_id=1,value=PressureDict["圧力"]["ID"])
    dlg.set_cell_value(name="Table1",cell_row_id=2,cell_column_id=0,value=TempDict["温度境界"]["名前"])
    dlg.set_cell_value(name="Table1",cell_row_id=2,cell_column_id=1,value=TempDict["温度境界"]["ID"])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=2,value=ForceDict["力"]["力"]["荷重 X"].rsplit("N")[0])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=3,value=ForceDict["力"]["力"]["荷重 Y"].rsplit("N")[0])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=4,value=ForceDict["力"]["力"]["荷重 Z"].rsplit("N")[0])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=5,value=ForceDict["力"]["モーメント"]["モーメント X"].rsplit("N*mm")[0])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=6,value=ForceDict["力"]["モーメント"]["モーメント Y"].rsplit("N*mm")[0])
    dlg.set_cell_value(name="Table1",cell_row_id=0,cell_column_id=7,value=ForceDict["力"]["モーメント"]["モーメント Z"].rsplit("N*mm")[0])
    dlg.set_cell_value(name="Table1",cell_row_id=1,cell_column_id=8,value=PressureDict["圧力"]["値"].rsplit("MPa")[0])
    Temperature_value = TempDict["温度境界"]["温度"]
    dlg.set_cell_value(name="Table1",cell_row_id=2,cell_column_id=9,value=Temperature_value.rsplit("K")[0] if Temperature_value[-1] == "K" else Temperature_value.rsplit("deg C")[0])

def main():
    dlg=JDGCreator(title="Dialog",resizable=True,validation=True)
    dlg.add_table(name="Table1",menus=["clear"],width=1050,height=100,columns=["Load","ID","Force X (N)","Force Y (N)","Force Z (N)","Moment X (N*mm)","Moment Y (N*mm)","Moment Z (N*mm)","Pressure Value","Temperature Value"],rows=3,layout="Window")
    dlg.add_hlayout(name="footer",layout="Window")
    dlg.add_label(name="Label2",text="1. Select the Get Info button to get information of load",layout="Window")
    dlg.add_label(name="Label3",text="2. Input cell value to set Force",layout="Window")
    dlg.add_label(name="Label4",text="3. Select the Update button to update new Force",layout="Window")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.add_button(name="ButtonGetInfo",text="Get Info",width=80,height=30,layout="footer")
    dlg.add_button(name="ButtonUpdate",text="Update",width=80,height=30,layout="footer")
    dlg.add_button(name="ButtonOk",text="Ok",layout="footer")
    dlg.add_button(name="ButtonCancel",text="Cancel",layout="footer")
    dlg.add_space(orientation="horizontal",layout="footer")
    dlg.generate_window()
    dlg.on_button_clicked(name="ButtonGetInfo",callfunc=on_click_set_info_cell)
    dlg.on_button_clicked(name="ButtonUpdate",callfunc=on_button_update)

if __name__=='__main__':
    main()
