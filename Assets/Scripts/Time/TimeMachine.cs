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
	public int fps = 60;

	public static bool paused = false;
	public static bool skip = false;
	public static bool rewind;
	public static int frame;
	public static int idx;

	private Timeline timeline;
	private MozEvent ev;
	
	public void Start()
	{
		Application.targetFrameRate = fps;

		paused = true;
		skip = false;
		rewind = false;
		frame = 0;
		idx = 0;
		timeline = GetComponent<Timeline>();
	}

	public void Update()
	{
		// FIXME: cheat code used to debug behaviour
		skip = false;

		// FIXME: Remove cheat
		if(paused) {
			skip = true;
			return;
			
		} else {
			rewind = Input.GetKey(KeyCode.Space) || Input.GetMouseButton(1);
		}

		frame += rewind ? -1 : 1;
		if(frame < 0) {
			frame = 0;
		}
		
		if(timeline.count < 1) {
			return;
		} else if(rewind) {
			MoveBackward();
		} else { 
			MoveForward(); 
		}
	}

	public void Broadcast(MozEvent e)
	{
		timeline.Insert(idx, e);
		Events.i.Notify(e);
		if(!rewind){ ++idx; }
	}

	public void SmartBroadcast(MozEvent e)
	{
		timeline.SmartInsert(idx, e);
		Events.i.Notify(e);
		if(!rewind){ ++idx; }
	}
	
	private void MoveForward()
	{
		if(idx < 0) {
			idx = 0;
		}

		while(idx < timeline.count) {
			ev = timeline[idx];
			if(ev.frame < frame) {
				++idx;
			} else if(ev.frame == frame) {
				if(ev.enabled) {
					Events.i.Notify(ev);
				}
				++idx;
			} else if(ev.frame > frame) {
				break;
			}
		}
	}

	private void MoveBackward()
	{
		if(idx >= timeline.count) {
			idx = timeline.count - 1;
		}

		while(idx >= 0) {
			ev = timeline[idx];
			if(ev.frame > frame + 1) {
				--idx;
			} else if(ev.frame == frame + 1) {
				if(ev.enabled) {
					Events.i.Notify(ev);
				}
				--idx;
			} else if(ev.frame < frame + 1) {
				break;
			}
		}
	}
}
