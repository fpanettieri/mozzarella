/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;
using System.Collections;

/**
 * This class handles the input of the grid.
 * It dispatch piece spawn events or group break events.
 */ 
public class GridInput : MonoBehaviour
{
	public int bottom;
	public int left;
	public int top;
	public int right;
	public int cellWidth;
	public int cellHeight;
	private IntVector2 cell;
	private Grid grid;
	private Timeline timeline;
	private PieceQueue queue;

	void Start ()
	{
		cell = new IntVector2 (0, 0);
		grid = GetComponent<Grid> ();
		timeline = GameObject.Find (GameObjectName.TIME).GetComponent<Timeline> ();
		queue = GameObject.Find (GameObjectName.QUEUE).GetComponent<PieceQueue> ();
	}
	
	void Update ()
	{
		// TODO: verify if the space is ocuppied on mouse down, not mouseup.
		// if( grid.cells[ cell.x + cell.y * grid.columns ] == PieceType.Empty ){
		
		// TODO: add piece types to the event
		
		if (Input.GetMouseButtonUp (0) && InsideGrid (Input.mousePosition)) {
			cell.Set (Mathf.FloorToInt ((Input.mousePosition.x - left) / cellWidth), Mathf.FloorToInt ((Input.mousePosition.y - bottom) / cellHeight));
			
			timeline.Insert (TimeMachine.idx, new PieceSpawnEvent (TimeMachine.now, (cell.x + 1) % grid.columns, cell.y, queue.Next ()));
			timeline.Insert (TimeMachine.idx, new PieceSpawnEvent (TimeMachine.now, cell.x, cell.y, queue.Next ()));
		}
	}
	
	private bool InsideGrid (Vector3 v)
	{
		return v.x > left && v.x < right && v.y > bottom && v.y < top;
	}
}
