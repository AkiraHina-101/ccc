# Built-in Types

Built-in Types

An enumeration used in all PSJ-Commands functions.

 | Jupiter Macro/API data type | Abbreviation | Prefix + VariableName | Description

 | Integer | int | iVariableName | Represents a positive or negative value with no decimal point.
2147483647 is the default value of (blank=no input) in the integer value field

 | Boolean | bool | bVariableName | Represents the boolean values False(0) and True(1)

 | Double | double | dVariableName | Represents a computer level double precision floating point number.
1.79769e+308 is the default value of (Blank=no input) in the real number field

 | String | str | strVariableName | Represents a string. Enclose with double quote ""

 | Cursor | cursor | crVariableName | TypeID: Represents an entity in the form of ID.
Example:
3:1
[3:1,3:2] 
Except for CAD part, which takes 2 parameters: ID and Key.
Example:
3:1-1
[3:1-1,3:1-2]

 | Position | position | posVariableName | n/a

 | Vector | vector | vecVariableName | n/a

 | List of Integer | int list | ilVariableName | n/a

 | List of Double | double list | dlVariableName | n/a

 | List of String | string list | strlVariableName | n/a

 | List of Cursor | List of Cursor | crlVariableName | n/a

 | List of Position | position list | poslVariableName | n/a

 | List of Vector | vector list | veclVariableName | n/a

 | List of Boolean | bool list | blVariableName | n/a

 | Pair of Cursor | cursor pair | crpVariableName | n/a

 | List of Cursor Pair | cursor pair list | crplVariableName | n/a

 | TSheetd | TSheetd | tshVariableName | n/a
