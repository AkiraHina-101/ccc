# HexModeling.BallHexa()

HexModeling.BallHexa()

説明​

ヘキサ要素で構成された球体を作成します。

構文​

HexModeling.BallHexa(...)

リボン: HexModeling » BallHexa

入力​

crPart​

パートを指定する Cursor です。

これは必須の入力です。

vecCenter​

中心を指定する Vector です。

デフォルト値は [0.0,0.0,0.0] です。

dRadius​

半径を指定する Double です。

デフォルト値は 5.0 です。

dMeshSize​

メッシュサイズを指定する Double です。

デフォルト値は 0.5 です。

iType​

タイプを指定する Integer です。

デフォルト値は 0 です。

iLayer​

レイヤを指定する Integer です。

デフォルト値は 3 です。

bMakeCenterNode​

中心節点を作成するかを指定する Boolean です。

デフォルト値は True です。

strName​

パート名を指定する String です。

デフォルト値は "HexBall_1" です。

戻り値​

成功すると 1 の文字列、失敗すると 0 の文字列。

サンプルコード​

HexModeling.BallHexa(crPart=None, vecCenter=[0.0,0.0,0.0], dRadius=5.0, dMeshSize=0.5, iType=0, 
    iLayer=3, bMakeCenterNode=True, strPartName="HexBall_1")
