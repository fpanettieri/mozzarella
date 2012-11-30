/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

public class PieceGroups
{
	public bool tl = false;
	public bool bl = false;
	public bool tr = false;
	public bool br = false;

	public void Clear()
	{
		tl = false;
		bl = false;
		tr = false;
		br = false;
	}

	public bool Grouped()
	{
		return tl || bl || tr || br;
	}

	public int Count()
	{
		int count = 0;
		if(tl){ count++; }
		if(bl){ count++; }
		if(tr){ count++; }
		if(br){ count++; }
		return count;
	}

	override public string ToString()
	{
		return Count().ToString();
	}
}
