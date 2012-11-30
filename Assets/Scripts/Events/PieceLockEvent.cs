/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

public class PieceLockEvent : MozEvent
{
	public int id;
	public int row;
	public int column;
	public int piece;
	public bool grouped;
	
	public PieceLockEvent(int frame, int id, int row, int column, int piece)
	{
		this.initial = "L";
		this.type = MozEventType.PieceLock;
		this.frame = frame;
		this.id = id;
		this.row = row;
		this.column = column;
		this.piece = piece;
		this.grouped = false;
	}
	
	override public string ToString()
	{
		return "PieceLockEvent [frame: " + frame + ", id: " + id + ", column:" + column + ", piece:" + piece + "]";
	}
}

	