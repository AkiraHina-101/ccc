# ImportNastran()

ImportNastran()

説明​

Nastran / Vibro 結果ファイルをインポートします。

構文​

ImportNastran(str strPath, int iImportType, double dFaceAngle, double dEdgeAngle, bool bReadLoadAndConstraint, bool bReadConnection, bool bCreateResultsAtMidNode, bool bIsVibro)

入力​

1. str​

Nastran 結果ファイルのパスを指定する文字列です。

2. int​

インポートタイプを指定する整数です。

3. double​

フェース分割を決定するための角度許容度を指定する倍精度浮動小数です（指定値より小さい角度の隣接要素間にエッジを作成します）。

4. double​

エッジ分割を決定するための角度許容度を指定する倍精度浮動小数です（指定値より小さい角度の隣接要素間にエッジを作成します）。

5. bool​

読み込むかどうかを指定するブール値です。

6. bool​

接続を読み込むかどうかを指定するブール値です。

7. bool​

中間節点で結果を作成するかどうかを指定するブール値です。

8. bool​

ファイルが Vibro Acoustic かどうかを指定するブール値です。

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportNastran("path/to/the/file", 1, 60.0, 60.0, 0, 0, 0, 0)
