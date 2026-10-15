# GetAllParts

GetAllParts GetAllParts Description Get information of all parts Syntax GetAllParts() Inputs None No input value Return Code Python Output BodyVector Part information (typeID, id, key, name) Sample Code Input: part = JPT.GetAllParts() for p in part: print('type="{0}", id="{1}", key="{2}", name="{3}"'.format(p.typeID, p.id, p.key, p.name)) Output: > type="3", id="1", key="1", name="Cube_1" > type="3", id="2", key="2", name="Cylinder_1"
