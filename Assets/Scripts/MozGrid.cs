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
using System.Collections;

public class MozGrid : MonoBehaviour {
	
	public GameObject piecePrefab;
	public int rows = 0;
	public int columns = 0;
	public int[] cells;
	
	void Start () {
		string str = "";
		for( int i = 0; i < columns; i++ ){
			for( int j = 0; j < rows; j++ ){
				str += cells[ i + j * columns ];
			}
		}
		Debug.Log( str );
	}
	
	void Update () {
	
	}
}
