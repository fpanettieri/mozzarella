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
	public static long deltaTime { get { return rewind ? -1 : 1; } }
	
	public static bool rewind;
	public static long now;
	public static int scale;
	public static int idx;
	private Timeline timeline;
	private MozEvent ev;
	
	public void Awake()
	{
		rewind = false;
		now = 0;
		scale = 1;
		idx = 0;
		timeline = GetComponent<Timeline>();
	}

	public void Update()
	{
		rewind = Input.GetKey(KeyCode.Space);
		now += deltaTime;
		
		// FIXME: Configure time scale, make it adaptable maybe?
		scale = rewind ? 2 : 2;
		if(now < 0) {
			now = 0;
		}
		
		if(timeline.count < 1) {
			return;
		} else if(rewind) {
			MoveBackward();
		} else { 
			MoveForward(); 
		}
	}
	
	private void MoveForward()
	{
		if(idx < 0) {
			idx = 0;
		}
		while(idx < timeline.count) {
			ev = timeline[idx];
			if(ev.time > now) {
				break;
				
			} else {
				idx++;
				if(ev.enabled) { Events.i.Notify(ev); }
			}
		}
	}

	private void MoveBackward()
	{
		while(idx > 0) {
			ev = timeline[idx - 1];
			if(ev.time < now) {
				break;

			} else {
				idx--;
				if(ev.enabled) { Events.i.Notify(ev); }
			}
		}
	}
}
