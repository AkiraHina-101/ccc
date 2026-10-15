# Geometry.Transform.Scaling()

Geometry.Transform.Scaling()

説明​

パートの重心または座標系に関してサイズを変更します。異なるスケールで異なる寸法をリサイズできます。

構文​

Geometry.Transform.Scaling(...)

マクロ: ScaleBody

リボン: Geometry » Transform » Scaling

入力​

crlParts​

スケーリングされるパートを指定する Cursor のリスト。

これは必須入力です。

dlScaleVector​

各方向にどれだけスケーリングを行うかを定義するスケールベクトルを指定する Double のリスト。

デフォルト値は [1.0,1.0,1.0] です。

dlScaleCenter​

指定パート図形がスケーリングされるポイントを定義するスケール中心を指定する Double のリスト。

デフォルト値は [0.0,0.0,0.0] です。

crCoordinate​

座標系を指定する Cursor 。

デフォルト値は None です。

bCreateNew​

新しいパートを作成するかオリジナルパートにアタッチするかを指定する Boolean 。

デフォルト値は False です。

bCopyLbc​

オリジナルパートのロード境界条件をスケーリングされたパートにコピーするかを指定する Boolean 。

デフォルト値は False です。

bCopyProperty​

オリジナルパートのプロパティをスケーリングされたパートにコピーするかを指定する Boolean 。

デフォルト値は False です。

bUsePartCenter​

オリジナルパートの中心をスケーリングされた中心として使用するかを指定する Boolean 。

デフォルト値は True です。

戻り値​

プロセスが正常に実行されたかどうかを指定する Boolean です：

True: プロセスは正常に実行されました。

False: 関数を実行できません。

サンプルコード​

Geometry.Part.Cube()

scaling_status = Geometry.Transform.Scaling(crlParts=[Part(1)], 
                                            dlScaleVector=[1.5, 
                                                           0.5, 
                                                           0.5], 
                                            bCreateNew=True)

JPT.Debugger(scaling_status)
