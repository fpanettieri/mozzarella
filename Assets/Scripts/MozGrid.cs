/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-08-30
 @last-edit		2012-08-30
===============================================================================
*/
using UnityEngine;
using System.Collections.Generic;

public class MozGrid : MonoBehaviour
{
	// Inspector properties
	public GameObject piecePrefab;
	public int rows = 0;
	public int columns = 0;
	public int[] cells;
	private List<MozPiece> movingPieces;
	private Vector3	tileSize;
	private Vector3 pieceProj;
	private IntVector2 pieceCell;
	
	void Start ()
	{
		tileSize = piecePrefab.GetComponent<MeshFilter> ().sharedMesh.bounds.size;
		pieceProj = new Vector3 (0, 0, 0);
		pieceCell = new IntVector2 (0, 0);
		
		// FIXME: remove this. this won't be needed when we add commands
		MozPiece[] pieces = GetComponentsInChildren<MozPiece> ();
		movingPieces = new List<MozPiece> ();
		foreach (MozPiece piece in pieces) {
			if (piece.moving) {
				movingPieces.Add (piece);
				int row = Mathf.FloorToInt (piece.transform.localPosition.y / tileSize.y);
				int column = Mathf.FloorToInt (piece.transform.localPosition.x / tileSize.x);
				cells [column + row * columns] = PieceType.Empty;
			}
		}
	}
	
	void Update ()
	{
		MovePieces ();
		LockPieces ();
	}
	
	private void MovePieces ()
	{
		foreach (MozPiece piece in movingPieces) {
			// Update piece position
			piece.Project (ref pieceProj);
			pieceCell.Set (Mathf.FloorToInt (pieceProj.x / tileSize.x), Mathf.FloorToInt (pieceProj.y / tileSize.y));
			
			// Snap to grid if: Floor reached
			if (pieceCell.y < 0) {
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
		MozPiece piece;
		for (int i = movingPieces.Count - 1; i > 0; i--) {
			piece = movingPieces [i];
			if (!piece.moving) {
				movingPieces.RemoveAt (i);
				pieceCell.Set (Mathf.FloorToInt (piece.transform.localPosition.x / tileSize.x),
					Mathf.FloorToInt (piece.transform.localPosition.y / tileSize.y));
				cells [pieceCell.x + pieceCell.y * columns] = piece.type;
			}
		}
	}		
}
