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
	public int id;
	public int type;
	public bool moving;
	public int row;
	public int column;
	public PieceGroups groups;

	public Piece()
	{
		id = -1;
		type = 0;
		moving = false;
		row = 0;
		column = 0;
		groups = new PieceGroups();
	}
	
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
