/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;
using System.Collections.Generic;

public class TimeJumper : MonoBehaviour, IEventListener
{
	private const int MAX_DELAY = 30;

	private Timeline timeline;
	private int delay;

	// This class is used for debug purpouses.
	// It makes the game skip frames when going back, to
	public void Start()
	{
		timeline = GetComponent<Timeline>();
		Events.i.Register(MozEventType.PieceLock, this);
		Events.i.Register(MozEventType.PieceSpawn, this);

		delay = MAX_DELAY;
	}

	public void Notify(MozEvent e)
	{
		if(!TimeMachine.rewind) { return; }
		delay = MAX_DELAY;
	}

	public void Update()
	{
		// FIXME: cheat used to skip frames
		if(TimeMachine.skip) { return; }

		if(TimeMachine.rewind){
			if( --delay < 0 ){
				delay = MAX_DELAY;
				if(TimeMachine.idx > 0){
					TimeMachine.frame = timeline[TimeMachine.idx].frame + 1;
				}
				Cheats.DebugTimeline();
			}

		} else {
			delay = MAX_DELAY;
		}
	}
}

