# JPT.GetAllLibraryMaterials()

JPT.GetAllLibraryMaterials()

説明​

すべてのライブラリ材料の情報を取得します。

構文​

JPT.GetAllLibraryMaterials()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

すべての既存のユーザー材料の情報を含む MaterialLibVector オブジェクトまたは List of DMaterialLib オブジェクト。

サンプルコード​

# すべてのライブラリ材料を取得
libMat = JPT.GetAllLibraryMaterials()
print(f"ライブラリには {len(libMat)} 個の材料があります")
JPT.Debugger(libMat)
JPT.Debugger(libMat[0])
