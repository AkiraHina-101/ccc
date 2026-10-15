# JPT.ExpandAssemblyTree()

JPT.ExpandAssemblyTree()

説明​

アセンブリウィンドウに存在するすべてのアイテムを展開します。

このユーティリティは、 JPT.CollapseAssemblyTree() ユーティリティを使用した後、アセンブリウィンドウに存在するすべてのアイテムを展開するために使用されます。

構文​

JPT.ExpandAssemblyTree()

入力​

このユーティリティ関数は、入力値を必要としません。

戻り値​

このユーティリティ関数には出力値がありません。

サンプルコード​

# 木構造の準備
Geometry.Part.Cube()
Geometry.Part.Cube(strName="Cube_2", iPartColor=6409934)
Geometry.Part.Cube(strName="Cube_3", iPartColor=13259210)
Geometry.Part.Cube(strName="Cube_4", iPartColor=7697908)
Geometry.Part.Cube(strName="Cube_5", iPartColor=7463537)
Geometry.Part.Cube(strName="Cube_6", iPartColor=7434735)
Geometry.Part.Cube(strName="Cube_7", iPartColor=14903267)
Geometry.Part.Cube(strName="Cube_8", iPartColor=15658599)
Geometry.Part.Cube(strName="Cube_9", iPartColor=7961077)
Geometry.Part.Cube(strName="Cube_10", iPartColor=7829501)
Geometry.Part.Cube(strName="Cube_11", iPartColor=11842649)
Geometry.Part.Cube(strName="Cube_12", iPartColor=14968422)
Geometry.Part.Cube(strName="Cube_13", iPartColor=6250447)
Geometry.Part.Cube(strName="Cube_14", iPartColor=12734402)
Assembly.RightClick.AddSubAssembly()
Assembly.RightClick.AddSubAssembly()
Assembly.RightClick.AddSubAssembly(crInst=Inst(1))
Assembly.RightClick.AddSubAssembly(crInst=Inst(2))
Assembly.RightClick.AddSubAssembly(crInst=Inst(4))
Assembly.RightClick.AddSubAssembly(crInst=Inst(5))
Assembly.RightClick.AddSubAssembly(crInst=Inst(3))
Assembly.RightClick.AddSubAssembly(crInst=Inst(6))
Assembly.RightClick.AddSubAssembly(crInst=Inst(7))
Assembly.RightClick.AddSubAssembly(crInst=Inst(7))
Assembly.RightClick.AddSubAssembly(crInst=Inst(7))
Connections.MPC.General.NodesToNodes(crlMasterNodes=[Node(6425)], crlSlaveNodes=[Node(6776)], listMpcConnection=[MPC_CONNECTION(iDof=1), MPC_CONNECTION(iDof=2), MPC_CONNECTION(iDof=4), MPC_CONNECTION(), MPC_CONNECTION(), MPC_CONNECTION()], bUpdateDispCS=1)
Connections.MPC.General.NodesToNodes(strName="MPC_2", crlMasterNodes=[Node(6776)], crlSlaveNodes=[Node(6775)], listMpcConnection=[MPC_CONNECTION(iDof=1), MPC_CONNECTION(iDof=2), MPC_CONNECTION(iDof=4), MPC_CONNECTION(), MPC_CONNECTION(), MPC_CONNECTION()], bUpdateDispCS=1)
Connections.MPC.General.NodesToNodes(strName="MPC_3", crlMasterNodes=[Node(6775)], crlSlaveNodes=[Node(6774)], listMpcConnection=[MPC_CONNECTION(iDof=1), MPC_CONNECTION(iDof=2), MPC_CONNECTION(iDof=4), MPC_CONNECTION(), MPC_CONNECTION(), MPC_CONNECTION()], bUpdateDispCS=1)
Connections.MPC.General.NodesToNodes(strName="MPC_4", crlMasterNodes=[Node(6774)], crlSlaveNodes=[Node(6773)], listMpcConnection=[MPC_CONNECTION(iDof=1), MPC_CONNECTION(iDof=2), MPC_CONNECTION(iDof=4), MPC_CONNECTION(), MPC_CONNECTION(), MPC_CONNECTION()], bUpdateDispCS=1)

# アセンブリウィンドウに存在する全アイテムを展開する
JPT.ExpandAssemblyTree()

# アセンブリウィンドウに存在する折りたたまれたアイテムをすべて折りたたむ
JPT.CollapseAssemblyTree()
