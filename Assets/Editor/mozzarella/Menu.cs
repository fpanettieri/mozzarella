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
public class Menu : EditorWindow
{	
	[MenuItem("Mozzarella/Create grid")]
	public static void CreateGrid ()
	{
		GameObject go = GameObject.Find (MozGameObject.GRID);
		if (go == null) {
			go = new GameObject (MozGameObject.GRID);
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
