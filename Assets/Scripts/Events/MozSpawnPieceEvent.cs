/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-09-29
 @last-edit		2012-09-29
===============================================================================
*/
public class MozSpawnPieceEvent : MozEvent
{
	public int row;
	public int column;
	
	public MozSpawnPieceEvent ( float time, int row, int column )
	{
		this.time = time;
		this.row = row;
		this.column = column;
	}
	
	override public string ToString()
	{
		return "MozSpawnPieceEvent [time: " + time + ", row:" + row + ", column:" + column + "]";	
	}
}

