# CreateEdgeSpline

CreateEdgeSpline CreateEdgeSpline Description Create Edge Spline Syntax CreateEdgeSpline(Cursor[] node_list, int arc, Cursor body_cursor, String name) Inputs Cursor[] Target nodes list cursor([10:Node ID]) int Arc type* *0: Spline &ensp;1: Arc (3 Nodes) Cursor Target body cursor([3:Part ID]) String Bar name Return Code 1 Succeeded 0 Failed Sample Code CreateEdgeSpline([10:455, 10:462, 10:461, 10:469, 10:468], 0, 0:0, "curve")
