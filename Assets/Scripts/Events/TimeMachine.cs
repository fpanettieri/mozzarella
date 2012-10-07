/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

/**
 * This class moves through the timeline, dispatching active events.
 */ 
public class TimeMachine : MonoBehaviour
{
	public static float deltaTime { get { return Time.deltaTime * scale * (rewind ? -1 : 1); } }
	
	public static bool rewind;
	public static float now;
	public static float scale;
	public static int idx;
	private Timeline timeline;
	
	public void Awake ()
	{
		rewind = false;
		now = 0;
		scale = 1;
		idx = 0;
	}
	
	public void Start ()
	{
		timeline = GetComponent<Timeline> ();
	}
	
	public void Update ()
	{
		rewind = Input.GetKey (KeyCode.Space);
		now += deltaTime;
		
		// FIXME: Configure time scale, make it adaptable maybe?
		scale = rewind ? 3 : 1;
		if (now < 0) {
			now = 0;
		}
		
		if (timeline.count < 1) {
			return;
		} else if (rewind) {
			MoveBackward ();
		} else { 
			MoveForward (); 
		}
		
		Debug.Log("now " + now + " idx " + idx);
	}
	
	private void MoveForward ()
	{
		if( idx < 0) { idx = 0; }
		while (idx < timeline.count) {
			if (timeline [idx].time > now) {
				break;
			} else {
				if (timeline [idx].enabled) { Events.i.Notify (timeline [idx]); }
				idx++;
			}
		}
	}
	
	private void MoveBackward ()
	{
		while (idx > 0) {
			if (timeline [idx - 1].time < now) {
				break;
				
			} else {
				if (timeline [idx - 1].enabled) { Events.i.Notify (timeline [idx - 1]);	}
				idx--;
			}
		}
	}
}
