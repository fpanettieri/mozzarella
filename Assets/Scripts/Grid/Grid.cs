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

public class Grid : MonoBehaviour
{
	// Dependencies
	private Timeline timeline;
	
	// Inspector properties
	public GameObject piecePrefab;
	public int rows = 0;
	public int columns = 0;
	public int[] cells;
	public List<Piece> movingPieces;

	// Private / aux properties
	private Piece piece;
	private Vector3	tileSize;
	private Vector3 pieceProj;
	
	public void Awake()
	{
		timeline = GameObject.Find(GameObjectName.TIME).GetComponent<Timeline>();
		tileSize = piecePrefab.GetComponent<MeshFilter>().sharedMesh.bounds.size;
		movingPieces = new List<Piece>();
		pieceProj = new Vector3(0, 0, 0);
	}

	// update
	public void FixedUpdate()
	{
		// FIXME: cheat used to skip frames
		if(TimeMachine.skip){ return; }
		
		for(int i = 0; i < movingPieces.Count; i++){
			piece = movingPieces[i];

			// Update piece position
			cells[piece.column + piece.row * columns] = PieceType.Empty;
			if(TimeMachine.rewind){	piece.row++; }
			else { piece.row--;	}
			
			// if the piece has gone up too far, hold it there
			if(piece.row >= rows) {
				piece.row = rows - 1;
				// FIXME: should I destroy it here?
				
			// Piece touches the floor
			} else if(piece.row < 0) {
				piece.row = 0;
				piece.moving = false;
				
				// TODO: play sound smash sfx
						
			// piece reaches an occupied cell
			} else if(cells[piece.column + piece.row * columns] != PieceType.Empty) {

				// Update piece position
				if(TimeMachine.rewind){	piece.row--; }
				else { piece.row++;	}
				piece.moving = false;

				// TODO: play piece collision sfx
			}
			// Update grid
			cells[piece.column + piece.row * columns] = piece.type;

			// Move piece
			pieceProj.Set(piece.column * tileSize.x, piece.row * tileSize.y, 0);
			piece.transform.localPosition = pieceProj;
		}

		// Only lock pieces if moving forward
		if(TimeMachine.rewind) { return; }
		for(int i = movingPieces.Count - 1; i >= 0; i--) {
			piece = movingPieces[i];
			if(piece.moving) { continue; }
			movingPieces.RemoveAt(i);
			timeline.Insert(TimeMachine.idx, new PieceLockEvent(TimeMachine.frame - 2, piece.id, piece.row, piece.column, piece.type));
 		}
	}

	public void AddPiece(Piece piece)
	{
		movingPieces.Add(piece);
	}

	public void RemovePiece(Piece piece)
	{
		movingPieces.Remove(piece);
	}

}
