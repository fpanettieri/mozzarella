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

/**
 * Cronological list of events
 */
public class Timeline : MonoBehaviour
{
	private List<MozEvent> events;
	
	public MozEvent this[int i] {
		get { return events[i]; }
		set { events[i] = value; }
	}
	
	public int count { get { return events.Count; } }
	
	public void Awake()
	{
		events = new List<MozEvent>();
	}
	
	public void Add(MozEvent e)
	{
		events.Add(e);
	}

	public void Insert(int index, MozEvent e)
	{
		events.Insert(index, e);
	}

	// Find the right index to insert the event
	public void SmartInsert(int index, MozEvent e)
	{
		events.Insert(Find(e.frame, index), e);
	}

	public void Purge(int piece, bool spawned, bool locked)
	{
		bool spawnFound = !spawned;
		bool lockFound = !locked;

		PieceEvent ev;
		for(int i = events.Count - 1; i >= 0; i--){
			ev = events[i] as PieceEvent;
			if(ev.id == piece){
				if(!lockFound && ev is PieceLockEvent){ lockFound = true; }
				else if(!spawnFound && ev is PieceSpawnEvent){ spawnFound = true; }
				Remove(i);
				if(spawnFound && lockFound){ return; }
			}
		}
	}

	public void Remove(MozEvent e)
	{
		Remove(events.IndexOf(e));
	}

	public void Remove(int idx)
	{
		if(idx < TimeMachine.idx) { TimeMachine.idx--; }
		events.RemoveAt(idx);
	}
	
	public void Sort()
	{
		events.Sort();
	}
	
	/**
	 * DEPRECATED:
	 * Given a specific point in time, find the next event
	 */ 
	public int Find(int frame)
	{
		for(int i = 0; i < events.Count - 1; i++) {
			if(events[i].frame >= frame) {
				return i;
			}
		}
		return 0;
	}
	
	/**
	 * DEPRECATED:
	 * Optimized event search
	 */ 
	public int Find(int frame, int idx)
	{
		// In case of out of bounds idx, do a linear search
		if(idx < 0 || idx >= events.Count) {
			return Find(frame);
		}
		
		if(frame < events[idx].frame) {
			for(int i = idx; i < events.Count - 1; i++) {
				if(events[i].frame >= frame) {
					return i;
				}	
			}
		} else {
			for(int i = idx; i >= 0; i--) {
				if(events[i].frame < frame) {
					return i + 1;
				}
			}
		}
		return 0;
	}

	override public string ToString()
	{
		string str = "F " + TimeMachine.frame + "\n";
		for(int i = 0; i < events.Count; i++) {
			str += TimeMachine.idx == i ? ">" : ":";
			str += events[i].initial + " " + events[i].frame + "\n";
		}
		return str;
	}
}
