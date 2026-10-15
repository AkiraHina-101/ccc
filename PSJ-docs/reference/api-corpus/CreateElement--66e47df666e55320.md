# CreateElement

CreateElement CreateElement Description Create element based on nodes Syntax CreateElement(int iElemType, int iParentEntity, int[] viNodeKey) Inputs Int Create element type* *0: TRI3 &ensp;1: QUAD4 Int Parent face key cursor(Face ID) Int[] Node key cursor([Node ID]) Return Code 1 Succeeded 0 Failed Sample Code CreateElement(0, 24, [85, 489, 83])
