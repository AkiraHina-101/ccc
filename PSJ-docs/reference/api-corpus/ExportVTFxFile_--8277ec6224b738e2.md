# ExportVTFxFile()

ExportVTFxFile()

説明​

VTFXファイルをエクスポートします。

構文​

ExportVTFxFile(str strPath, int iModelType, bool bExcludeBarPart, bool bSurfaceElementOnly, int iData2D, list lSelectedResults, bool bDisplayPostAddTrescaStress, int iCurUnitLength, int iCurUnitTime, int iCurUnitMass, int iCurUnitForce, int iCurUnitAngle, int iCurUnitTemperature, bool bSetDefaultResult)

入力​

1. str​

VTFXファイルへのパスを指定する文字列です。

2. int​

モデルタイプを指定する整数です。

3. bool​

バーパートを除外するかどうかを指定するブール値です。

4. bool​

表面要素のみを含めるかどうかを指定するブール値です。

5. int​

2Dデータのデータ型を指定する整数です。

6. list​

エクスポートに含める選択された結果のリストです。

7. bool​

ポストプロセスされたトレスカ応力を表示するかどうかを指定するブール値です。

8. int​

長さの現在の単位を指定する整数です。

9. int​

時間の現在の単位を指定する整数です。

10. int​

質量の現在の単位を指定する整数です。

11. int​

力の現在の単位を指定する整数です。

12. int​

角度の現在の単位を指定する整数です。

13. int​

温度の現在の単位を指定する整数です。

14. bool​

エクスポートされるファイルのデフォルト結果を設定するかどうかを指定するブール値です。

戻り値​

"1": 関数は実行可能です

"0": 関数は実行できません

サンプルコード​

ExportVTFxFile("path/to/the/file", 1, 0, 0, 0, [], 0, 0, 0, 0, 0, 1, 1, 0)
