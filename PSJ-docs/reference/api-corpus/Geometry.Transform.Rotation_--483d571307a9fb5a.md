# Geometry.Transform.Rotation()

Geometry.Transform.Rotation()

説明​

指定した角度でパートを回転させます。

構文​

Geometry.Transform.Rotation(...)

マクロ：RotateBody

リボン：Geometry » Transform » Rotation

入力​

crlParts​

回転するパートを指定する Cursor のリストです。

デフォルト値は[]です。

posCenter​

回転の中心位置を指定する List です。

デフォルト値は[0,0,0]です。

vecAxis​

回転軸を指定する List です。

デフォルト値は[1,0,0]です。

dAngle​

回転角を指定する Double です。

デフォルト値は0です。

bCreateNewPart​

新しいコピーを作成して変換操作を行うかどうかを指定する Boolean です。

デフォルト値は False です。

bCopyLBC​

元のパートの荷重境界条件を回転パートにコピーするかどうかを指定する Boolean です。bCreateNewPart=False の場合、この引数は無視されます。

デフォルト値は False です。

bCopyProperty​

元のパートのプロパティを回転パートにコピーするかどうかを指定する Boolean です。bCreateNewPart=False の場合、この引数は無視されます。

デフォルト値は False です。

iCopyCount​

コピーパートの数を指定する Integer です。bCreateNewPart=False の場合、この引数は無視されます。

デフォルト値は1です。

bMergeNode​

元のパートと変換されたパートの節点をマージするかどうかを指定する Boolean です。bCreateNewPart=False の場合、この引数は無視されます。

デフォルト値は False です。

dTol​

マージ許容値を指定する Double です。bMergeNode=True の場合、この引数を指定する必要があります。

デフォルト値は1.0e-5です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です：

True：プロセスが正常に実行されます。

False：関数を実行できません。

サンプルコード​

Geometry.Part.Cube()

rotate_status = Geometry.Transform.Rotation(crlParts=[Part(1)], 
                                            vecAxis=[0.0, 0.001, 0.0],
                                            dAngle=0.5,
                                            bCreateNewPart=True, 
                                            iCopyCount=3,
                                            dTol=1e-05)

JPT.Debugger(rotate_status)
