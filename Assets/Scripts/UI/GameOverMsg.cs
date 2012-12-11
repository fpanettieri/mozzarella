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

public class GameOverMsg: MonoBehaviour, IEventListener
{
	public void Start()
	{
		Events.i.Register(MozEventType.GameOver, this);
	}

	public void Notify(MozEvent e)
	{
		TimeMachine.paused = true;
		guiText.enabled = true;
	}
}
