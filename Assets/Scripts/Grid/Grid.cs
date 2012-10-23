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
	private Piece auxPiece;
	private Vector3	tileSize;
	private Vector3 pieceProj;
	private IntVector2 pieceCell;
	
	public void Awake()
	{
		timeline = GameObject.Find(GameObjectName.TIME).GetComponent<Timeline>();
		tileSize = piecePrefab.GetComponent<MeshFilter>().sharedMesh.bounds.size;
		pieceProj = new Vector3(0, 0, 0);
		pieceCell = new IntVector2(0, 0);
		movingPieces = new List<Piece>();	
	}
	
	public void Update()
	{
		// Move pieces	
		foreach(Piece piece in movingPieces) {
			// Update piece position
			piece.Project(ref pieceProj);
			pieceCell.Set(Mathf.FloorToInt(pieceProj.x / tileSize.x), Mathf.FloorToInt(pieceProj.y / tileSize.y));
			
			if(pieceCell.y >= rows) {
				// if the piece has gone up too far, ignore it
				
				// Piece touches the floor
			} else if(pieceCell.y < 0) {
				pieceProj.Set(pieceProj.x, 0, pieceProj.z);
				piece.moving = false;
				
				// TODO: play sound smash sfx
						
				// piece reaches an occupied cell
			} else if(cells[pieceCell.x + pieceCell.y * columns] != PieceType.Empty) { 
				pieceProj.Set(pieceProj.x, Mathf.Ceil(pieceProj.y / tileSize.y) * tileSize.y, pieceProj.z);
				piece.moving = false;
				
				// TODO: play piece collision sfx
			}

			// Move piece
			piece.transform.localPosition = pieceProj;
		}

		// Only lock pieces if moving forward
		if(TimeMachine.rewind) {
			return;
		}

		// Lock pieces
		for(int i = movingPieces.Count - 1; i >= 0; i--) {
			auxPiece = movingPieces[i];
			if(auxPiece.moving) {
				continue;
			}
			movingPieces.RemoveAt(i);

			pieceCell.Set(Mathf.FloorToInt(auxPiece.transform.localPosition.x / tileSize.x),
				Mathf.FloorToInt(auxPiece.transform.localPosition.y / tileSize.y));

			cells[pieceCell.x + pieceCell.y * columns] = auxPiece.type;
			timeline.Insert(TimeMachine.idx, new PieceEvent(MozEventType.PieceLock, TimeMachine.now, auxPiece.id, pieceCell.y, pieceCell.x, auxPiece.type));
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
