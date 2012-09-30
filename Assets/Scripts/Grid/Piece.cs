/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

public class Piece : MonoBehaviour
{
	
	public int type = 0;
	public bool moving = false;
	public float speed = -100.0f;

	void Awake ()
	{
		
	}
	
	void Update ()
	{
		
	}
	
	/**
	 * Returns the position where the piece will go if moved
	 */ 
	public void Project (ref Vector3 projection)
	{
		projection.Set (
			transform.localPosition.x,
			transform.localPosition.y + speed * Time.deltaTime,
			transform.localPosition.z);
	}	
}
