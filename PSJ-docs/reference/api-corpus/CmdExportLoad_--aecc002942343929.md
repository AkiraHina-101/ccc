# CmdExportLoad()

CmdExportLoad()

説明​

ファイルとしてエクスポート・ロードします。

構文​

CmdExportLoad(cursor[] taEntity, int analysisType, int resultSet, int timeStep, vecResultLoad [] ResultLoads, int SolverType, string ExportFile)

入力​

1. cursor[]​

対象エンティティ。

2. int​

解析タイプ。

3. int​

結果セット。

4. int​

タイムステップ。

5. ResultLoad []​

以下で構成される ResultLoad：

vrType - vr タイプ,

string - 結果名,

string - ロード名。

6. int​

ソルバータイプ。

7. string​

エクスポートされるファイル名。

戻り値​

なし。

サンプルコード​

CmdExportLoad([10:1008], 1,1,1, [[6, Displacement,Initial Displacement]], 2, "C:/Temp/data.dat")
