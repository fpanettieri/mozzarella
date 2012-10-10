/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

public class PieceQueue : MonoBehaviour
{
	public int Next()
	{
		return Mathf.FloorToInt(Random.value * 5) + 1;	
	}
}
