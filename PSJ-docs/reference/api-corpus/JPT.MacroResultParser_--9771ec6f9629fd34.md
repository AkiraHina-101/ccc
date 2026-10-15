# JPT.MacroResultParser()

JPT.MacroResultParser()

説明​

実行されたマクロから返される値を String のリストに分割します。

構文​

JPT.MacroResultParser(returnedMacroString, listOfStringPattern)

入力​

returnedMacroString​

実行されたマクロから返された値を指定する String の入力です。

これは必須の入力です。

listOfStringPattern​

返されたマクロ文字列から分割される String のリスト のパターンです。

以下の値が必要な出力リストです:

string

cursor

cursor_pair

list_number

list_cursor_pair

list_cursor

list_list_cursor

list_string

vector3d

number

これは必須の入力です。

戻り値​

文字列を含む実行されたマクロから分割された List。

サンプルコード​

"""
構造: JPT.MacroResultParser(input_string, arg_pattern)

arg_patternのサポートタイプ：
"string",
"cursor",
"cursor_pair",
"list_cursor_pair",
"list_cursor",
"list_list_cursor",
"list_string",
"vector3d",
"list_number",
"number"
"""

print(__doc__)

import re

Geometry.Part.Cube()
Geometry.Part.Cube(dlOrigin=[0.01, 0.0, 0.0], strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(dlOrigin=[0.02, 0.0, 0.0], strName="Cube_3", iPartColor=7697908)
Geometry.Part.Cube(dlOrigin=[0.03, 0.0, 0.0], strName="Cube_4", iPartColor=7463537)
Geometry.Part.Cube(dlOrigin=[0.03, 0.01, 0.0], strName="Cube_5", iPartColor=7434735)
Geometry.Part.Cube(dlOrigin=[0.03, 0.02, 0.0], strName="Cube_6", iPartColor=14903267)
Geometry.Part.Cube(dlOrigin=[0.03, 0.03, 0.0], strName="Cube_7", iPartColor=15658599)
Geometry.Part.Cube(dlOrigin=[0.02, 0.03, 0.0], strName="Cube_8", iPartColor=7961077)
Geometry.Part.Cube(dlOrigin=[0.01, 0.03, 0.0], strName="Cube_9", iPartColor=7829501)
Geometry.Part.Cube(dlOrigin=[0.0, 0.03, 0.0], strName="Cube_10", iPartColor=11842649)
Geometry.Part.Cube(dlOrigin=[0.0, 0.02, 0.0], strName="Cube_11", iPartColor=14968422)
Geometry.Part.Cube(dlOrigin=[0.0, 0.01, 0.0], strName="Cube_12", iPartColor=6250447)
Geometry.Part.Cube(dlOrigin=[0.01, 0.01, 0.0], strName="Cube_13", iPartColor=12734402)
Geometry.Part.Cube(dlOrigin=[0.02, 0.01, 0.0], strName="Cube_14", iPartColor=16579696)
Geometry.Part.Cube(dlOrigin=[0.02, 0.02, 0.0], strName="Cube_15", iPartColor=7666683)
Geometry.Part.Cube(dlOrigin=[0.01, 0.02, 0.0], strName="Cube_18", iPartColor=13787489)

select_contact_face = JPT.Exec('FindContactPairsDynamic([{}], 0, 0, 0.001, 1, 1, 0.001)'.\
                            format(", ".join([("3:" + str(_.id)) for _ in JPT.GetAllParts()])))

arg_pattern = ["number",
               "list_string",
               "list_list_cursor",
               "list_list_cursor"]
list_args = JPT.MacroResultParser(select_contact_face, arg_pattern)
JPT.Debugger(list_args)

print(
    f"状態の検索 : \
        {'連絡先が見つかりました' if list_args[1]!=[] and list_args[1]!=[] else 'このモデルには連絡先がありません'}"
)

number_of_matching = len((re.sub("\]|\[", "", list_args[1]).strip().split(",")))
print(f"連絡先の数: {number_of_matching}")

JPT.Exec('FindContact({0}, {1}, {2}, [{3}], [{4}], [{5}], [{6}], [{7}], \
                      [{8}], [{9}], [{10}])'.\
          format(list_args[1],
                 list_args[2],
                 list_args[3],
                 ",".join(["1" for _ in range(number_of_matching)]),
                 ",".join(["0.001" for _ in range(number_of_matching)]),
                 ",".join(["1.79769e+308" for _ in range(number_of_matching)]),
                 ",".join(["0" for _ in range(number_of_matching)]),
                 ",".join(["65280" for _ in range(number_of_matching)]),
                 ",".join(["0:0" for _ in range(number_of_matching)]),
                 ",".join(["0:0" for _ in range(number_of_matching)]),
                 ",".join(["0:0" for _ in range(number_of_matching)])))
