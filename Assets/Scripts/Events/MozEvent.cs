/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using System;
using System.Collections.Generic;

/**
 * An event an occurrence at a particular point in time. It
 * indicates that something happens at that given time.
 * 
 * All events inherit from this class.
 */
public class MozEvent : IComparable<MozEvent>
{
	public string initial = "E";
	public int type;
	public int frame = 0;
	public bool enabled = true;
	
	public int CompareTo(MozEvent b)
	{
		return frame < b.frame ? -1 : 1;
	}
	
	override public string ToString()
	{
		return "MozEvent [frame: " + frame + "]";
	}
}
