# ForceNormalDirection

ForceNormalDirection ForceNormalDirection Description Create Force (normal direction) Syntax ForceNormalDirection(String name, Vector force, int arrowDir, int distributionMethod, Cursor crCoordinate, Cursor[] targets, Cursor crEdit) Inputs String name Vector force int arrorDir (0: Start at node, 1: End at node) int distributionMethod (0: Per selected entity, 1: Per node, 2: Total of select) Cursor coordinate system Cursor[] targets Cursor edit target Return Code 1 Succeeded 0 Failed Sample Code ForceNormalDirection("Force3", [0, -1, 0], 0, 0, 0:0, [6:21], 0:0)
