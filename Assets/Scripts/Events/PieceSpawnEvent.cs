/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-09-29
 @last-edit		2012-09-29
===============================================================================
*/
public class PieceSpawnEvent : MozEvent
{
	public int row;
	public int column;
	
	public PieceSpawnEvent ( float time, int row, int column )
	{
		this.time = time;
		this.row = row;
		this.column = column;
	}
	
	override public string ToString()
	{
		return "PieceSpawnEvent [time: " + time + ", row:" + row + ", column:" + column + "]";	
	}
}

