/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-09-29
 @last-edit		2012-09-29
===============================================================================
*/
using UnityEngine;
using System.Collections;

/**
 * This class handles the input of the grid.
 * It dispatch piece spawn events or group break events.
 */ 
public class MozGridInput : MonoBehaviour
{
	public int bottom;
	public int left;
	public int top;
	public int right;
	
	public int cellWidth;
	public int cellHeight;
	
	private IntVector2 cell;
	private MozTimeline timeline;
	private MozTimeMachine machine;

	void Start () {
		cell = new IntVector2(0, 0);
		timeline = GetComponent<MozTimeline>();
		machine = GetComponent<MozTimeMachine>();
	}
	
	void Update () {
		// TODO: verify if the space is ocuppied on mouse down, not mouseup.
		// if( grid.cells[ cell.x + cell.y * grid.columns ] == PieceType.Empty ){
		
		if( Input.GetMouseButtonUp(0) && InsideGrid( Input.mousePosition ) ) {
			cell.Set( Mathf.FloorToInt(( Input.mousePosition.x - left ) / cellWidth), Mathf.FloorToInt((Input.mousePosition.y - bottom ) / cellHeight));
			timeline.Add( new MozSpawnPieceEvent( machine.now, cell.y, cell.x ) );
		}
	}
	
	private bool InsideGrid( Vector3 v ) {
		return v.x > left && v.x < right && v.y > bottom && v.y < top;
	}
}
