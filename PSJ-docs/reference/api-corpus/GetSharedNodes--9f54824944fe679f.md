# GetSharedNodes

GetSharedNodes GetSharedNodes Description Get shared node information Syntax GetSharedNodes(DItemVector DItems) Inputs DItemVector Vector DItem Return Code Python Output DItemVector Shared node information (typeID, id, key) Sample Code Input: shareNodes = JPT.GetAllSelected() share = JPT.GetSharedNodes(shareNodes) for s in share: print('typeID="{0}", id="{1}", key="{2}"'.format(s.typeID, s.id, s.key)) Output: > typeID="10", id="585", key="585" > typeID="10", id="493", key="493" > typeID="10", id="536", key="536"
