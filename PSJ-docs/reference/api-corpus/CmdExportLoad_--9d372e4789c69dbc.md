# CmdExportLoad()

CmdExportLoad()

説明​

選択したエンティティの解析結果名を、選択したエンティティに対応するソルバ情報（ソルバキーワードカード）にエクスポートします。変換ロードタイプの選択に応じて、解析結果はそれぞれソルバカード情報にエクスポートされます。

構文​

CmdExportLoad(cursor[] Targets, int AnalysisType, int ResultSet, int TimeStep, vector ResultLoad, int SolverType, string ExportPath)

入力​

1. cursor[]​

選択したエンティティを指定する Cursor リストです。

2. int​

解析の種類を選択します。

3. int​

結果のセットを指定する整数型です。

4. int​

タイムステップを指定する整数型です。

5. vector​

選択した結果の成分を指定する RESULT_LOAD のベクトルです。

6. int​

ソルバの種類を指定する整数型です。

7. string​

エクスポートするファイルのパスを指定する文字列です。

戻り値​

"1": 関数を実行できます。

"0": 関数を実行できません。

サンプルコード​

CmdExportLoad([3:1,3:2,3:3], 0, 0, 0, [], 2, "C:/temp/ResultToLoadFile")
