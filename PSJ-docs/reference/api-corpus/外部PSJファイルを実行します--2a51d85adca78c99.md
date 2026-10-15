# 外部PSJファイルを実行します

外部PSJファイルを実行します

🎯 導入​

このチュートリアルでは、外部PSJスクリプトファイルを実行する方法を学びます。

Jupiter Pathをインストールします。外部Pythonファイルのパスを設定します。

外部Pythonファイルを実行します。

📖 チュートリアル​

# Python APIウィンドウでログメッセージをクリアします
JPT.ClearLog()

# Jupiter Pathをインストールします。外部Pythonファイルのパスを設定します
jupiterPath = JPT.GetAppPathInfo(JPT.PathType.PROGRAM_PATH)
External_Create_Cube = str(jupiterPath) + '/SampleData/PSJ/PSJ-Utility/Utils/External_Create_Cube.py'
External_Meshing = str(jupiterPath) + '/SampleData/PSJ/PSJ-Utility/Utils/External_Meshing.py'

# 外部Pythonファイルを実行します 'External_Create_Cube.py'
exec(open(External_Create_Cube).read())
JPT.ViewFitToModel()
JPT.Exec('ViewShowMesh(1)')

# 外部Pythonファイルを実行します'External_Meshing.py'
exec(open(External_Meshing).read())
