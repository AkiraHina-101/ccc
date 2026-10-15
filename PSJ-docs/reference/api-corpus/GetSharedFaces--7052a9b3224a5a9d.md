# GetSharedFaces

GetSharedFaces GetSharedFaces Description Get shared face information Syntax GetSharedFaces(DItemVector DItems) Inputs DItemVector Vector DItem Return Code Python Output DItemVector Shared face information (typeID, id, key) Sample Code Input: shareFace = JPT.GetAllSelected() share = JPT.GetSharedFaces(shareFace) for s in share: print('typeID="{0}", id="{1}", key="{2}"'.format(s.typeID, s.id, s.key)) Output: > typeID="6", id="115", key="115"
