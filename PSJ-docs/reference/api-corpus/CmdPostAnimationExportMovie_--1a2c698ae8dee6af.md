# CmdPostAnimationExportMovie()

CmdPostAnimationExportMovie()

Description​

Export animation

Notice

This command is replaced with CmdPostAnimationExportMovieToFile in V5.1.

Syntax​

CmdPostAnimationExportMovie(string PathName, int Codec, int FramePerSecond, int Repeat, bool MakeImage, int screenWidth, int screenHeight, bool Optimization)

Inputs​

1. string ​

The full path to the exporting animation.

2. int ​

Codec option. 0: Intel IYUV codec, 1:Intel IYUV codec, 2: Microsoft Video 1, 3: TechSmith Screen Capture Codec, 4: TechSmith Screen Codec 2.

3. int ​

Frame Per Second.

4. int ​

Repeat.

5. bool ​

Make Image option. 0: No, 1: Yes.

6. int ​

Screen width.

7. int ​

Screen height.

8. bool ​

Optimization animation if True(1).

Return Code​

Nothing.

Sample Code​

CmdPostAnimationExportMovie("C:/Users/Admin/Pictures/1.avi", 0, 5, 1, 0)
CmdPostAnimationExportMovie("C:/Users/Admin/Videos/opt.gif", 0, 5, 1, 1, 0, 0, 1)
