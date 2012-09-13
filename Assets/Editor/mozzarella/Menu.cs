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
	
	[MenuItem("Mozzarella/Configure game")]
	public static void ConfigureGame() {
		GameObject go = GameObject.Find( "MozConfiguration" );
		if( go == null ){
			go = new GameObject( "MozConfiguration" );
		}
		Component cfg = go.GetComponent<MozConfiguration>();
		if( cfg == null ){
			cfg = go.AddComponent<MozConfiguration>();
		}
	}
	
	[MenuItem("Mozzarella/Create grid")]
	public static void CreateGrid() {
		GameObject go = GameObject.Find( "MozGrid" );
		if( go == null ){
			go = new GameObject( "MozGrid" );
		}
		Component grid = go.GetComponent<MozGrid>();
		if( grid == null ){
			grid = go.AddComponent<MozGrid>();
		}
	}
		
	[MenuItem("Mozzarella/Level designer")]
	public static void LevelDesigner() {
		EditorWindow.GetWindow( typeof( LevelDesigner ), false, "Level designer" );
	}

}
