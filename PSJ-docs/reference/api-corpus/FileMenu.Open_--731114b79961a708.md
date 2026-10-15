# FileMenu.Open()

FileMenu.Open()

Description​

Load JTDB file

Syntax​

FileMenu.Open(strFileName="", bUseTmpTable=False)

Ribbon: FileMenu » Open

Inputs​

strFileName​

A String specifying the file name.

The default value is "".

bUseTmpTable​

A Boolean specifying the use temporary table.

The default value is False.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

FileMenu.Open(strFileName="", bUseTmpTable=False)
