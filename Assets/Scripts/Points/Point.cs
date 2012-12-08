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

	private Vector3 movement;
	private float accel = 0.3f;
	private float speed = 1f;
	private float distance;

	void Start()
	{
		meter = GameObject.FindGameObjectWithTag("PointsMeter").GetComponent<PointsMeter>();

		direction = new Vector2(Random.Range(-4, 4), Random.Range(1, 4));
		explotion = Random.Range(1, 4);
		rotation = Random.Range(0, Mathf.PI * 2);
	}

	void Update()
	{
		distance = Vector3.Distance(transform.position, meter.top);

		if(explotion > 0){
			explotion -= decay;

			transform.Translate(direction * explotion, Space.World);
			transform.Rotate(0, 0, rotation * explotion);

		} else if(distance > 32){
			speed += accel;
			direction = (meter.top - transform.position).normalized;
			transform.Translate(direction * speed, Space.World);

		} else if(distance <= 32){
			meter.AddPoints(points);
			Destroy(gameObject);
		}
	}
}
