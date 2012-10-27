/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

public class Piece : MonoBehaviour
{
	public int id = -1;
	public int type = 0;
	public bool moving = false;
	public int row = 0;
	public int column = 0;
	
	public void Enable()
	{
		enabled = true;
		renderer.enabled = true;
	}
	
	public void Disable()
	{
		enabled = false;
		renderer.enabled = false;
	}
}
