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

public class Replay: MonoBehaviour
{
	public void Update()
	{
		if(Input.GetKeyDown(KeyCode.R)){
			Events.i.Destroy();
			Application.LoadLevel(Application.loadedLevel);
		}
	}

}
