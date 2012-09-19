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
using System.Collections;

public class MozGrid : MonoBehaviour {
	
	public GameObject piecePrefab;
	public int rows = 0;
	public int columns = 0;
	public int[] cells;
	
	private MozPiece[] 	pieces;
	private Vector3		tileSize;
	
	void Start () {
		pieces = GetComponentsInChildren<MozPiece>();
		tileSize = piecePrefab.GetComponent<MeshFilter>().sharedMesh.bounds.size;
	}
	
	void Update () {
		MovePieces();
	}
	
	private void MovePieces() {
		Vector3 projection;
		foreach( MozPiece piece in pieces ){
			
			if ( piece.falling ){ 
				projection = piece.Project();
				
				if ( Collides( projection ) ){ 
					projection = SnapToGrid( projection ); 
					piece.falling = false;
				}
				
				MovePiece( piece, projection );
			}
		}
	}
	
	private bool Collides( Vector3 projection )
	{
		return cells[ CellIndex ( projection ) ] != PieceType.Empty;
	}
	
	private Vector3 SnapToGrid( Vector3 projection )
	{
		return new Vector3( projection.x, Mathf.Ceil( projection.y / tileSize.y ) * tileSize.y, projection.z );
	}
	
	private void MovePiece( MozPiece piece, Vector3 projection )
	{
		piece.transform.localPosition = projection;
		if( piece.falling == false) {
			cells[ CellIndex ( projection ) ] = piece.type;
		}
	}
	
	private int CellIndex( Vector3 projection )
	{
		int column = Mathf.FloorToInt( projection.x / tileSize.x );
		int row = Mathf.FloorToInt( projection.y / tileSize.y );
		return column + row * columns;
	}
}
