/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

public class PieceSpawnEvent : MozEvent
{
	public int id;
	public int row;
	public int column;
	public int piece;
	
	public PieceSpawnEvent(int frame, int row, int column, int piece)
	{
		this.initial = "S";
		this.type = MozEventType.PieceSpawn;
		this.frame = frame;
		this.id = -1;
		this.row = row;
		this.column = column;
		this.piece = piece;
	}
	
	override public string ToString()
	{
		return "PieceSpawnEvent [frame: " + frame + ", id: " + id + ", row:" + row + ", column:" + column + ", piece:" + piece + "]";
	}
}

	