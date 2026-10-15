# Post.ImportResults.NastranHDF5()

Post.ImportResults.NastranHDF5()

Description​

Import Nastran HDF5PostJob file

Syntax​

Post.ImportResults.NastranHDF5(strName="", strlPaths=[], crEdit=None)

Ribbon: Post » ImportResults » NastranHDF5

Inputs​

strName​

A String specifying the name.

The default value is "".

strlPaths​

A List of String specifying the paths.

The default value is [].

crEdit​

A Cursor specifying the cursor of Result Nastran HDF5 needs editing.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Post.ImportResults.NastranHDF5(strName="", strlPaths=[], crEdit=None)
