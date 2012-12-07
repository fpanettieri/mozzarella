/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

public class PiecePreview : MonoBehaviour
{
	// dependencies
	private PieceQueue queue;

	// internal state
	public int offset = 0;
	private int type = -1;

	// aux variables
	private int currentType;

	public void Start ()
	{
		queue = GameObject.Find(GameObjectName.GRID).GetComponent<PieceQueue>();
	}
	
	public void Update ()
	{
		currentType = queue.Peek(offset);
		if(type != currentType){
			type = currentType;
			renderer.material = PieceMaterial.getMaterial(type);
		}
	}
}
