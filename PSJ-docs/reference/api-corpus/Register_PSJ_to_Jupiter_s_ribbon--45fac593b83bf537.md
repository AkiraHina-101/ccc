# Register PSJ to Jupiter's ribbon

Register PSJ to Jupiter's ribbon

🎯 Introduction​

In this tutorial, you'll learn how to register PSJ to Jupiter's ribbon, similarly to built-in functions:

Add a PSJ file with icon as a button in a customized ribbon.

Create customized ribbon groups of PSJ function with separators.

📖 Tutorial​

In the PSJ-Command custom folder (Preferences > Path Setting > PSJ Command), create a new folder as the ribbon name which you want to create.

In the created folder, copy (or replace) the created .py file.

If you need an icon, you can create an .ico file and copy (or replace) to this ribbon folder.
The name of .ico file has to be the same with the name of .py file.

If there is no second folder, Ribbon name is used as the Group name and placed at the first item in ribbon.

You can further create customized ribbon groups of PSJ function (with separators) using below rule:

First folder: Ribbon name (use folder name as Ribbon name, accept white space)

Second folder: Group name (use folder name as Group name, accept white space)

Third folder: Function name (use Python filename as Function name, accept white space)

Functions can be arranged using number prefix, but need to have the same number of characters.

For example:

With below files:

Will display in Jupiter's ribbon:
