# GetSelectedNodes

GetSelectedNodes GetSelectedNodes Description Get selected node information Syntax GetSelectedNodes() Inputs None No input value Return Code Python Output NodeVector Selected node information (typeID, id, key, pos) Sample Code Input: nodes= JPT.GetSelectedNodes() for n in nodes: print('type="{0}", id="{1}", key="{2}"'.format(n.typeID, n.id, n.key)) Output: > type="10", id="93", key="93" > type="10", id="486", key="486" > type="10", id="480", key="480"
