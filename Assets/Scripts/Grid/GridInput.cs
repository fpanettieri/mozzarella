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
	// Dependencies
	private Grid grid;
	private TimeMachine timemachine;
	private PieceQueue queue;
	private PiecePool pool;
	private GroupBreaker breaker;

	// Inspector properties
	public int bottom;
	public int left;
	public int top;
	public int right;
	public int cellWidth;
	public int cellHeight;

	// Internal state
	private IntVector2 cell;
	private IntVector2 leftPiece;
	private IntVector2 rightPiece;
	private Piece piece;

	public void Start()
	{
		cell = new IntVector2(0, 0);

		timemachine = GameObject.Find(GameObjectName.TIME).GetComponent<TimeMachine>();
		grid = GetComponent<Grid>();
		queue = GetComponent<PieceQueue>();
		pool = GetComponent<PiecePool>();
		breaker = GetComponent<GroupBreaker>();

		leftPiece = new IntVector2(0, 0);
		rightPiece = new IntVector2(0, 0);
	}

	public void Process()
	{
		if(TimeMachine.rewind) { return; }

		// Detect touched cell
		if(Input.GetMouseButtonUp(0) && InsideGrid(Input.mousePosition)) {
			UpdateCell();

			leftPiece.Set(cell.x, grid.rows - 1);
			rightPiece.Set((cell.x + 1) % grid.columns, grid.rows - 1);

			// REVIEW: game should allow the user to make stupid moves?
			if(CellsOccupied()) { return; }

			timemachine.Broadcast(new PieceSpawnEvent(TimeMachine.frame, -1, leftPiece.y, leftPiece.x, queue.Next()));
			timemachine.Broadcast(new PieceSpawnEvent(TimeMachine.frame, -1, rightPiece.y, rightPiece.x, queue.Next()));
		}

		// Detect touched cell
		if(Input.GetMouseButtonUp(1) && InsideGrid(Input.mousePosition)) {
			UpdateCell();
			int id = grid.pieceId[ cell.x + cell.y * grid.columns ];
			if( id > -1 && pool[id].Grouped() ){
				breaker.Break(cell);
			}
		}
	}

	private void UpdateCell()
	{
		cell.Set(
			Mathf.FloorToInt((Input.mousePosition.x - left) / cellWidth),
			Mathf.FloorToInt((Input.mousePosition.y - bottom) / cellHeight)
		);
		if(cell.x == grid.columns - 1){ cell.x--; }
	}
	
	public bool InsideGrid(Vector3 v)
	{
		return v.x > left && v.x < right && v.y > bottom && v.y < top;
	}

	private bool CellsOccupied()
	{
		if(grid.pieceTypes[leftPiece.x + leftPiece.y * grid.columns] != PieceType.Empty ||
		   grid.pieceTypes[rightPiece.x + rightPiece.y * grid.columns] != PieceType.Empty) {
			Events.i.Notify(new GameOverEvent());
			return false;
		}

		for(int i = 0; i < grid.movingPieces.Count; i++) {
			piece = grid.movingPieces[i];
			if((piece.row == leftPiece.y && piece.column == leftPiece.x) ||
			   (piece.row == rightPiece.y && piece.column == rightPiece.x)) {
				return true;
			}
		}

		return false;
	}
}
