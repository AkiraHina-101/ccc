# JPT.DisableOutputMessage()

JPT.DisableOutputMessage()

Description​

Disable all the output messages which will be written to the Python API window.

The output message will be enabled after finishing executing the PSJ code.

Or using JPT.EnableOutputMessage() to turn it on again.

Syntax​

JPT.DisableOutputMessage(messageType)

Inputs​

messageType​

An Enum specifying the MessageConsoleType describing the message type to be hidden.

This is a required input.

Return Code​

This utility function does not have output value.

Sample Code​

# Disable the execution message
JPT.DisableOutputMessage(JPT.MsgConsoleType.MSG_EXECUTION)
Geometry.Part.Cube(strName="Cube_2", iPartColor=12934597) # won't print "CreateCube" [0.0, 0.0, 0.0],...
print("test")
JPT.Debugger("Test")

# Disable the return message
JPT.DisableOutputMessage(JPT.MsgConsoleType.MSG_RETURN)
Geometry.Part.Cube(strName="Cube_2", iPartColor=12934597) # won't print 3:1
print("test")
JPT.Debugger("Test")

# Disable the user message (print/debug message)
JPT.DisableOutputMessage(JPT.MsgConsoleType.MSG_USER)
Geometry.Part.Cube(strName="Cube_2", iPartColor=12934597)
print("test") # won't print "test"
JPT.Debugger("Test") # won't print "Test"
