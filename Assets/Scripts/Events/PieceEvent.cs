/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

public class PieceEvent : MozEvent
{
	public int id;
	public int row;
	public int column;
	public int piece;
	
	public PieceEvent(int type, int frame, int id, int row, int column, int piece)
	{
		this.type = type;
		this.frame = frame;
		this.id = id;
		this.row = row;
		this.column = column;
		this.piece = piece;
	}
	
	override public string ToString()
	{
		return "PieceSpawnEvent [frame: " + frame + ", row:" + row + ", column:" + column + ", piece:" + piece + "]";	
	}
}

	