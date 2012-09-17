/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-08-30
 @last-edit		2012-09-02
===============================================================================
*/

using UnityEditor;
using UnityEngine;

/**
 * Displays a user friendly level editor for mozzarella
 */ 
public class MozLevelDesigner : EditorWindow {
	
	private const int 		OPTIONS_WIDTH 	= 250;
	private const int 		GRID_PADDING 	= 10;
	
	// General grid configuration
	private bool			configured		= false;
	private string 			rowsTxt			= "0";
	private string			columnsTxt 		= "0";
	
	// Piece selection
	private string[]		typeNames 		= null;
	private Vector2 		typeScroll 		= Vector2.zero;
	private int 			selectedIndex 	= 0;
	private PieceType		selectedType 	= PieceType.PlainBlue;
	
	
	private MozGrid			grid			= null;
	private PieceType[,]	cells			= null;
	
	private	Rect			gridRect		= new Rect(0, 0, 0, 0);
	private	IntVector2		tileSize		= IntVector2.zero;
	private Color 			tileBaseColor	= Color.white;
	private Texture2D 		tileTex			= null;
	
	// Grid edition
	private Event 			currentEvent	= null;
	private bool			mouseDown		= false;
	private int				mouseButton		= 0;
	private int 			row				= 0;
	private int 			column			= 0;
	private bool			dirty			= false;
	
	void OnEnable(){
		typeNames = System.Enum.GetNames( typeof( PieceType ) );
		wantsMouseMove = false;
		grid = GameObject.Find( MozGameObject.GRID ).GetComponent<MozGrid>();
		rowsTxt = grid.rows.ToString();
		columnsTxt = grid.columns.ToString();
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
		EditorGUILayout.Separator();
		LevelPanel();
		EditorGUILayout.Separator();
		EditorGUILayout.EndVertical();
	}
	
	private void LevelPanel() {
		EditorGUILayout.LabelField("Level", EditorStyles.boldLabel);
		if( GUILayout.Button( "Create grid" ) ){
			CreateGrid();
		}
	}
			
	private void GridSetupPanel(){
		EditorGUILayout.LabelField("Configure grid", EditorStyles.boldLabel);
		rowsTxt = EditorGUILayout.TextField( "Rows", rowsTxt );
		columnsTxt = EditorGUILayout.TextField( "Columns", columnsTxt );
		
		if( GUILayout.Button( "Edit grid" ) ){
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
		if( !configured || cells == null ){
			return;
		}
		GUI.Box( gridRect, "" );
		HandleInput();
		
		for( int i = 0; i < grid.rows; i++ ){
			for( int j = 0; j < grid.columns; j++ ){
				
				GUI.color = PieceColor.getColor( cells[i,j] );
				GUI.DrawTexture( new Rect(
					gridRect.x + tileSize.x * j,
					gridRect.y + tileSize.y * i,
					tileSize.x, tileSize.y				
				), tileTex );
				
			}
		}
		
		GUI.color = Color.white;
		RenderGrid();
	}
		
	private void GenerateGrid() {
		grid = GameObject.Find( MozGameObject.GRID ).GetComponent<MozGrid>();
		
		gridRect = new Rect(
			OPTIONS_WIDTH + GRID_PADDING,
			GRID_PADDING,
			position.width - OPTIONS_WIDTH - GRID_PADDING * 2, 
			position.height - GRID_PADDING * 2
		);

		int.TryParse(rowsTxt, out grid.rows);
		int.TryParse(columnsTxt, out grid.columns);
		
		// create grid
		cells = new PieceType[ grid.rows, grid.columns ];
		for( int i = 0; i < grid.rows; i++ ){
			for( int j = 0; j < grid.columns; j++ ){
				cells[ i, j ] = PieceType.Empty;
			}
		}
		
		// create tile
		tileSize = new IntVector2( gridRect.width / grid.columns, gridRect.height / grid.rows );
		tileTex = new Texture2D(tileSize.x, tileSize.y);
		for( int i = 0; i < tileSize.x; i++ ){
			for( int j = 0; j < tileSize.y; j++ ){
				tileTex.SetPixel(i, j, tileBaseColor);
			}
		}
		tileTex.Apply();
		
		configured = true;
	}
	
	private void HandleInput(){
		currentEvent = Event.current;
		if ( currentEvent.isMouse && currentEvent.type == EventType.MouseDown ) {
			mouseDown = true;
			mouseButton = currentEvent.button;
		} else if ( currentEvent.isMouse && currentEvent.type == EventType.MouseUp ){
			mouseDown = false;
		}
		if( mouseDown ){
			SetPiece( mouseButton == 0 ? selectedType : PieceType.Empty, currentEvent.mousePosition, cells );
		}
	}

	private void SetPiece( PieceType type, Vector2 mousePosition, PieceType[,] cells ){
		if( !InsidePuzzleArea( mousePosition ) ){
			return;
		}
		row = Mathf.FloorToInt(( mousePosition.y - GRID_PADDING ) / tileSize.y );
		column = Mathf.FloorToInt(( mousePosition.x - OPTIONS_WIDTH - GRID_PADDING ) / tileSize.x );
		try{
			cells[row, column] = type;
		} catch ( System.IndexOutOfRangeException e ) {
			Debug.Log(e);
		}
		dirty = true;
	}
	
	private bool InsidePuzzleArea( Vector2 mousePosition ){
		return 	mousePosition.x > OPTIONS_WIDTH + GRID_PADDING &&
				mousePosition.x < position.width - GRID_PADDING &&
				mousePosition.y > GRID_PADDING &&
				mousePosition.y < position.height - GRID_PADDING;
	}
	
	private void RenderGrid(){
		if( dirty ){
			dirty = false;
			Repaint();
		}
	}
	
	/**
	 * Create grid objects to test the level
	 */ 
	private void CreateGrid(){
		GameObject piecePrefab = grid.piecePrefab;
		MeshFilter filter = piecePrefab.GetComponent<MeshFilter>();
		Vector3 pieceSize = filter.sharedMesh.bounds.size;
		
		for( int i = 0; i < grid.rows; i++ ){
			for( int j = 0; j < grid.columns; j++ ){
				PieceType type = cells[i, j];
				if( type == PieceType.Empty ){ continue; }
				GameObject piece = (GameObject)Instantiate(piecePrefab);
				piece.name = "Piece";
				piece.transform.parent = grid.transform;
				piece.transform.localPosition = new Vector3( j * pieceSize.x, ( grid.rows - i - 1 ) * pieceSize.y, 0 );
				MeshRenderer renderer = piece.GetComponent<MeshRenderer>();
				renderer.material = PieceMaterial.getMaterial( type );
			}
		}
	}
	
}
