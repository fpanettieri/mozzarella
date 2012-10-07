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
	// Inspector properties
	public GameObject piecePrefab;
	public int rows = 0;
	public int columns = 0;
	public int[] cells;
	private List<Piece> movingPieces;
	private Vector3	tileSize;
	private Vector3 pieceProj;
	private IntVector2 pieceCell;
	private Timeline timeline;
	
	public void Awake ()
	{
		tileSize = piecePrefab.GetComponent<MeshFilter> ().sharedMesh.bounds.size;
		pieceProj = new Vector3 (0, 0, 0);
		pieceCell = new IntVector2 (0, 0);
		movingPieces = new List<Piece> ();
		
		timeline = GameObject.Find (GameObjectName.TIME).GetComponent<Timeline> ();
	}
	
	public void Update ()
	{
		MovePieces ();
		LockPieces ();
	}
	
	public void AddPiece (Piece piece)
	{
		movingPieces.Add (piece);
	}
	
	public Piece FindPiece (int id)
	{
		foreach (Piece piece in movingPieces) {
			if (piece.id == id) {
				return piece;
			}
		}
		return null;
	}
	
	public void RemovePiece (Piece piece)
	{
		movingPieces.Remove( piece );
	}
	
	private void MovePieces ()
	{
		foreach (Piece piece in movingPieces) {
			// Update piece position
			piece.Project (ref pieceProj);
			pieceCell.Set (Mathf.FloorToInt (pieceProj.x / tileSize.x), Mathf.FloorToInt (pieceProj.y / tileSize.y));
			
			if (pieceCell.y >= rows){
				// if the piece has gone up too far, ignore it
				
			// Piece touches the floor
			} else if (pieceCell.y < 0) {
				pieceProj.Set (pieceProj.x, 0, pieceProj.z);
				piece.moving = false;
				
				// TODO: play sound smash sfx
						
				// piece reaches an occupied cell
			} else if (cells [pieceCell.x + pieceCell.y * columns] != PieceType.Empty) { 
				pieceProj.Set (pieceProj.x, Mathf.Ceil (pieceProj.y / tileSize.y) * tileSize.y, pieceProj.z);
				piece.moving = false;
				
				// TODO: play piece collision sfx
			}
			
			// Move piece
			piece.transform.localPosition = pieceProj;
		}
	}
	
	private void LockPieces ()
	{
		// Only lock pieces if moving forward
		if( TimeMachine.rewind ){ return; }
	
		Piece piece;
		for (int i = movingPieces.Count - 1; i >= 0; i--) {
			piece = movingPieces [i];
			if (piece.moving) {	continue; }
			movingPieces.RemoveAt (i);
			
			pieceCell.Set (Mathf.FloorToInt (piece.transform.localPosition.x / tileSize.x),
				Mathf.FloorToInt (piece.transform.localPosition.y / tileSize.y));
			cells [pieceCell.x + pieceCell.y * columns] = piece.type;

			timeline.Insert (TimeMachine.idx, new PieceLockEvent (TimeMachine.now, pieceCell.x, pieceCell.y, piece.type));
		}
	}		
}
