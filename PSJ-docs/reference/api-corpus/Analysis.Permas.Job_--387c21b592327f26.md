# Analysis.Permas.Job()

Analysis.Permas.Job()

Description​

Create a Permas Analysis Job.

Syntax​

Analysis.Permas.Job(...)

Ribbon: Analysis » Permas » Job

Inputs​

strName​

A String specifying the name.

This is a required input.

strDescription​

A String specifying the description.

This is a required input.

iType​

An Integer specifying the type.
0: Structure.

This is a required input.

crEdit​

A Cursor specifying the cursor of the Analysis Permas Job needs editing.

This is a required input.

crlTargets​

A List of Cursor specifying the targets.

This is a required input.

bElStress​

A Boolean specifying whether el stress.

This is a required input.

bElStressMis​

A Boolean specifying whether el stress mis.

This is a required input.

bElStrain​

A Boolean specifying whether el strain.

This is a required input.

bNodeStess​

A Boolean specifying whether node stress.

This is a required input.

bGZip​

A Boolean specifying whether G zip.

This is a required input.

bIdeas​

A Boolean specifying whether ideas.

This is a required input.

bNLResult​

A Boolean specifying whether enable NL Result option.

This is a required input.

iNLStepType​

An Integer specifying the NL step type.
0: ALL.
1: EQUI.
2: LIST.

This is a required input.

dEquiStart​

A Double specifying the equi start.

This is a required input.

dEquiStep​

A Double specifying the equi step.

This is a required input.

dEquiEnd​

A Double specifying the equi end.

This is a required input.

strNLStepList​

A String specifying the NL step list.

This is a required input.

bTimeStep​

A Boolean specifying whether enable Time Step option.

This is a required input.

iTimeStepKind​

An Integer specifying the time step kind.
0: ABS.

This is a required input.

dTimeStart​

A Double specifying the time start.

This is a required input.

dTimeStep​

A Double specifying the time step.

This is a required input.

dTimeEnd​

A Double specifying the time end.

This is a required input.

iLCId​

An Integer specifying the LC ID.

This is a required input.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Analysis.Permas.Job(strName, strDescription, iType, crEdit, crlTargets, bElStress, bElStressMis, bElStrain, bNodeStess, bGZip, bIdeas, bNLResult, iNLStepType, dEquiStart, dEquiStep, dEquiEnd, strNLStepList, bTimeStep, iTimeStepKind, dTimeStart, dTimeStep, dTimeEnd, iLCId)
