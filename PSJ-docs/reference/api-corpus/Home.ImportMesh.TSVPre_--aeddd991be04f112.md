# Home.ImportMesh.TSVPre()

Home.ImportMesh.TSVPre()

説明​

古いTSV-Pre/Designerファイルを1つまたは複数のjtdbファイルに変換します。

構文​

Home.ImportMesh.TSVPre(...)

マクロ： ImportVDB

リボン： Home » ImportMesh » TSVPre

入力​

strImportPath​

インポートパスを指定する String 。

デフォルト値は""です。

strExportPath​

エクスポートパスを指定する String 。

デフォルト値は""です。

ilModelIndex​

モデルインデックスを指定する Integer のリスト。

デフォルト値はNoneです。

iMerge​

マージを指定する Integer 。

デフォルト値はNoneです。

戻り値​

成功した場合は1の文字列、失敗した場合は0の文字列です。

サンプルコード​

import os

VDBファイルパス = os.path.join(
    JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH), 
    "SampleData/PSJ/PSJ-Utility/VDBSample/sample.vdb")

エクスポートファイルパス = os.environ["Temp"] + "/TechnoStar/"
Home.ImportMesh.TSVPre(strImportPath=VDBファイルパス, strExportPath=エクスポートファイルパス)
