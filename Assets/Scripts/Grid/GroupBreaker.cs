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
	private Timeline timeline;

	// internal state
	private List<int> broken;
	private Stack<IntVector2> stack;
	private List<int> floating;
	private List<int> falling;

	// aux variables
	private Piece piece;
	private int columns;
	private IntVector2 cell;

	public void Start()
	{
		grid = GetComponent<Grid>();
		pool = GetComponent<PiecePool>();
		timeline = GameObject.Find(GameObjectName.TIME).GetComponent<Timeline>();
		columns = grid.columns;

		broken = new List<int>();
		stack = new Stack<IntVector2>();
		floating = new List<int>();
		falling = new List<int>();
	}

	public void Break(IntVector2 touched)
	{
		Clear();
		FloodFill(touched);
		SpawnPoints();
		BreakPieces();
		DropPieces();
	}
	private void Clear()
	{
		broken.Clear();
		stack.Clear();
		floating.Clear();
		falling.Clear();
	}

	private void FloodFill(IntVector2 touched)
	{
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
				floating.Add(grid.pieceId[idx + columns]);
			}

			// purge piece events
			timeline.Purge(piece.id, piece.spawned, piece.locked);

			pool.Release(piece.id);
			piece.moving = false;
			piece.column = 0;
			piece.row = 0;
			piece.groups.Clear();
			piece.Disable();
			piece.spawned = false;
			piece.locked = false;
		}
	}

	private void DropPieces()
	{
		int id, idx;
		Piece basePiece;
		for(int i = 0; i < floating.Count; i++){

			basePiece = pool[floating[i]];
			for(int j = basePiece.row; j < grid.rows; j++){
				idx = basePiece.column + j * columns;
				id = grid.pieceId[idx];
				if(id < 0){ continue; }

				// make piece fall
				piece = pool[id];
				piece.moving = true;
				grid.pieceTypes[idx] = PieceType.Empty;
				grid.pieceId[idx] = -1;
				grid.movingPieces.Add(piece);

				// purge piece spawn only
				timeline.Purge(piece.id, piece.spawned, piece.locked);

				// update groups
				if(piece.groups.tl){
					if(piece.column > 0 && piece.type == grid.pieceTypes[idx - 1]){
						pool[grid.pieceId[idx - 1]].groups.tr = false;														// left
					}
					if(piece.row < grid.rows - 1 && piece.type == grid.pieceTypes[idx + columns]){
						pool[grid.pieceId[idx + columns]].groups.bl = false;												// top
					}
					if(piece.column > 0 && piece.row < grid.rows - 1 && piece.type == grid.pieceTypes[idx + columns - 1]){
						pool[grid.pieceId[idx + columns - 1]].groups.br = false;											// tl
					}
				}

				if(piece.groups.bl){
					if(piece.column > 0 && piece.type == grid.pieceTypes[idx - 1]){
						pool[grid.pieceId[idx - 1]].groups.br = false;														// left
					}
					if(piece.row > 0 && piece.type == grid.pieceTypes[idx - columns]){
						pool[grid.pieceId[idx - columns]].groups.tl = false;												// bottom
					}
					if(piece.column > 0 &&  piece.row > 0 && piece.type == grid.pieceTypes[idx - columns - 1]){
						pool[grid.pieceId[idx - columns - 1]].groups.tr = false;											// bl
					}
				}

				if(piece.groups.tr){
					if(piece.column < grid.columns - 1 && piece.type == grid.pieceTypes[idx + 1]){
						pool[grid.pieceId[idx + 1]].groups.tl = false;														// right
					}
					if(piece.row < grid.rows - 1 && piece.type == grid.pieceTypes[idx + columns]){
						pool[grid.pieceId[idx + columns]].groups.br = false;												// top
					}
					if(piece.column < grid.columns - 1  && piece.row < grid.rows - 1 && piece.type == grid.pieceTypes[idx + columns + 1]){
						pool[grid.pieceId[idx + columns + 1]].groups.bl = false;											// tr
					}
				}

				if(piece.groups.br){
					if(piece.column < grid.columns - 1  && piece.type == grid.pieceTypes[idx + 1]){
						pool[grid.pieceId[idx + 1]].groups.bl = false;														// right
					}
					if(piece.row > 0 && piece.type == grid.pieceTypes[idx - columns]){
						pool[grid.pieceId[idx - columns]].groups.tr = false;												// bottom
					}
					if(piece.column < grid.columns - 1 && piece.row > 0 && piece.type == grid.pieceTypes[idx - columns + 1]){
						pool[grid.pieceId[idx - columns + 1]].groups.tl = false;											// br
					}
				}

				piece.groups.Clear();
			}
		}
	}
}