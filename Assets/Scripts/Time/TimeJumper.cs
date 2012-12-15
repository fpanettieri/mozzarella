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
	private const int BACKWARD_DELAY = 30;
	private const int FORWARD_DELAY = 60;

	private Timeline timeline;
	private int delay;

	// This class is used for debug purpouses.
	// It makes the game skip frames when going back, to
	public void Start()
	{
		timeline = GetComponent<Timeline>();
		Events.i.Register(MozEventType.PieceLock, this);
		Events.i.Register(MozEventType.PieceSpawn, this);

		delay = BACKWARD_DELAY;
	}

	public void Notify(MozEvent e)
	{
		if(!TimeMachine.rewind) { return; }
		delay = BACKWARD_DELAY;
	}

	public void Update()
	{
		// FIXME: cheat used to skip frames
		if(TimeMachine.skip) { return; }

		if( --delay < 0 ){
			if(TimeMachine.rewind){
				delay = BACKWARD_DELAY;
				if(TimeMachine.idx > 0){
					TimeMachine.frame = timeline[TimeMachine.idx].frame + 1;
				} else if(timeline.count == 0) {
					TimeMachine.frame = 0;
				}
			} else {
				delay = BACKWARD_DELAY;
				//if(TimeMachine.idx < timeline.count - 1){
				//	TimeMachine.frame = timeline[TimeMachine.idx + 1].frame - 1;
				//}
			}
		}
	}
}

