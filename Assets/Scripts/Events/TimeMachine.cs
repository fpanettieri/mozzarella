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
	public bool rewind;
	public float now;
	public float scale;
	public int nextIdx;
	private Timeline timeline;
	
	public void Start ()
	{
		rewind = false;
		now = 0;
		scale = 1;
		nextIdx = 0;
		timeline = GetComponent<Timeline> ();
	}
	
	public void Update ()
	{
		// TODO: remove this, debug only
		if (Input.GetKey (KeyCode.Space) != rewind) {
			Debug.Log ("Changing time flow");
			nextIdx = Mathf.Clamp (nextIdx, 0, timeline.count - 1);
		}
		
		rewind = Input.GetKey (KeyCode.Space);
		now += Time.deltaTime * scale * (rewind ? -1 : 1);
		if (now < 0) {
			now = 0;
		}
		
		if (rewind) {
			MoveBackward ();
		} else { 
			MoveForward (); 
		}
	}
	
	private void MoveForward ()
	{
		if (timeline.count < 1 || nextIdx >= timeline.count) {
			return;
		}
		
		for (int i = nextIdx; i < timeline.count; i++) {
			if (timeline [i].time > now) {
				break;
				
			} else {
				Events.i.Notify (timeline [i]);
				nextIdx++;
			}
		}
	}
	
	private void MoveBackward ()
	{
		if (timeline.count < 1 || nextIdx < 0) {
			return;
		}
		
		for (int i = nextIdx; i >= 0; i--) {
			if (timeline [i].time < now) {
				break;
				
			} else {
				Events.i.Notify (timeline [i]);
				nextIdx--;
			}
		}
	}
	
	//FIXME: check if used
	private void SortTimeline ()
	{
		if (timeline.count < 1) {
			return;
		}
		float time = timeline [nextIdx].time;
		timeline.Sort ();
		nextIdx = timeline.Find (time, nextIdx);
	}
}
