/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;
using System.Collections;

public class Countdown : MonoBehaviour
{
	public float time = 60;
	public float fps = 60;

	private float max;
	private float second;

	public void Start()
	{
		max = time * fps;
		second = (max - TimeMachine.frame) / fps;
		guiText.text = second.ToString("00.0");
	}

	public void Update()
	{
		// FIXME: cheat used to skip frames
		if(TimeMachine.skip) { return; }

		second = (max - TimeMachine.frame) / fps;
		if (second <= 0){
			second = 0;
			Events.i.Notify(new GameOverEvent());
		}
		guiText.text = second.ToString("00.0");
	}
}
