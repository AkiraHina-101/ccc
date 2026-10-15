# GetCenterOfEntities

GetCenterOfEntities GetCenterOfEntities Description Get center coordinate of selected entities Syntax GetCenterOfEntities(vector DItem) Inputs DItemVector Vector DItem Return Code Python Output DoubleVector Coordinate[x,y,z] of selected entities Sample Code Input: entity = JPT.GetAllSelected() center = JPT.GetCenterOfEntities(entity) for c in center: print(str(float(c))) Output: > 0.004999999999999999 > 0.004999999999999999 > 0.010000000000000007
