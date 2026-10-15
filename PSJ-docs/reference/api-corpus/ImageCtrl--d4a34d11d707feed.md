# ImageCtrl

ImageCtrl

Create an image container.

Preview dialog:

Parameters​

Name​

Enter name of the image container.

Enable​

Specify whether to enable it or not.

True : Available

False : Unavailable (grayed out)

Size​

Width : Specify the minimum width of the image control. (in pixels)

Height : Specify the minimum height of the image control. (in pixels)

Image File​

Link to the image file.

Behavior​

Specify the the behavior state of image control to flexibly control size itself.

Greedy : set the displaying image based on the user input width and height

Fixed : set the displaying image based on the original image's size

Horizontal : set the displaying image with fixing height based on the original image's height and allow to resize only horizontally

Vertical : set the displaying image with fixing width based on the original image's width and allow to resize only vertically

Visible​

Specify whether to show/hide the created ImageCtrl.

Check On : Show

Check Off : Hide

API associated with​

dlg.add_imagectrl : Add a frame to put an image to the creating dialog.

dlg.set_image_file : Set an image to the ImageCtrl.
