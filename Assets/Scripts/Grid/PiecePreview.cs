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
	private MeshFilter filter;

	// internal state
	public int offset = 0;
	private int type = -1;

	// aux variables
	private int currentType;

	public void Start ()
	{
		queue = GameObject.Find(GameObjectName.GRID).GetComponent<PieceQueue>();
		filter = GetComponent<MeshFilter>();

		// FIXME: Create an object that creates the mesh based on the level size
		filter.mesh = Resources.Load("Meshes/Piece32x32") as Mesh;
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
