# Assembly.RightClick.UnSuppress()

Assembly.RightClick.UnSuppress()

Description​

Unsuppress part on Assembly tree.

Syntax​

Assembly.RightClick.UnSuppress(...)

Ribbon: Assembly » Right Click » UnSuppress

Inputs​

crlParts​

A List of Cursor specifying the part.

The default value is [].

Return Code​

True if success, or False if fail.

Sample Code​

Geometry.Part.Cube()
Assembly.RightClick.Suppress(crlParts=[Part(1)])
result = Assembly.RightClick.UnSuppress(crlParts=[Part(1)])
print(result)
