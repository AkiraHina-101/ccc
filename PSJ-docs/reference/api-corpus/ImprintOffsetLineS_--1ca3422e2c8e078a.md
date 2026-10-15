# ImprintOffsetLineS()

ImprintOffsetLineS()

説明​

インプリントオフセットラインを作成します

構文​

ImprintOffsetLineS(cursor[] face, cursor[] edge, bool bBreakFace, double offsetDistance, int iLayerNumber,
    bool merge, bool extend, int layerMethod, double layerOffset, bool autoCollapse, int RLType)

入力​

1. Cursor[]​

ターゲットフェースカーソル（[6：Face ID]）

2. Cursor[]​

ターゲットエッジカーソル（[5：Edge ID]）

3. Bool​

フェースを分割するかどうか: True = 1、False = 0

4. Double​

Layer 0 に対応するオフセット距離

5. Int​

Layer 0 に対応するレイヤー番号

6. Bool​

オフセットラインをマージするかどうか: True = 1、False = 0

7. Bool​

オフセットラインを延長するかどうか: True = 1、False = 0

8. Int​

レイヤー方法

0: 数値で距離

1: 距離でレイヤー

9. Double​

Layer 1 に対応する[レイヤーオフセット値]

10. Bool​

自動コラプスするかどうか: True = 1、False = 0

11. Int​

オプション方法

0: 片側、元のオフセット方向で

1: 片側、元のオフセット方向の反対側で

2: 両側

戻り値​

"1": 関数は実行可能

"0": 関数は実行不可能

サンプルコード​

ImprintOffsetLineS([6:67], [5:568], 0, 0.0015, 3, 0, 0, 1, [0.002], 0, 2)
