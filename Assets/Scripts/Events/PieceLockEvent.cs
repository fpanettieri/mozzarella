/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
public class PieceLockEvent : MozEvent
{
	public int row;
	public int column;
	public int piece;
	
	public PieceLockEvent (float time, int column, int row, int piece)
	{
		this.type = MozEventType.PieceLock;
		this.time = time;
		this.row = row;
		this.column = column;
		this.piece = piece;
	}
	
	override public string ToString ()
	{
		return "PieceLockEvent [time: " + time + ", row:" + row + ", column:" + column + ", piece:" + piece + "]";	
	}
}

	