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
	// dependencies
	private Grid grid;
	private PiecePool pool;

	// internal state
	private List<int> broken;
	private Stack<IntVector2> stack;
	private List<int> falling;

	// aux variables
	private Piece piece;
	private int columns;
	private IntVector2 cell;

	public void Start()
	{
		grid = GetComponent<Grid>();
		pool = GetComponent<PiecePool>();
		columns = grid.columns;
	}

	public void Break(IntVector2 touched)
	{
		FloodFill(touched);
		SpawnPoints();
		BreakPieces();
		DropPieces();
		UpdateTimeline();
	}

	private void FloodFill(IntVector2 touched)
	{
		broken = new List<int>();
		stack = new Stack<IntVector2>();
		falling = new List<int>();
		stack.Push(touched);

		int id, idx, type;
		while(stack.Count > 0) {
			cell = stack.Pop();

			idx = cell.x + cell.y * columns;
			type = grid.pieceTypes[idx];

			// empty cells id == -1
			id = grid.pieceId[idx];
			if(id == -1){ continue; }

			// if not grouped, ignore it
			piece = pool[id];
			if(!piece.Grouped()){ continue; }

			broken.Add(id);
			grid.pieceTypes[idx] = PieceType.Empty;
			grid.pieceId[idx] = -1;

			if(cell.x > 0 && grid.pieceTypes[idx - 1] == type){
				stack.Push(new IntVector2(cell.x - 1, cell.y));
			}

			if(cell.x < columns - 1 && grid.pieceTypes[idx + 1] == type){
				stack.Push(new IntVector2(cell.x + 1, cell.y));
			}

			if(cell.y > 0 && grid.pieceTypes[idx - columns] == type){
				stack.Push(new IntVector2(cell.x, cell.y - 1));
			}

			if(cell.y < grid.rows - 1 && grid.pieceTypes[idx + columns] == type){
				stack.Push(new IntVector2(cell.x, cell.y + 1));
			}
		}
	}

	private void SpawnPoints()
	{
		// TODO: add score
		// TODO: make streak higher
		// TODO: spawn piece part to float into the score thingy
	}

	private void BreakPieces()
	{
		int idx;
		for(int i = 0; i < broken.Count; i++){
			piece = pool[broken[i]];
			idx = piece.column + piece.row * columns;

			if(piece.row < grid.rows - 1 &&	grid.pieceId[idx + columns] > -1){
				falling.Add(grid.pieceId[idx + columns]);
			}

			pool.Release(piece.id);
			piece.moving = false;
			piece.column = 0;
			piece.row = 0;
			piece.groups.Clear();
			piece.Disable();
		}
	}

	private void DropPieces()
	{
		int id, idx;
		Piece basePiece;
		for(int i = 0; i < falling.Count; i++){
			basePiece = pool[falling[i]];
			for(int j = basePiece.row; j < grid.rows; j++){
				idx = basePiece.column + j * columns;
				id = grid.pieceId[idx];
				if(id < 0){ continue; }
				piece = pool[id];
				piece.moving = true;
				grid.pieceTypes[idx] = PieceType.Empty;
				grid.pieceId[idx] = -1;
				grid.movingPieces.Add(piece);
			}
		}
	}

	private void UpdateTimeline()
	{

	}
}