# ImportInp()

ImportInp()

説明​

Abaqus INP ファイルをインポートします

構文​

ImportInp(string[] m_vecPath,double m_faceAngle,double m_edgeAngle, int iImportType)

入力​

1. String[]​

複数のファイルパス

2. Double​

フェース角度

3. Double​

エッジ角度

4. Int​

インポートタイプ

0: 標準的な Abaqus Inp

1: プロパティによる標準的な Abaqus Inp

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportInp(["D:/Test.inp"], 1.0472, 1.0472, 1)
