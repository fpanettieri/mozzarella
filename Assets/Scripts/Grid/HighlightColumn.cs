/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

public class HighlightColumn : MonoBehaviour
{
	// dependencies
	private Grid grid;
	private GridInput input;

	// Aux variables
	private int column;

	public void Start ()
	{
		grid = GameObject.Find(GameObjectName.GRID).GetComponent<Grid>();
		input = GameObject.Find(GameObjectName.GRID).GetComponent<GridInput>();
	}

	public void Update ()
	{
		if(input.InsideGrid(Input.mousePosition)) {
			column = Mathf.FloorToInt((Input.mousePosition.x - input.left) / input.cellWidth);
			if(column == grid.columns - 1){ column--; }
			transform.position = new Vector3(column * input.cellWidth, 0, transform.position.z);
		}
	}
}
