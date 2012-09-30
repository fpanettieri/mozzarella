/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

/**
 * This class moves through the timeline, dispatching active events.
 */ 
public class TimeMachine : MonoBehaviour
{
	private float _now;

	public float now { get { return _now; } }
	
	void Start ()
	{
		_now = 0;
	}
}
