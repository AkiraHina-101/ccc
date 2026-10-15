# Tools.ToPost()

Tools.ToPost()

Description​

Convert the model's data and from an opening Pre document to a new Post document enables to add result to the model.

Syntax​

Tools.ToPost(...)

Macro:

Ribbon: Tools » ToPost

Inputs​

strName​

A String specifying the name of Post document will be converted.

This is a required input.

ilOptions​

A List of Integer specifying the related settings will be converted with model.

0: Group

1: LBC

2: Connection

3: Coordinate

4: Property

The default value is [].

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

# Prepare Pre model
Geometry.Part.Cube()

# Convert to Post
Tools.ToPost(strName="Jupiter1", ilOptions=[0, 1, 2, 3, 4])
