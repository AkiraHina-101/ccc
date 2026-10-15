# MacroResultParser

MacroResultParser MacroResultParser Description Parse returned string from macro to list of string Inputs returned string from macro (string) list of string pattern (string, cursor, cursor_pair, list_number, list_cursor_pair, list_cursor, list_list_cursor, list_string, vector3d, number) Return Code list of result (list string) Sample Code result = JPT.Exec('MC_Mesh_Quality_Manual_Check_Tri([3:1], 0, 0, 0.1)') # result = 1, [6:100, 6:101] listString = JPT.MacroResultParser(result, ["integer", "list_cursor"])
