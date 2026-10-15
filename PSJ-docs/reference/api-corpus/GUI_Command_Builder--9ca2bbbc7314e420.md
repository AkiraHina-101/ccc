# GUI Command Builder

GUI Command Builder

GUI Command Builder is an interactive builder of PSJ-GUI, help making Jupiter dialog or wizard by Drag & Drop operations.
User hence does not need to know Python programming language to make UI components in Jupiter.
GUI Command Builder can be easily accessed from Python ribbon.

The main application has below menu and windows:

Tool menu​

Perform operations related to the creation of dialogs and wizards.

 | Icon | Name | Description | Shortcut Key

 |  | Make a new dialog | Clear the being created settings and open a new environment | F5

 |  | Open an existing database | Open and load a database file | F4

 |  | Save dialog settings to database | Save the being created dialog settings to an external database file | F6

 |  | Save dialog settings to new database | Save the being created dialog settings to a new database file | F7

 |  | Undo | Undo the previously executed operation | 

 |  | Redo | Redo the previously cancelled operation | 

 |  | Show or hide code window | Switch showing or hiding the code window | F1

 |  | Preview dialog | Display a preview of the being created dialog | F2

 |  | Save dialog to customer folder | Save the dialog to the PSJ Command folder and display it in Jupiter's ribbon | F3

 |  | Help | Display a short tutorial (being created) | 

GUI Builder tab​

In this tab, user can design a custom dialog.

Tool Box window​

Contain all the components used to create dialogs and wizards.

 | Icon | Name | Description

 |  | Layout | Create a layout to arrange components inside

 |  | GroupBox | Create a group box which can contain some components

 |  | TabWnd | Create a tab container

 |  | TabItem | Create a tab inside the tab container

 |  | Label | Create a label

 |  | TextBox | Create a text box

 |  | RichEditCtrl | Create a text box that can be entered in various data formats and multiple lines

 |  | ComboBox | Create a combo box

 |  | ListBox | Create a list box

 |  | CheckBox | Create a check box

 |  | RadioButton | Create a radio button

 |  | Button | Create a button

 |  | ImageCtrl | Create an image container

 |  | Spin | Create a spin button

 |  | Slide Bar | Create a slide bar

 |  | Separator | Create a separator line

 |  | Browser | Create a open file/folder selection

 |  | Table | Create a table

 |  | PagesCtrl | Create a page container (used for wizard)

 |  | PageItem | Create a page inside the page container (used for wizard)

Hierarchy window​

All components in use are displayed in a tree format.
User can change the position (using icons or Drag & Drop operations), duplicate or delete components.

 | Icon | Name | Description

 |  | Move item out of current container | Move the selected component out of the current container which it is being belong to

 |  | Move item into next container | Move the selected component into the above container

 |  | Move item forward one level | Move the selected component up one level but still inside the current container

 |  | Move item backward one level | Move the selected component down one level but still inside the current container

 |  | Copy item and insert it | Duplicate the selected component

 |  | Delete selected item | Delete the selected component

 |  | Expand all tree nodes | Expand all subtrees

 |  | Collapse all tree nodes | Collapse all subtrees

Properties window​

Display all properties of the selected component.
The settings of the dialog created can also be set from the Properties window.
By selecting a component in the Hierarchy window, user can change its parameters in this Properties window.

Editor tab​

In this tab, user can integrate the PSJ automation script to the current dialog.

Option window​

Define location of the PSJ script and main function.

 | Name | Description

 | Module | Location of the PSJ script

 | Function | Main function which will be run after Apply or OK button is pressed

Script window​

A simple text editor showing the selected PSJ file for user's edition or confirmation.

Current UI Names window​

Show all the current component names defined in the GUI Builder tab.
User can double click on the component name to quickly insert it the current cursor location in the Script window.
