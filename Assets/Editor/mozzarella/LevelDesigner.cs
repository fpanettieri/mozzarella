/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-08-30
 @last-edit		2012-08-30
===============================================================================
*/

using UnityEditor;
using UnityEngine;

namespace Mozzarella {

/**
 * Displays a user firendly level editor for mozzarella
 */ 
public class LevelDesigner : EditorWindow {
	
	private const int 		OPTIONS_WIDTH 	= 250;
	private const int 		GRID_PADDING 	= 10;
			
	private int 			rows 			= 5;
	private int 			columns 		= 10;
	
	private string[]		typeNames 		= null;
	private Vector2 		typeScroll 		= new Vector2(0, 0);
	private int 			selectedIndex 	= 0;
	private PieceType		selectedType 	= PieceType.PlainBlue;
	
	[MenuItem("Mozzarella/Level editor")]
	public static void ShowWindow() {
		EditorWindow.GetWindow( typeof( LevelDesigner ), false, "Level editor" );
	}
	
	void OnFocus(){
		typeNames = System.Enum.GetNames( typeof( PieceType ) );
	}
	
	void OnGUI(){
		EditorGUILayout.BeginHorizontal();
		LeftPanel();
		RightPanel();
		EditorGUILayout.EndHorizontal();
	}
		
	private void LeftPanel(){
		EditorGUILayout.BeginVertical( GUILayout.MaxWidth( OPTIONS_WIDTH ) );
		GridSetupPanel();
		EditorGUILayout.Separator();
		PiecesListPanel();
		EditorGUILayout.EndVertical();
	}
			
	private void GridSetupPanel(){
		EditorGUILayout.LabelField("Configure grid", EditorStyles.boldLabel);
		EditorGUILayout.TextField( "Rows", rows.ToString());
		EditorGUILayout.TextField( "Columns", columns.ToString());
		
		if( GUILayout.Button( "Generate" ) ){
			GenerateGrid();
		}
	}
		
	private void PiecesListPanel(){
		EditorGUILayout.LabelField("Piece types", EditorStyles.boldLabel);
		typeScroll = EditorGUILayout.BeginScrollView( typeScroll );
		selectedIndex = GUILayout.SelectionGrid( selectedIndex, typeNames, 1 );
		selectedType = (PieceType)( System.Enum.Parse( typeof( PieceType ), typeNames[selectedIndex] ) );
		EditorGUILayout.EndScrollView();
	}
			
	private void RightPanel(){
	}
		
	private void GenerateGrid() {
		
	}
			
}

} // namespace Mozzarella