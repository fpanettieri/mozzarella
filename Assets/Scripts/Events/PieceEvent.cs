/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
public class PieceEvent : MozEvent
{
	public int id;
	public int row;
	public int column;
	public int piece;
	
	public PieceEvent (int type, float time, int id, int row, int column, int piece)
	{
		this.type = type;
		this.time = time;
		this.id = -1;
		this.row = row;
		this.column = column;
		this.piece = piece;
	}
	
	override public string ToString ()
	{
		return "PieceSpawnEvent [time: " + time + ", row:" + row + ", column:" + column + ", piece:" + piece + "]";	
	}
}

	