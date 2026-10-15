# ImportBdf()

ImportBdf()

説明​

Nastran bdf ファイルをインポートします

構文​

ImportBdf(string[] vecPath, int importType, double faceAngle, double edgeAngle,
    bool readNameComment, int createDup1DElemAnswer)

入力​

1. String[]​

パスディレクトリ

2. Int​

インポートタイプ

0: 標準 Nastran BDF

1: 1D2D3D-Part

2: 1D-Edge; 2D-Face; 3D-Part

3. Double​

フェース角度（ラジアン）

4. Double​

エッジ角度（ラジアン）

5. Bool​

Jupiter の名前コメントを読む　True=1, False=0

6. Int​

Dup 1D 要素の作成

戻り値​

"1": 関数を実行できます

"0": 関数を実行できません

サンプルコード​

ImportBdf(["D:/Test.bdf"], 2, 1.0472, 1.0472, 0, -1)
