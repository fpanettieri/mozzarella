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
	public MeshRenderer highlight;

	public int id;
	public int type;
	public bool moving;
	public int row;
	public int column;
	public PieceGroups groups;
	public bool spawned;
	public bool locked;

	public Piece()
	{
		id = -1;
		type = 0;
		moving = false;
		row = 0;
		column = 0;
		groups = new PieceGroups();
		spawned = false;
		locked = false;
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

	public bool Grouped()
	{
		return groups.tl || groups.bl || groups.tr || groups.br;
	}

	public void Highlight()
	{
		if(!highlight.enabled && Grouped()){
			highlight.enabled = true;
		}
	}

	public void Darken()
	{
		if(highlight.enabled && !Grouped()){
			highlight.enabled = false;
		}
	}
}
