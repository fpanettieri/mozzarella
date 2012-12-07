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
	// injected dependency
	private PointsMeter meter;

	public int points = 1;

	private Vector2 direction;
	private float rotation;
	private float explotion;
	private float decay = 0.1f;

	private Vector3 position;
	private float collection;
	private float acceleration = 0.1f;
	private float distance;

	void Start()
	{
		meter = GameObject.FindGameObjectWithTag("PointsMeter").GetComponent<PointsMeter>();

		direction = new Vector2(Random.Range(-3, 3), Random.Range(-3, 3));
		explotion = Random.Range(2, 4);
		rotation = Random.Range(0, Mathf.PI * 2);

		collection = Random.Range(3, 5);
		distance = collection;
	}

	void Update()
	{
		if(explotion > 0){
			explotion -= decay;

			transform.Translate(direction * explotion, Space.World);
			transform.Rotate(0, 0, rotation * explotion);
			if(explotion <= 0){ position = transform.position; }

		} else if(distance > 0){
			distance -= acceleration;
			transform.position = Vector3.Lerp(meter.top, position, distance / collection);

		} else if(distance <= 0){
			meter.AddPoints(points);
			Destroy(gameObject);
		}
	}
}
