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
public class LevelDesigner : EditorWindow
{
	
	private const int 		OPTIONS_WIDTH = 250;
	private const int 		GRID_PADDING = 10;
	
	// The grid being configured
	private Grid			grid = null;
	
	// General grid configuration
	private bool			configured = false;
	private string 			rowsTxt = "0";
	private string			columnsTxt = "0";
	
	// Piece selection
	private string[]		typeNames = null;
	private Vector2 		typeScroll = Vector2.zero;
	private int 			selectedIndex = 0;
	private int				selectedType = PieceType.Empty;
	
	// Grid visual editor
	private	Rect			gridRect = new Rect (0, 0, 0, 0);
	private	IntVector2		tileSize = IntVector2.zero;
	private Color 			tileBaseColor = Color.white;
	private Texture2D 		tileTex = null;
	
	// Grid edition
	private Event 			currentEvent = null;
	private bool			mouseDown = false;
	private int				mouseButton = 0;
	private int 			row = 0;
	private int 			column = 0;
	private bool			dirty = false;
	
	void OnEnable ()
	{
		typeNames = PieceType.Names;
		wantsMouseMove = false;
		FindGrid ();
	}
	
	void OnGUI ()
	{
		EditorGUILayout.BeginHorizontal ();
		LeftPanel ();
		RightPanel ();
		EditorGUILayout.EndHorizontal ();
	}
		
	private void LeftPanel ()
	{
		EditorGUILayout.BeginVertical (GUILayout.MaxWidth (OPTIONS_WIDTH));
		GridSetupPanel ();
		EditorGUILayout.Separator ();
		PiecesListPanel ();
		EditorGUILayout.Separator ();
		EditorGUILayout.EndVertical ();
	}
	
	private void GridSetupPanel ()
	{
		EditorGUILayout.LabelField ("Grid dimension", EditorStyles.boldLabel);
		rowsTxt = EditorGUILayout.TextField ("Rows", rowsTxt);
		columnsTxt = EditorGUILayout.TextField ("Columns", columnsTxt);
		
		if (GUILayout.Button ("Edit grid")) {
			EditGrid ();
		}
		if (GUILayout.Button ("Clean grid")) {
			CleanGrid ();
		}
		
		EditorGUILayout.Separator ();
		
		if (GUILayout.Button ("Create pieces")) {
			CreatePieces ();
		}
		if (GUILayout.Button ("Destroy pieces")) {
			DestroyPieces ();
		}
	}
		
	private void PiecesListPanel ()
	{
		EditorGUILayout.LabelField ("Piece types", EditorStyles.boldLabel);
		typeScroll = EditorGUILayout.BeginScrollView (typeScroll);
		selectedIndex = GUILayout.SelectionGrid (selectedIndex, typeNames, 1);
		selectedType = selectedIndex;
		EditorGUILayout.EndScrollView ();
	}
			
	private void RightPanel ()
	{
		if (!configured || grid.cells == null) {
			return;
		}
		GUI.Box (gridRect, "");
		HandleInput ();
		
		for (int i = 0; i < grid.columns; i++) {
			for (int j = 0; j < grid.rows; j++) {
				
				GUI.color = PieceColor.getColor (grid.cells [i + j * grid.columns]);
				GUI.DrawTexture (new Rect (
					gridRect.x + tileSize.x * i,
					gridRect.y + tileSize.y * (grid.rows - j - 1),
					tileSize.x, tileSize.y				
				), tileTex);
				
			}
		}
		
		GUI.color = Color.white;
		RenderGrid ();
	}
		
	private void EditGrid ()
	{
		CreateCells ();
		CreateTile ();		
		configured = true;
	}
	
	/**
	 * Clean the grid
	 */ 
	private void CleanGrid ()
	{
		for (int i = 0; i < grid.cells.Length; i++) {
			grid.cells [i] = PieceType.Empty;
		}
	}
	
	private void HandleInput ()
	{
		currentEvent = Event.current;
		if (currentEvent.isMouse && currentEvent.type == EventType.MouseDown) {
			mouseDown = true;
			mouseButton = currentEvent.button;
		} else if (currentEvent.isMouse && currentEvent.type == EventType.MouseUp) {
			mouseDown = false;
		}
		if (mouseDown) {
			SetPiece (mouseButton == 0 ? selectedType : PieceType.Empty, currentEvent.mousePosition, grid.cells);
		}
	}

	private void SetPiece (int type, Vector2 mousePosition, int[] cells)
	{
		if (!InsidePuzzleArea (mousePosition)) {
			return;
		}
		row = Mathf.FloorToInt ((position.height - mousePosition.y - GRID_PADDING) / tileSize.y);
		column = Mathf.FloorToInt ((mousePosition.x - OPTIONS_WIDTH - GRID_PADDING) / tileSize.x);
		try {
			grid.cells [column + row * grid.columns] = type;
		} catch (System.IndexOutOfRangeException e) {
			Debug.Log (e);
		}
		dirty = true;
	}
	
	private bool InsidePuzzleArea (Vector2 mousePosition)
	{
		return 	mousePosition.x > OPTIONS_WIDTH + GRID_PADDING &&
				mousePosition.x < position.width - GRID_PADDING &&
				mousePosition.y > GRID_PADDING &&
				mousePosition.y < position.height - GRID_PADDING;
	}
	
	private void FindGrid ()
	{
		GameObject go = GameObject.Find (MozGameObject.GRID);
		if (go == null) {
			return;
		}
		grid = go.GetComponent<Grid> ();
		if (grid == null) {
			Debug.LogWarning ("Grid not found. You should create a grid first");
		} else {
			rowsTxt = grid.rows.ToString ();
			columnsTxt = grid.columns.ToString ();
		}
	}
	
	private void RenderGrid ()
	{
		if (dirty) {
			dirty = false;
			Repaint ();
		}
	}
	
	/**
	 * Create grid objects to test the level
	 */ 
	private void CreatePieces ()
	{
		GameObject piecePrefab = grid.piecePrefab;
		MeshFilter filter = piecePrefab.GetComponent<MeshFilter> ();
		Vector3 pieceSize = filter.sharedMesh.bounds.size;
		
		for (int i = 0; i < grid.columns; i++) {
			for (int j = 0; j < grid.rows; j++) {
				int type = grid.cells [i + j * grid.columns];
				if (type == PieceType.Empty) {
					continue;
				}
				
				GameObject piece = (GameObject)Instantiate (piecePrefab);
				piece.name = "Piece";
				piece.transform.parent = grid.transform;
				piece.transform.localPosition = new Vector3 (i * pieceSize.x, j * pieceSize.y, 0);
				
				MeshRenderer renderer = piece.GetComponent<MeshRenderer> ();
				renderer.material = PieceMaterial.getMaterial (type);
				
				Piece mozPiece = piece.GetComponent<Piece> ();
				mozPiece.type = type;
				mozPiece.moving = false;
			}
		}
	}
	
	private void DestroyPieces ()
	{
		for (int i = grid.transform.childCount - 1; i >= 0; i--) {
			DestroyImmediate (grid.transform.GetChild (i).gameObject);
		}
	}
	
	/**
	 * Create and initialize grid cells if they dont exist already
	 */
	private void CreateCells ()
	{
		if (grid.cells == null || grid.cells.Length == 0 || 
			grid.rows != int.Parse (rowsTxt) || grid.columns != int.Parse (columnsTxt)) {
			
			grid.rows = int.Parse (rowsTxt);
			grid.columns = int.Parse (columnsTxt);
			grid.cells = new int[ grid.rows * grid.columns ];
			
			for (int i = 0; i < grid.columns; i++) {	
				for (int j = 0; j < grid.rows; j++) {
					grid.cells [i + j * grid.columns] = PieceType.Empty;
				}
			}
			
		}
	}
	
	/**
	 * Create empty tile
	 */ 
	private void CreateTile ()
	{
		gridRect = new Rect (
			OPTIONS_WIDTH + GRID_PADDING,
			GRID_PADDING,
			position.width - OPTIONS_WIDTH - GRID_PADDING * 2, 
			position.height - GRID_PADDING * 2
		);
		
		tileSize = new IntVector2 (gridRect.width / grid.columns, gridRect.height / grid.rows);
		tileTex = new Texture2D (tileSize.x, tileSize.y);
		for (int i = 0; i < tileSize.x; i++) {
			for (int j = 0; j < tileSize.y; j++) {
				tileTex.SetPixel (i, j, tileBaseColor);
			}
		}
		tileTex.Apply ();
	}
}
