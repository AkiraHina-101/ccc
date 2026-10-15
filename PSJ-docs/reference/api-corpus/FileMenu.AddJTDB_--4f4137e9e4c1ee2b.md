# FileMenu.AddJTDB()

FileMenu.AddJTDB()

Description​

Add jtdb into model

Syntax​

FileMenu.AddJTDB(strFileName, strMethod="AUTO", strTargetModel="IMPORTED", strOption="OFFSET", iInputNode=0, iInputElem=0, iInputPart=0, iInputMaterial=0, iInputProperty=0)

Ribbon: FileMenu » AddJTDB

Inputs​

strFileName​

A String specifying the file name.

This is a required input.

strMethod​

A String specifying the method.

The default value is "AUTO".

strTargetModel​

A String specifying the target model.

The default value is "IMPORTED".

strOption​

A String specifying the option.

The default value is "OFFSET".

iInputNode​

An Integer specifying the input node.

The default value is 0.

iInputElem​

An Integer specifying the input element.

The default value is 0.

iInputPart​

An Integer specifying the input part.

The default value is 0.

iInputMaterial​

An Integer specifying the input material.

The default value is 0.

iInputProperty​

An Integer specifying the input property.

The default value is 0.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

FileMenu.AddJTDB(strFileName, strMethod="AUTO", strTargetModel="IMPORTED", strOption="OFFSET", iInputNode=0, iInputElem=0, iInputPart=0, iInputMaterial=0, iInputProperty=0)
