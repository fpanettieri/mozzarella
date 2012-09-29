/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-09-29
 @last-edit		2012-09-29
===============================================================================
*/
using UnityEngine;

/**
 * This class moves through the timeline, dispatching active events.
 */ 
public class MozTimeMachine : MonoBehaviour
{
	private float _now;
	public float now { get { return _now; } }
	
	void Start ()
	{
		_now = 0;
	}
}
