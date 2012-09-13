/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-09-12
 @last-edit		2012-09-12
===============================================================================
*/

using UnityEditor;
using UnityEngine;

/**
 * Create menu entries
 */ 
public class Menu : EditorWindow {
	
	[MenuItem("Mozzarella/Create grid")]
	public static void CreateGrid() {
		GameObject grid = GameObject.Find( "MozGrid" );
		if( grid == null ){
			grid = new GameObject( "MozGrid" );
		}
		Component behaviour = grid.GetComponent<GridBehaviour>();
		if( behaviour == null ){
			behaviour = grid.AddComponent<GridBehaviour>();
		}
	}
		
	[MenuItem("Mozzarella/Level designer")]
	public static void ShowWindow() {
		EditorWindow.GetWindow( typeof( LevelDesigner ), false, "Level designer" );
	}

}
