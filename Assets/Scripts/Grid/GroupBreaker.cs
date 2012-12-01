/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;
using System.Collections.Generic;

public class GroupBreaker : MonoBehaviour
{
	private Grid grid;

	public void Start()
	{
		grid = GetComponent<Grid>();
	}

	public void Break(IntVector2 cell)
	{
		Debug.Log("Breaking cell " + cell);
	}
}