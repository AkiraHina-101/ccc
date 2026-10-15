# GetSelectedEdges

GetSelectedEdges GetSelectedEdges Description Get all of selected edge information Syntax GetSelectedEdges() Inputs None No input value Return Code Python Output EdgeVector Selected edge information (typeID, id, key) Sample Code Input: edges = JPT.GetSelectedEdges() for e in edges: print(str(e.typeID)+' '+str(e.id)+' '+str(e.key)) Output: > 5 19 19 > 5 27 27 > 5 18 18
