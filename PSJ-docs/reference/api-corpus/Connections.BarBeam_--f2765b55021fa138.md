# Connections.BarBeam()

Connections.BarBeam()

Description​

Create Connections Bar or Beam.

Syntax​

Connections.BarBeam(...)

Ribbon: Connections » BarBeam

Inputs​

strName​

A String specifying the name.

This is a required input.

iEType​

An Integer specifying the e type.

The default value is 10.

iMethod​

An Integer specifying the method.

The default value is 1.

crProp​

A Cursor specifying the property.

The default value is None.

dlOrient​

A Double List specifying the orient.

The default value is [].

crlMasterTargets​

A List of Cursor specifying the master target.

The default value is [].

crlSlaveTargets​

A List of Cursor specifying the slave target.

The default value is [].

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Connections.BarBeam(strName, iEType=10, iMethod=1, crProp=None, dlOrient=[], crlMasterTargets=[], crlSlaveTargets=[])
