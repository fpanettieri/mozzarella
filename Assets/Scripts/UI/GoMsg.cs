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

public class GoMsg: MonoBehaviour
{
	public void Start()
	{
		StartCoroutine(GoRoutine());
	}

	private IEnumerator GoRoutine()
	{
		guiText.text = "3";
		yield return new WaitForSeconds (1);

		guiText.text = "2";
		yield return new WaitForSeconds (1);


		guiText.text = "1";
		yield return new WaitForSeconds (1);

		TimeMachine.paused = false;
		Destroy(gameObject);
	}

}
