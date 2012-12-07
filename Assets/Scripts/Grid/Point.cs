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

public class Point : MonoBehaviour
{
	private Vector2 direction;
	private float rotation;

	private float explotion;
	private float decay = 0.1f;

	void Start()
	{
		direction = new Vector2(Random.Range(-3, 3), Random.Range(-3, 3));
		explotion = Random.Range(2, 4);
		rotation = Random.Range(0, Mathf.PI * 2);
	}

	void Update()
	{
		if(explotion > 0){
			explotion -= decay;

			transform.Translate(direction * explotion, Space.World);
			transform.Rotate(0, 0, rotation * explotion);
		} else {
		}
	}
}
