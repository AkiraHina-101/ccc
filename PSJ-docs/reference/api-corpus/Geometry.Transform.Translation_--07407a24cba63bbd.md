# Geometry.Transform.Translation()

Geometry.Transform.Translation()

説明​

与えられたベクトルに沿ってパートを移動します。ベクトルの向きと大きさは、直交座標系の特定の軸に沿って任意であるかもしれません。

構文​

Geometry.Transform.Translation(...)

マクロ: TranslateBody

リボン: Geometry » Transform » Translation

入力​

crlParts​

移動させるパートを指定する Cursor リスト。

この入力は必須です。

dlTranslationVector​

特定の移動の向きと大きさを定義する crLocalCoordinate 座標系内の移動ベクトルを指定する Position のリスト。

デフォルト値は [] です。

crLocalCoordinate​

dlTranslationVector の定義に使用されるローカル座標系を指定する Cursor。

デフォルト値は None です。

bCreateNewPart​

元のパートを保持し、移動した位置に新しいパートを作成するかどうかを指定する Boolean です。

デフォルト値は False です。

bCopyLBC​

既存のパートから作成されたパートに境界条件をコピーするかどうかを指定する Boolean です。

デフォルト値は False です。

bCopyProperty​

既存のパートから作成されたパートにプロパティをコピーするかどうかを指定する Boolean です。

デフォルト値は False です。

bCopyReference​

既存のパートから作成されたパートに参照をコピーするかどうかを指定する Boolean です。

デフォルト値は False です。

iCopyCount​

コピーする回数（パートの作成数）を指定する Integer です。

デフォルト値は 1 です。

戻り値​

成功した場合は新しいパートを指定する Cursor リスト、失敗した場合は empty を指定します。

サンプルコード​

Geometry.Part.Cube(iPartColor=8124407)
translated_part = Geometry.Transform.Translation(crlParts=[Part(1)],
                                                 dlTranslationVector=[[-0.00666, 0.00222, 0]])
JPT.Debugger(translated_part)
