# Test.Connection.RRod()

Test.Connection.RRod()

Description​

Create RRod

Syntax​

Test.Connection.RRod(rbarConnection=RBAR_CONNECTION(), iUlDOFs=1, dTol=0.0, crlMasterTargets=[], crlSlaveTargets=[])

Ribbon: Test » Connection » RRod

Inputs​

rbarConnection​

A RBAR_CONNECTION specifying the connection.

The default value is RBAR_CONNECTION().

iUlDOFs​

An Integer specifying the ul d o fs.

The default value is 1.

dTol​

A Double specifying the tolerance.

The default value is 0.0.

crlMasterTargets​

A List of Cursor specifying the master target.

The default value is [].

crlSlaveTargets​

A List of Cursor specifying the slave target.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Test.Connection.RRod(rbarConnection=RBAR_CONNECTION(), iUlDOFs=1, dTol=0.0, crlMasterTargets=[], crlSlaveTargets=[])
