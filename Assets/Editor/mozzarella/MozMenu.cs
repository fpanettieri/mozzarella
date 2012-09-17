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
		GameObject go = GameObject.Find( MozGameObject.CONFIGURATION );
		if( go == null ){
			go = new GameObject( MozGameObject.CONFIGURATION );
		}
		Component cfg = go.GetComponent<MozConfiguration>();
		if( cfg == null ){
			cfg = go.AddComponent<MozConfiguration>();
		}
	}
	
	[MenuItem("Mozzarella/Create grid")]
	public static void CreateGrid() {
		GameObject go = GameObject.Find( MozGameObject.GRID );
		if( go == null ){
			go = new GameObject( MozGameObject.GRID );
		}
		Component grid = go.GetComponent<MozGrid>();
		if( grid == null ){
			grid = go.AddComponent<MozGrid>();
		}
	}
		
	[MenuItem("Mozzarella/Level designer")]
	public static void LevelDesigner() {
		EditorWindow.GetWindow( typeof( MozLevelDesigner ), false, "Level designer" );
	}
	
	[MenuItem("Mozzarella/Piece Mesh Wizard")]
    static void PieceMeshWizard()
    {
        ScriptableWizard.DisplayWizard( "Piece Mesh Wizard", typeof( MozPieceWizard ) );
    }

}
