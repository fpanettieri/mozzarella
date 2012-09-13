/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-08-30
 @last-edit		2012-08-30
===============================================================================
*/

using UnityEngine;

public class MozPiece : MonoBehaviour {
	
	public bool falling = false;
	public float speed = -100.0f;
	
	void Awake() {
		
	}
	
	// Update is called once per frame
	void Update() {
		if( falling ){
			transform.Translate(0, speed * Time.deltaTime, 0 );
		}
	}
	
}
