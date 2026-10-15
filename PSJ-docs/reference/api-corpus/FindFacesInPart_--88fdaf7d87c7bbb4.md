# FindFacesInPart()

FindFacesInPart()

説明​

部分内のフェースを見つけます。

構文​

FindFacesInPart（Cursor crTargetPart、string strTargetPartString）

入力​

1. Cursor​

対象パートのカーソル（3:パートID）

2. String​

検索対象（最大XFACE、最小XFACE、最大YFACE、最小YFACE、最大ZFACE、最小ZFACE）

戻り値​

"1"：関数を実行できます

"0"：関数を実行できません

サンプルコード​

JPT.Exec（'FindFacesInPart（3:3、"MaxZFACE"）'）
