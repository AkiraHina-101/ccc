# ImprintPerpendicularLine

ImprintPerpendicularLine ImprintPerpendicularLine Description Create imprint Perpendicular line Syntax ImprintPerpendicularLine(cursor[] nodes, cursor[] faces, double offset, bool bBreakFace) Inputs Cursor[] Target node cursor([10:Node ID]) Cursor[] Target faces cursor([6:Face ID]) Double Insert offset value Bool Whether break face or not True = 1, False = 0 Return Code 1 Succeeded 0 Failed Sample Code ImprintPerpendicularLine([10:218, 10:190], [6:22], 0.002, 1)
