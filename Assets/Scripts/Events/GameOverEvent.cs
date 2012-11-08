/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

public class GameOverEvent : MozEvent
{
	public GameOverEvent()
	{
		this.initial = "GO";
		this.type = MozEventType.GameOver;
	}
	
	override public string ToString()
	{
		return "GameOverEvent";
	}
}

	