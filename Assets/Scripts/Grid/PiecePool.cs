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

public class PiecePool : MonoBehaviour
{
	private Grid grid;
	private int idx;
	private int count;
	private Piece[] pieces;
	private bool[] available;
	
	public void Start()
	{
		grid = GetComponent<Grid>();
		
		idx = 0;
		count = grid.rows * grid.columns;
		pieces = new Piece[count];
		available = new bool[count];
		
		GameObject go;
		Piece piece;
		for(int i = 0; i < count; i++) {
			go = Instantiate(grid.piecePrefab) as GameObject;
			go.transform.parent = grid.transform;
			
			piece = go.GetComponent<Piece>();
			piece.Disable();
			piece.name = "Piece";
			piece.id = i;
			piece.moving = false;
			pieces[i] = piece;
			available[i] = true;
		}
	}
	
	public Piece Pick()
	{
		for(int i = idx; i < available.Length; i++) {
			if(available[i]) {
				idx = i;
				available[i] = false;
				return pieces[i];
			}
		}
		idx = count - 1;
		return null;
	}
	
	public void Release(int idx)
	{
		available[idx] = true;
		if(idx < this.idx) {
			this.idx = idx;
		}
	}
	
	public Piece this[int i] {
		get { return pieces[i]; }
	}
}
