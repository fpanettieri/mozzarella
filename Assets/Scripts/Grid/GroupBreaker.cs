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

	// aux variables
	private Piece piece;

	public void Start()
	{
		grid = GetComponent<Grid>();
		pool = GetComponent<PiecePool>();
	}

	public void Break(IntVector2 touched)
	{
		int columns = grid.columns;
		Stack<IntVector2> stack = new Stack<IntVector2>();
		stack.Push(touched);

		int id, idx, type;
		IntVector2 cell;

		// make pieces fall
		// break groups

		while(stack.Count > 0) {
			cell = stack.Pop();
			idx = cell.x + cell.y * columns;
			type = grid.pieceTypes[idx];
			id = grid.pieceId[idx];
			if(id == -1){ continue; }
			piece = pool[id];
			if(!piece.Grouped()){ continue; }

			// destroy piece
			grid.pieceTypes[idx] = PieceType.Empty;
			grid.pieceId[idx] = -1;
			pool.Release(id);
			piece.moving = false;
			piece.column = 0;
			piece.row = 0;
			piece.groups.Clear();
			piece.Disable();

			// TODO: add score
			// TODO: make streak higher
			// TODO: spawn piece part to float into the score thingy

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
		// clear grid cells type, and collect its ids.
	}
}