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
	private GridInput input;
	private TimeMachine timemachine;

	// Inspector properties
	public GameObject piecePrefab;
	public int rows = 0;
	public int columns = 0;
	public int[] pieceTypes;
	public int[] pieceId;
	public List<Piece> movingPieces;

	// Private / aux properties
	private Piece piece;
	private Vector3	tileSize;
	private Vector3 pieceProj;
	private bool collision;
	
	public void Awake()
	{
		input = GetComponent<GridInput>();
		timemachine = GameObject.Find(GameObjectName.TIME).GetComponent<TimeMachine>();
		tileSize = piecePrefab.GetComponent<MeshFilter>().sharedMesh.bounds.size;
		movingPieces = new List<Piece>();
		pieceProj = new Vector3(0, 0, 0);
		collision = false;
		pieceId = new int[pieceTypes.Length];
		for(int i = 0; i < pieceTypes.Length; i++){
			pieceId[i] = pieceTypes[i] > 0 ? 0 : -1;
		}
	}

	// update
	public void Update()
	{
		//return;

		// FIXME: cheat used to skip frames
		if(TimeMachine.skip) {
			return;
		}

		input.Process();
		DropPieces();
		do {
			ResolveCollisions();
		} while ( collision );
		
		MovePieces();
		LockPieces();
	}

	private void DropPieces()
	{
		for(int i = 0; i < movingPieces.Count; i++) {
			piece = movingPieces[i];
			if(TimeMachine.rewind) {
				piece.row++;
			} else {
				piece.row--;
			}
		}
	}

	private void ResolveCollisions()
	{
		collision = false;
		for(int i = 0; i < movingPieces.Count; i++) {
			piece = movingPieces[i];
			if(!piece.moving) {	continue; }
			if(piece.row >= rows){
				timemachine.Broadcast(new PieceSpawnEvent(TimeMachine.frame + 1, piece.id, rows - 1, piece.column, piece.type));

			} else if(piece.row == 0) {
				piece.moving = false;
				collision = true;
			} else if(pieceTypes[piece.column + (piece.row - 1) * columns] != PieceType.Empty) {
				piece.moving = false;
				collision = true;
			}
			if(!piece.moving) {
				pieceTypes[piece.column + piece.row * columns] = piece.type;
				pieceId[piece.column + piece.row * columns] = piece.id;
			}
		}
	}

	private void LockPieces()
	{
		// Only lock pieces if moving forward
		if(TimeMachine.rewind) {
			return;
		}
		for(int i = movingPieces.Count - 1; i >= 0; i--) {
			piece = movingPieces[i];
			if(piece.moving) { continue; }
			timemachine.Broadcast(new PieceLockEvent(TimeMachine.frame, piece.id, piece.row, piece.column, piece.type));
		}
	}

	private void MovePieces()
	{
		for(int i = 0; i < movingPieces.Count; i++) {
			piece = movingPieces[i];
			pieceProj.Set(piece.column * tileSize.x, piece.row * tileSize.y, 0);
			piece.transform.localPosition = pieceProj;
		}
	}

}
