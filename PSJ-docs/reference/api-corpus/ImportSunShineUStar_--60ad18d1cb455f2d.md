# ImportSunShineUStar()

ImportSunShineUStar()

説明​

SunShine UStarファイル（*.op2）をJupiterデータベースにインポートします。

構文​

ImportSunShineUStar(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle, bool bReadLoadAndConstraint, bool bReadConnection, bool bCreateResultsAtMidNode)

入力​

1. str​

SunShine UStarファイルへのパスを指定するString。

2. int​

インポートタイプを指定するInteger。

3. double​

フェースの分割を決定するための角度許容度を指定するDouble（指定値より小さい角度で隣接する要素間にエッジを作成することで）。

4. double​

エッジの分割を決定するための角度許容度を指定するDouble（指定値より大きい角度で隣接するエッジ要素に頂点を作成することで）。

5. bool​

ロードと制約を読み込むかどうかを指定するBoolean。

6. bool​

接続を読み込むかどうかを指定するBoolean。

7. bool​

ミド節点で結果を作成するかどうかを指定するBoolean。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportSunShineUStar("ファイルへのパス", 1, 60.0, 60.0, 0, 0, 0)
