# Assemble.AddBoss()

Assemble.AddBoss()

説明​

特定のパートにボス形状をユニオンパートとして追加します。

構文​

Assemble.AddBoss(...)

リボン: Assemble » Add BOSS

入力​

crPart​

パートを指定する Cursor です。

デフォルト値はありません。

iType​

タイプを指定する Integer です。

デフォルト値は0です。

bMerge​

マージを指定する Boolean です。

デフォルト値は True です。

posOrgCenter​

オリジナル中心を指定する Position です。

デフォルト値は[0,0,0]です。

vecOrgDirection​

オリジナル方向を指定する Vector です。

デフォルト値は[0,0,0]です。

crCoord​

座標を指定する Cursor です。

デフォルト値はありません。

iAxis​

軸を指定する Integer です。

デフォルト値は0です。

dAngle​

角度を指定する Double です。

デフォルト値は0.0です。

bHollow​

ホローを指定する Boolean です。

デフォルト値は False です。

dInnerRadius​

インナー半径を指定する Double です。

デフォルト値は0.0です。

dOrgOuterRadius​

オリジナル外径を指定する Double です。

デフォルト値は1.0です。

dTaperAngle​

テーパー角度を指定する Double です。

デフォルト値は0.0です。

iNodeOnCircle​

円上の節点を指定する Integer です。

デフォルト値は12です。

iNodeOnAxis​

軸上の節点を指定する Integer です。

デフォルト値は2です。

dOriginalHeight​

オリジナル高さを指定する Double です。

デフォルト値は5.0です。

戻り値​

成功した場合は True、失敗した場合は False です。

サンプルコード​

Geometry.Part.Cube()
result = Assemble.AddBoss(crPart=Part(1), iType=1, posOrgCenter=[0, 0.00555556, 0.00555556], vecOrgDirection=[-1.0, 0.0, 0.0], dOrgOuterRadius=1.2)
print(result)
