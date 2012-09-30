/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEditor;
using UnityEngine;

/**
 * Create menu entries
 */ 
public class Menu : EditorWindow
{	
	[MenuItem("Mozzarella/Create grid")]
	public static void CreateGrid ()
	{
		GameObject go = GameObject.Find (GameObjectName.GRID);
		if (go == null) {
			go = new GameObject (GameObjectName.GRID);
		}
		Component grid = go.GetComponent<Grid> ();
		if (grid == null) {
			grid = go.AddComponent<Grid> ();
		}
	}
		
	[MenuItem("Mozzarella/Level designer")]
	public static void LevelDesigner ()
	{
		EditorWindow.GetWindow (typeof(LevelDesigner), false, "Level designer");
	}
	
	[MenuItem("Mozzarella/Piece Mesh Wizard")]
	static void PieceMeshWizard ()
	{
		ScriptableWizard.DisplayWizard ("Piece Mesh Wizard", typeof(PieceWizard));
	}

}
