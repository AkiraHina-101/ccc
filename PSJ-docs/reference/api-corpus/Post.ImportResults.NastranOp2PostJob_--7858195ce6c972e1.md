# Post.ImportResults.NastranOp2PostJob()

Post.ImportResults.NastranOp2PostJob()

Description​

Import Nastran op2 post job

Syntax​

Post.ImportResults.NastranOp2PostJob(strName, strlPaths, crEdit=None)

Ribbon: Post » ImportResults » NastranOp2PostJob

Inputs​

strName​

A String specifying the name.

This is a required input.

strlPaths​

A List of String specifying the paths.

This is a required input.

crEdit​

A Cursor specifying the cursor of Result Nastran Op2 needs editing.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Post.ImportResults.NastranOp2PostJob(strName, strlPaths, crEdit=None)
