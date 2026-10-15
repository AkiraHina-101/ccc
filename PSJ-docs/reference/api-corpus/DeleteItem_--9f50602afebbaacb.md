# DeleteItem()

DeleteItem()

Description​

Delete inticated item

Syntax​

DeleteItem(bool bModel, Cursor[] DeleteTarges, Cursor[] NA, Cusror[] NA, bool bRelated)

Inputs​

1. bool​

Delete Model.

0: Delete specified entities in the model only.

1: Delete model.

2. Cursor[]​

Target items to delete.

3. Cursor[]​

Items to be checked for deletion depending on the deletion targets.

4. Cursor[]​

Items where the deletion targets removed from.

5. bool​

Delete the related item of the deletion taregets.

Return Code​

"1": The function can be executed

Sample Code​

DeleteItem(0, [3:1], [], [], 1)
