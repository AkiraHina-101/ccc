# ImportUniversal()

ImportUniversal()

説明​

ユニバーサル結果ファイルをインポートします。

構文​

ImportUniversal(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle)

入力​

1. str​

ユニバーサル結果ファイルのパスを指定する文字列です。

2. int​

インポートタイプを指定する整数です。

3. double​

フェース分割を決定するための角度許容度を指定するダブルです（指定された値より小さい角度を持つ隣接する要素間にエッジを作成します）。

4. double​

エッジ分割を決定するための角度許容度を指定するダブルです（指定された値より大きい角度を持つ隣接するエッジ要素に頂点を作成します）。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportUniversal("ファイルへのパス", 1, 60.0, 60.0)
