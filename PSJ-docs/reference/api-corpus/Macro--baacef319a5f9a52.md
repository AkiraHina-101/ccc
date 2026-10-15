# Macro

Macro

  	.tb77fec00-0aa8-4330-9a35-20b7ef144216 {
	    color: #fff;
	    background: #222;
	    border: 1px solid transparent;
  	}

  	.tb77fec00-0aa8-4330-9a35-20b7ef144216.place-top {
        margin-top: -10px;
    }
    .tb77fec00-0aa8-4330-9a35-20b7ef144216.place-top::before {
        border-top: 8px solid transparent;
    }
    .tb77fec00-0aa8-4330-9a35-20b7ef144216.place-top::after {
        border-left: 8px solid transparent;
        border-right: 8px solid transparent;
        bottom: -6px;
        left: 50%;
        margin-left: -8px;
        border-top-color: #222;
        border-top-style: solid;
        border-top-width: 6px;
    }

    .tb77fec00-0aa8-4330-9a35-20b7ef144216.place-bottom {
        margin-top: 10px;
    }
    .tb77fec00-0aa8-4330-9a35-20b7ef144216.place-bottom::before {
        border-bottom: 8px solid transparent;
    }
    .tb77fec00-0aa8-4330-9a35-20b7ef144216.place-bottom::after {
        border-left: 8px solid transparent;
        border-right: 8px solid transparent;
        top: -6px;
        left: 50%;
        margin-left: -8px;
        border-bottom-color: #222;
        border-bottom-style: solid;
        border-bottom-width: 6px;
    }

    .tb77fec00-0aa8-4330-9a35-20b7ef144216.place-left {
        margin-left: -10px;
    }
    .tb77fec00-0aa8-4330-9a35-20b7ef144216.place-left::before {
        border-left: 8px solid transparent;
    }
    .tb77fec00-0aa8-4330-9a35-20b7ef144216.place-left::after {
        border-top: 5px solid transparent;
        border-bottom: 5px solid transparent;
        right: -6px;
        top: 50%;
        margin-top: -4px;
        border-left-color: #222;
        border-left-style: solid;
        border-left-width: 6px;
    }

    .tb77fec00-0aa8-4330-9a35-20b7ef144216.place-right {
        margin-left: 10px;
    }
    .tb77fec00-0aa8-4330-9a35-20b7ef144216.place-right::before {
        border-right: 8px solid transparent;
    }
    .tb77fec00-0aa8-4330-9a35-20b7ef144216.place-right::after {
        border-top: 5px solid transparent;
        border-bottom: 5px solid transparent;
        left: -6px;
        top: 50%;
        margin-top: -4px;
        border-right-color: #222;
        border-right-style: solid;
        border-right-width: 6px;
    }

Introduction​

Macro is equivalent to Jupiter built-in dialog function, but without a GUI.
For example:

CreateCube([0, 0, 0], [10, 10, 10], [10, 10, 10], "Cube_1", 7105764, 0:0) : Make a cube with default input values

ImprintLineS([[7.8, 0, 10], [2.2, 10, 10]], [6:26], 1) : Imprint a line on a face between 2 points

It is generated right after a dialog function successfully runs.

Macro can be recorded, run, save and reload using the Macro window. In the below picture, from left to right is: Macro Load, Save, Record, Rewind, Play, Next, Stop, Tool, ViewPoint:

Read more

To get the full list of available Macro, please refer to the Scripting API.
