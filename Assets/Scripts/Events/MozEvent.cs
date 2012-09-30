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
	public int type;
	public float time = 0;
	public bool enabled = true;
	
	public int CompareTo (MozEvent b)
	{
		return time < b.time ? -1 : 1;
	}
	
	override public string ToString ()
	{
		return "MozEvent [time: " + time + "]";	
	}
}
