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
	private Grid grid;
	private TimeMachine timemachine;
	private PieceQueue queue;
	private IntVector2 cell;
	private IntVector2 firstHalf;
	private IntVector2 secondHalf;
	private Piece piece;

	void Awake()
	{
		cell = new IntVector2(0, 0);
		grid = GetComponent<Grid>();
		queue = GetComponent<PieceQueue>();
		timemachine = GameObject.Find(GameObjectName.TIME).GetComponent<TimeMachine>();
		firstHalf = new IntVector2(0, 0);
		secondHalf = new IntVector2(0, 0);
	}

	void Update()
	{
		if(TimeMachine.rewind) {
			return;
		}
		// TODO: verify if the space is ocuppied on mouse down, not mouseup.
		// if( grid.cells[ cell.x + cell.y * grid.columns ] == PieceType.Empty ){

		// Detect touched cell
		if(Input.GetMouseButtonUp(0) && InsideGrid(Input.mousePosition)) {
			cell.Set(Mathf.FloorToInt((Input.mousePosition.x - left) / cellWidth), Mathf.FloorToInt((Input.mousePosition.y - bottom) / cellHeight));

			firstHalf.Set(cell.x, grid.rows - 1);
			secondHalf.Set((cell.x + 1) % grid.columns, grid.rows - 1);
			if(CellsOccupied()) {
				return;
			}

			timemachine.Broadcast(new PieceSpawnEvent(TimeMachine.frame, firstHalf.y, firstHalf.x, queue.Next()));
			timemachine.Broadcast(new PieceSpawnEvent(TimeMachine.frame, secondHalf.y, secondHalf.x, queue.Next()));
		}
	}
	
	private bool InsideGrid(Vector3 v)
	{
		return v.x > left && v.x < right && v.y > bottom && v.y < top;
	}

	private bool CellsOccupied()
	{
		if(grid.cells[firstHalf.x + firstHalf.y * grid.columns] != PieceType.Empty ||
		   grid.cells[secondHalf.x + secondHalf.y * grid.columns] != PieceType.Empty) {
			return true;
		}

		for(int i = 0; i < grid.movingPieces.Count; i++) {
			piece = grid.movingPieces[i];
			if((piece.row == firstHalf.y && piece.column == firstHalf.x) ||
			   (piece.row == secondHalf.y && piece.column == secondHalf.x)) {
				return true;
			}
		}

		return false;
	}
}
