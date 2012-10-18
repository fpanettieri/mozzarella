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
	public int id = -1;
	public int type = 0;
	public bool moving = false;
	public float speed = -100.0f;
	
	public void Enable()
	{
		enabled = true;
		renderer.enabled = true;
	}
	
	public void Disable()
	{
		enabled = false;
		renderer.enabled = false;
	}
	
	/**
	 * Returns the position where the piece will go if moved
	 */ 
	public void Project(ref Vector3 projection)
	{
		projection.Set(
			transform.localPosition.x,
			transform.localPosition.y + speed * TimeMachine.deltaTime,
			transform.localPosition.z);
	}	
}
