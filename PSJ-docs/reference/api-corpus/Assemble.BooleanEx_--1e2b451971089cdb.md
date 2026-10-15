# Assemble.BooleanEx()

Assemble.BooleanEx()

説明​

選択した パートに対してブーリアン演算を実行します。

構文​

Assemble.BooleanEx(...)

リボン：Assemble » Boolean

入力​

crlTargetsParts​

ブーリアン演算の対象パートを指定する Cursor のリストです。

これは必須の入力です。

strNameSuffix​

ブーリアン演算後の対象パートのサフィックス名を指定する String です。

これは必須の入力です。

iBooleanType​

ブーリアン演算の種類を指定する Integer です。

デフォルト値は0です。

bLeaveOriginalPart​

オリジナルのパートを保持するオプションを有効/無効にする Boolean です。

デフォルト値は False です。

bImprintCrossLine​

クロスラインをオリジナルのパートに印字するオプションを有効/無効にする Boolean です。

デフォルト値は False です。

iTargetPart​

保持する パートのインデックスを指定する Integer です。

デフォルト値は0です。

戻り値​

成功した場合は パートの Cursor を返します。失敗した場合は None を返します。

サンプルコード​

cube1 = Geometry.Part.Cube(iPartColor=4934581)
cube2 = Geometry.Part.Cube(dlOrigin=[0.005, 0.005, 0.005], 
                           strName="Cube_2", 
                           iPartColor=6215639)

boolean_status = Assemble.BooleanEx([cube1, cube2], 
                                    iTargetPart=1)

JPT.Debugger(boolean_status)
