/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
public class PieceSpawnEvent : MozEvent
{
	public int row;
	public int column;
	public int piece;
	
	public PieceSpawnEvent (float time, int column, int row, int piece)
	{
		this.type = MozEventType.PieceSpawn;
		this.time = time;
		this.row = row;
		this.column = column;
		this.piece = piece;
	}
	
	override public string ToString ()
	{
		return "PieceSpawnEvent [time: " + time + ", row:" + row + ", column:" + column + ", piece:" + piece + "]";	
	}
}

	