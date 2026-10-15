# Meshing.LocalRemesh.Surface()

Meshing.LocalRemesh.Surface()

説明​

選択したフェースをリメッシュします。

構文​

Meshing.LocalRemesh.Surface(...)

マクロ：LocalRemeshTriQuad

リボン：Meshing » LocalRemesh » Surface

入力​

crlTargets​

サーフェスリメッシュの対象を指定する Cursor リストです。この対象にはパート、フェース、エッジ、または要素が含まれます。

この入力は必須です。

surfaceMesh​

メッシュパラメータを指定する SURFACE_MESH です。

この入力は必須です。

bUseSetting​

ローカル設定の使用を有効または無効にする Boolean です。このパラメータが無効（False）に設定されている場合、既存のローカルメッシュ設定は使用されません。

デフォルト値は True です。

bGrading​

メッシュのグラデーションを有効または無効にする Boolean です。有効（True）に設定されている場合、選択したターゲットとその周囲のフェースが一緒にリメッシュされます。無効（False）に設定されている場合、選択したターゲットのみがリメッシュされます。

デフォルト値は False です。

bFMesher​

F-mesherの使用を有効または無効にする Boolean です。F-mesherはQuad4要素のみを作成するメッシャーです。surfaceMesh がTri3要素を作成するように設定されている場合、このオプションは効果をもたらしません。

デフォルト値は False です。

iOverrideType​

メッシュパターンタイプを指定する Integer です。

0（IsoMesh）：該当する場合、選択したターゲットに等方性メッシュ（構造メッシュ）を作成します。

1（FreeMesh）：選択したターゲットに自由メッシュ（非構造メッシュ）を作成します。

デフォルト値は1です。

bKeepConnection​

メッシュ後の接続（境界条件）の保持を有効（True）または無効（False）にする Boolean です。

デフォルト値は False です。

bProjCAD​

リメッシュされたターゲットを CAD モデルに投影するかどうかを指定する Boolean です。

デフォルト値は True です。

bIDcheck​

投影時のIDチェックを有効または無効にする Boolean です。

bTinyFaceMerge​

リメッシュ前に微小なフェースをマージするかどうかを指定する Boolean です。このオプションは Geometry.MergeEntities.TinyFacesMerge と同等です。

デフォルト値は False です。

dMinFaceWidth​

最小フェース幅を指定する Double です。bTinyFaceMerge が True の場合、このパラメータは微小なフェースを検索するために使用されます。

デフォルト値は0です。

dMaxFaceWidth​

最大フェース幅を指定する Double です。bTinyFaceMerge が True の場合、このパラメータは微小なフェースを検索するために使用されます。

デフォルト値は0.001です。

bKeepRemeshEdge​

リメッシュ時に作成されたエッジを保持するかどうかを指定する Boolean です。このオプションは、選択したターゲットが2D要素の場合のみ機能します。無効に設定されている場合、選択した要素は新しいフェースに分割され、新しいエッジも作成されます。有効に設定されている場合、新しいフェースやエッジは作成されません。

デフォルト値は False です。

iGradingElem​

ローカルリメッシュする隣接レイヤーの数を指定する _Integer_整数 です。

デフォルト値は0です。

戻り値​

成功した場合は True、失敗した場合は False の Boolean

サンプルコード​

Geometry.Part.Cube()

creating_status = Meshing.LocalRemesh.Surface(crlTargets=[Face(26)], 
                                              surfaceMesh=SURFACE_MESH(dAvgElemSize=0.0005,
                                                                       dMaxElemSize=0.001, 
                                                                       dMinElemSize=0.0001, 
                                                                       dGeomAngle=0.7853981853, 
                                                                       iPerformanceMode=1,
                                                                       dAutoMergeTinyFacesAngle=0.5235987902, 
                                                                       bLocalRemesh=True, 
                                                                       iNextEntityOffsetId=8985, 
                                                                       iNextElemOffsetId=2601),
                                              bGrading=True, 
                                              iOverrideType=0)

JPT.Debugger(creating_status)
