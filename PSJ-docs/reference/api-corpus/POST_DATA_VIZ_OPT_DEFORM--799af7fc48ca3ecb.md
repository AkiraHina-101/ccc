# POST_DATA_VIZ_OPT_DEFORM

POST_DATA_VIZ_OPT_DEFORM

説明​

データ型は、変形の表示結果設定を行うために使用されます。

属性​

iScaleMethod​

変位スケールメソッドを指定する Integer です。

0: モデルサイズの割合

1: 結果の割合

デフォルト値は0です。

dDisplacementRatio​

全体的な変位スケールファクターを指定する Double です。

デフォルト値は0.07です。

bEachDirectionRatio​

X、Y、Z 方向それぞれの変位スケール比率を変更可能にするかどうかを指定する Boolean です。

デフォルト値は False です。

dlEachDirectionRatio​

X、Y、Z 方向それぞれの変形スケール比率を指定する Double 型のリスト です。

デフォルト値は[0.07, 0.07, 0.07]です。

bShowShade​

変形前の元のモデルの表面を表示／非表示にするかを指定する Boolean です。

デフォルト値は False です。

iShadeColor​

変形前の元のモデルの表面色を指定する Integer です。

デフォルト値は13158600です。

bShowMesh​

変形前の元のモデルのメッシュラインを表示／非表示にするかを指定する Boolean です。

デフォルト値は True です。

iMeshColor​

変形前の元のモデルのメッシュラインの色を指定する Integer です。

デフォルト値は11184810です。

bShowEdge​

変形前の元のモデルのエッジを表示／非表示にするかを指定する Boolean です。

デフォルト値は True です。

iEdgeColor​

変形前の元のモデルのエッジの色を指定する Integer です。

デフォルト値は11184810です。

dTransparency​

シェードモードの透明度値を指定する Double です。

デフォルト値は0.8です。
